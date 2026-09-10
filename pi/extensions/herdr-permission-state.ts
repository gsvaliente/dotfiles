// Bridges pi-permission-system prompts to the managed Herdr agent-state extension.
// Keep this separate from herdr-agent-state.ts because Herdr may overwrite that file.

const PERMISSION_EVENT = "pi-permission-system:permission-request";

export default function (pi) {
  let rootTuiSession = false;
  const pending = new Set<string>();

  const publish = (active: boolean, label?: string) => {
    pi.events.emit("herdr:blocked", { active, label });
  };

  pi.on("session_start", (_event, ctx) => {
    rootTuiSession = ctx?.mode === "tui";
  });

  pi.events.on(PERMISSION_EVENT, (data) => {
    if (!rootTuiSession || !data?.requestId) {
      return;
    }

    if (data.state === "waiting") {
      if (!pending.has(data.requestId)) {
        pending.add(data.requestId);
        publish(true, data.message);
      }
      return;
    }

    if (data.state === "approved" || data.state === "denied") {
      if (pending.delete(data.requestId)) {
        publish(false);
      }
    }
  });
}
