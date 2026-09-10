/**
 * Modern status footer: bright workspace/model context plus live git diff stats.
 * Loaded automatically from ~/.pi/agent/extensions.
 */
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent"
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui"

const REFRESH_MS = 800

type DiffStats = {
  added: number
  removed: number
  files: number
  dirty: boolean
}

function gitStats(cwd: string): DiffStats {
  try {
    const { execFileSync } = require("child_process")
    const output = String(
      execFileSync("git", ["diff", "HEAD", "--numstat"], {
        cwd,
        encoding: "utf8",
        stdio: ["ignore", "pipe", "ignore"],
      })
    )
    let added = 0,
      removed = 0,
      files = 0
    for (const line of output.trim().split("\n")) {
      if (!line) continue
      const [a, r] = line.split("\t")
      if (a === "-") continue // binary files
      added += Number(a) || 0
      removed += Number(r) || 0
      files++
    }
    // Include untracked files as a useful dirty signal without pretending we
    // know their line count (git diff cannot count files outside the index).
    const porcelain = String(
      execFileSync("git", ["status", "--porcelain"], {
        cwd,
        encoding: "utf8",
        stdio: ["ignore", "pipe", "ignore"],
      })
    )
    return { added, removed, files, dirty: Boolean(porcelain.trim()) }
  } catch {
    return { added: 0, removed: 0, files: 0, dirty: false }
  }
}

function formatTokens(n: number): string {
  if (n < 1000) return String(n)
  if (n < 1_000_000) return `${(n / 1000).toFixed(n < 10_000 ? 1 : 0)}k`
  return `${(n / 1_000_000).toFixed(1)}m`
}

export default function (pi: ExtensionAPI) {
  let working = false
  let cwd = process.cwd()
  let cached: DiffStats = { added: 0, removed: 0, files: 0, dirty: false }
  let lastRead = 0

  const refresh = (tui: { requestRender(): void }) => {
    const now = Date.now()
    if (now - lastRead < REFRESH_MS) return
    lastRead = now
    cached = gitStats(cwd)
    tui.requestRender()
  }

  pi.on("session_start", (_event, ctx) => {
    cwd = (ctx as typeof ctx & { cwd?: string }).cwd || process.cwd()
    ctx.ui.setFooter((tui, theme, footerData) => {
      const stopBranch = footerData.onBranchChange(() => {
        cached = gitStats(cwd)
        tui.requestRender()
      })

      return {
        dispose: stopBranch,
        invalidate() {},
        render(width: number): string[] {
          refresh(tui)
          const branch = footerData.getGitBranch()
          const model = ctx.model?.id || "no model"
          const thinking =
            typeof (pi as any).getThinkingLevel === "function"
              ? (pi as any).getThinkingLevel()
              : "?"
          const usage = ctx.getContextUsage?.()
          const contextWindow = usage?.contextWindow ?? ctx.model?.contextWindow
          const pct =
            usage?.percent == null
              ? null
              : Math.max(0, Math.min(100, Math.round(usage.percent)))
          let inputTokens = 0,
            outputTokens = 0,
            cost = 0
          for (const entry of ctx.sessionManager.getBranch()) {
            if (
              entry.type !== "message" ||
              (entry.message as any).role !== "assistant"
            )
              continue
            const u = (entry.message as any).usage
            inputTokens += u?.input || 0
            outputTokens += u?.output || 0
            cost += u?.cost?.total || 0
          }
          let repo = cwd.split(/[\\/]/).filter(Boolean).pop() || cwd
          try {
            const { execFileSync } = require("child_process")
            repo =
              String(
                execFileSync("git", ["rev-parse", "--show-toplevel"], {
                  cwd,
                  encoding: "utf8",
                  stdio: ["ignore", "pipe", "ignore"],
                })
              )
                .trim()
                .split(/[\\/]/)
                .pop() || repo
          } catch {}
          const fill = pct == null ? 0 : Math.round(pct / 5)
          const rgb = (r: number, g: number, b: number, text: string) => `\x1b[38;2;${r};${g};${b}m${text}\x1b[39m`
          let bar = ""
          for (let i = 0; i < 20; i++) {
            if (i >= fill) { bar += rgb(70, 74, 82, "░"); continue }
            const t = i / 19
            const r = t < 0.5 ? Math.round(40 + 215 * t * 2) : 255
            const g = t < 0.5 ? 210 : Math.round(210 - 170 * (t - 0.5) * 2)
            const b = 45
            bar += rgb(r, g, b, "█")
          }
          const contextColor =
            pct == null
              ? "muted"
              : pct >= 90
                ? "error"
                : pct >= 70
                  ? "warning"
                  : "success"
          const emoji =
            pct == null || pct < 20
              ? "🟢"
              : pct < 70
                ? "⚡"
                : pct < 90
                  ? "🔥"
                  : "🚨"
          const context =
            theme.fg(contextColor, emoji) +
            " " +
            bar +
            " " +
            theme.fg(contextColor, pct == null ? "--" : pct + "%")
          const thinkingLabel = thinking === "?" ? "[?]" : `[${thinking}]`
          const thinkingColor = `thinking${thinking.charAt(0).toUpperCase()}${thinking.slice(1)}`
          const branchPart = branch ? theme.fg("accent", ` 󰘬 (${branch})`) : ""
          const magenta = (text: string) => `\x1b[35m${text}\x1b[39m`
          const top =
            theme.fg("warning", theme.bold(repo)) +
            branchPart +
            theme.fg("muted", " | ") +
            context +
            theme.fg("muted", " | ") +
            theme.fg("accent", `$${cost.toFixed(3)}`) +
            theme.fg("muted", " | ") +
            theme.fg("success", `+${cached.added}`) +
            " " +
            theme.fg("error", `-${cached.removed}`) +
            theme.fg("muted", " | ") +
            magenta(`🤖 ${model}`) +
            " " +
            (theme as any).fg(thinkingColor, thinkingLabel)
          const bottom =
            theme.fg(
              "muted",
              `ctx ${usage?.tokens != null ? formatTokens(usage.tokens) : "?"}/${contextWindow ? formatTokens(contextWindow) : "?"}`
            ) +
            theme.fg("muted", "  ·  ") +
            theme.fg("success", `↑${formatTokens(inputTokens)}`) +
            theme.fg("error", ` ↓${formatTokens(outputTokens)}`) +
            theme.fg(
              "muted",
              cached.dirty ? `  ·  ${cached.files} changed` : "  ·  clean"
            )
          return [truncateToWidth(top, width), truncateToWidth(bottom, width)]
        },
      }
    })
  })

  pi.on("agent_start", () => {
    working = true
  })
  pi.on("agent_end", () => {
    working = false
  })
  pi.on("agent_settled", () => {
    working = false
  })
}
