#!/usr/bin/env bash
# ── one-shot server tmux setup ────────────────────────────────
# Downloads tmux-server.conf, installs prerequisites (git, fzf),
# clones TPM, then tells you how to install the plugins.
# Safe to re-run: backs up an existing ~/.tmux.conf and reuses TPM.
set -euo pipefail

CONFIG_URL="https://raw.githubusercontent.com/gsvaliente/dotfiles/main/tmux/tmux-server.conf"
CONFIG_DEST="${HOME}/.tmux.conf"
TPM_DIR="${HOME}/.tmux/plugins/tpm"

step() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }

step "1/4 Checking git + fzf"
command -v git >/dev/null 2>&1 || { echo "  installing git..."; sudo apt-get install -y git >/dev/null || sudo yum install -y git >/dev/null; }
command -v fzf >/dev/null 2>&1 || { echo "  installing fzf...";  sudo apt-get install -y fzf  >/dev/null || sudo yum install -y fzf  >/dev/null; }

step "2/4 Downloading tmux config"
[[ -f "$CONFIG_DEST" ]] && { cp "$CONFIG_DEST" "${CONFIG_DEST}.bak"; echo "  backed up existing config -> ${CONFIG_DEST}.bak"; }
curl -fsSL "$CONFIG_URL" -o "$CONFIG_DEST"

step "3/4 Setting up TPM"
if [[ -d "$TPM_DIR" ]]; then
  echo "  TPM already present, pulling latest..."
  git -C "$TPM_DIR" pull --ff-only
else
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

step "4/4 Done!"
echo "  config:      $CONFIG_DEST"
echo "  plugins dir: ${HOME}/.tmux/plugins"
echo
echo "  Next steps:"
echo "  1. tmux"
echo "  2. press prefix + I  (<Ctrl-b> then Shift+i) to install plugins"
echo "  3. check tmux -V is 3.2+ (sessionx requires it)"