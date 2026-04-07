#!/bin/bash
# Highlights kitty tab when Claude needs permission.
# Communicates via unix socket to avoid TTY response leaking into the terminal.

INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')

# Find the kitty socket
SOCK=$(ls /tmp/kitty-* 2>/dev/null | head -1)
[ -z "$SOCK" ] && exit 0

KITTY="kitty @ --to unix:$SOCK"
MATCH="window_id:${KITTY_WINDOW_ID:-0}"

# Rose Pine palette
PERMISSION_BG="#f6c177" # gold — needs permission
PERMISSION_BG_DIM="#a67d4a" # dimmed gold for inactive
PERMISSION_FG="#191724" # dark fg for contrast on gold

case "$EVENT" in
  Notification)
    $KITTY set-tab-color -m "$MATCH" active_bg="$PERMISSION_BG" active_fg="$PERMISSION_FG" inactive_bg="$PERMISSION_BG_DIM" inactive_fg="$PERMISSION_FG"
    ;;
  Stop)
    $KITTY set-tab-color -m "$MATCH" --reset
    ;;
esac

exit 0
