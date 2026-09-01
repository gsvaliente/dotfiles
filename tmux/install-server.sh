#!/usr/bin/env bash
# ── one-shot server tmux setup ────────────────────────────────
# Installs tmux + prerequisites, downloads the config, clones TPM,
# and INSTALLS THE PLUGINS automatically (no manual prefix+I needed).
#
# Usage:
#   # save it first, then run it — don't pipe through bash, or sudo
#   # won't be able to prompt for a password
#   curl -fsSL https://raw.githubusercontent.com/gsvaliente/dotfiles/main/tmux/install-server.sh -o install-server.sh
#   bash install-server.sh
#
# Safe to re-run: backs up an existing ~/.tmux.conf and reuses TPM.

set -uo pipefail

CONFIG_URL="https://raw.githubusercontent.com/gsvaliente/dotfiles/main/tmux/tmux-server.conf"
CONFIG_DEST="${HOME}/.tmux.conf"
TPM_DIR="${HOME}/.tmux/plugins/tpm"

# helpers
log()  { printf '\033[1;36m==> %s\033[0m\n' "$*"; }
ok()   { printf '    \033[1;32m✓\033[0m %s\n' "$*"; }
fail() { printf '    \033[1;31m✗ %s\033[0m\n' "$*" >&2; exit 1; }

# 1. detect OS / package manager
log "Detecting OS and package manager"
if   command -v apt-get >/dev/null 2>&1; then PM="apt-get install -y"
elif command -v dnf     >/dev/null 2>&1; then PM="dnf install -y"
elif command -v yum     >/dev/null 2>&1; then PM="yum install -y"
elif command -v apk     >/dev/null 2>&1; then PM="apk add"
elif command -v brew    >/dev/null 2>&1; then PM="brew install"
else fail "no supported package manager found (apt-get / dnf / yum / apk / brew)"
fi
ok "package manager: $PM"

# sudo only when not already root
if [[ ${EUID} -ne 0 ]]; then SUDO="sudo"; else SUDO=""; fi

# 2. install prerequisites if missing
install() {  # install <binary> <package-name>
  if command -v "$1" >/dev/null 2>&1; then
    ok "$1 is already installed"
  else
    log "Installing $2..."
    $SUDO $PM "$2" || fail "could not install $2 (failed command: $SUDO $PM $2)"
    command -v "$1" >/dev/null 2>&1 || fail "$1 still not found after install — is $2 available in your distro's repos?"
    ok "$1 installed"
  fi
}

log "Installing prerequisites"
install git  git
install fzf  fzf
install tmux tmux

# 3. download the config
log "Downloading tmux config"
if [[ -f "$CONFIG_DEST" ]]; then
  cp "$CONFIG_DEST" "${CONFIG_DEST}.bak"
  ok "backed up existing config -> ${CONFIG_DEST}.bak"
fi
curl -fsSL "$CONFIG_URL" -o "$CONFIG_DEST" || fail "download failed: $CONFIG_URL"
[[ -s "$CONFIG_DEST" ]] || fail "downloaded config is empty — check the repo path / branch"
ok "config written to $CONFIG_DEST"

# 4. clone / update TPM
log "Setting up TPM"
if [[ -d "$TPM_DIR/.git" ]]; then
  git -C "$TPM_DIR" pull --ff-only || fail "could not update existing TPM repo"
  ok "TPM updated"
else
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" || fail "could not clone TPM"
  ok "TPM cloned"
fi
[[ -x "$TPM_DIR/tpm" ]] || fail "TPM binary missing at $TPM_DIR/tpm"

# 5. install the plugins themselves (runs TPM without needing your hand)
log "Installing tmux plugins"
tmux start-server 2>/dev/null || true
"$TPM_DIR/bin/install_plugins" >/dev/null 2>&1 || fail "TPM plugin install failed"
ok "plugins installed -> ${HOME}/.tmux/plugins"

# 6. summary
log "Done!"
echo
echo "  Files in place:"
echo "    config       -> $CONFIG_DEST"
echo "    plugins      -> ${HOME}/.tmux/plugins"
echo "    installed    -> $(ls ${HOME}/.tmux/plugins | tr '\n' ' ')"
echo
echo "  Start tmux with:  tmux"
echo "  Then press:       prefix + I   (<Ctrl-b> then Shift+i)  to install any missing plugins"
tmux -V 2>/dev/null || true