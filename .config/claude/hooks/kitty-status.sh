#!/bin/bash
# Updates kitty tab color based on Claude Code session state.
# Colors are from the Rose Pine palette.

INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')

# Rose Pine palette
DEFAULT_BG="#26233a"    # active tab default
WORKING_BG="#31748f"    # teal — claude is working
PERMISSION_BG="#f6c177" # gold — needs permission
PERMISSION_FG="#191724" # dark bg for contrast on gold

case "$EVENT" in
  PreToolUse)
    kitty @ set-tab-color -m state:active active_bg="$WORKING_BG"
    ;;
  Stop)
    kitty @ set-tab-color -m state:active --reset
    ;;
  Notification)
    kitty @ set-tab-color -m state:active active_bg="$PERMISSION_BG" active_fg="$PERMISSION_FG"
    ;;
esac

exit 0
