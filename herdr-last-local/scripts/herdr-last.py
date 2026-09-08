#!/usr/bin/env python3
import json
import os
import pathlib
import subprocess
import sys

STATE = pathlib.Path.home() / ".local/state/herdr/herdr-last-local.json"
BIN = os.environ.get("HERDR_BIN_PATH", "herdr")

def run(*args):
    return subprocess.check_output([BIN, *args], text=True)

def snapshot():
    return json.loads(run("api", "snapshot"))["result"]["snapshot"]

def load():
    try: return json.loads(STATE.read_text())
    except (FileNotFoundError, json.JSONDecodeError): return {}

def save(data):
    STATE.parent.mkdir(parents=True, exist_ok=True)
    STATE.write_text(json.dumps(data))

def remember(kind):
    # Event hooks run after Herdr has focused the target. Read the live
    # snapshot rather than relying on an event-scope CLI flag.
    snap = snapshot()
    data = load()
    if kind == "tab":
        workspace = snap["focused_workspace_id"]
        tab = snap["focused_tab_id"]
        current = data.setdefault("current_tabs", {}).get(workspace)
        if tab and tab != current:
            if current:
                data.setdefault("tabs", {})[workspace] = current
            data["current_tabs"][workspace] = tab
    elif kind == "workspace":
        workspace = snap["focused_workspace_id"]
        current = data.get("current_workspace")
        if workspace != current:
            if current:
                data["workspace"] = current
            data["current_workspace"] = workspace
    save(data)

def toggle_tab():
    snap = snapshot()
    current = snap["focused_tab_id"]
    workspace = snap["focused_workspace_id"]
    previous = load().get("tabs", {}).get(workspace)
    if previous and previous != current:
        subprocess.run([BIN, "tab", "focus", previous], check=False)

def toggle_workspace():
    snap = snapshot()
    current = snap["focused_workspace_id"]
    previous = load().get("workspace")
    if previous and previous != current:
        subprocess.run([BIN, "workspace", "focus", previous], check=False)

command = sys.argv[1]
if command == "remember-tab": remember("tab")
elif command == "remember-workspace": remember("workspace")
elif command == "toggle-tab": toggle_tab()
elif command == "toggle-workspace": toggle_workspace()
