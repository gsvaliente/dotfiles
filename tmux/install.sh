#!/usr/bin/env bash
# Installs the tmux config from this repo onto the current machine.
#
# Usage:
#   ./install.sh [server]
#     server  → installs tmux-server.conf as ~/.tmux.conf
#     (blank) → installs tmux.conf as ~/.tmux.conf (local machine)
#
# Safe to re-run — it only replaces ~/.tmux.conf, never touches existing configs
# beyond that one file.

set -euo pipefail

CONFIG="${1:-tmux.conf}"

if [[ ! -f "$CONFIG" ]]; then
    echo "error: $CONFIG not found in $(pwd)" >&2
    exit 1
fi

echo "installing $CONFIG -> ~/.tmux.conf"
ln -sf "$(pwd)/$CONFIG" "$HOME/.tmux.conf"

echo "done. Run 'tmux' (TPM will fetch plugins on first start) or 'tmux source-file ~/.tmux.conf'."