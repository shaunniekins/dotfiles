#!/bin/sh
# Copy stdin to the system clipboard — unless it is a micro-selection.
#
# With `mouse on`, clicking into the pane to focus it almost always moves the
# cursor a pixel, which tmux treats as a drag: it selects one character and,
# on release, pipes it here. Without this guard that single character silently
# replaced whatever you had copied in another app, so Cmd+V in the terminal
# pasted a stray "s" or ")" (or nothing visible) instead of your text.
#
# Selections with fewer than 2 non-whitespace characters are dropped; tmux
# still keeps them in its own buffer list (prefix + =), so nothing is lost.

# Read stdin verbatim, keeping trailing newlines that $(...) would strip.
buf=$(cat; printf x)
buf=${buf%x}

visible=$(printf %s "$buf" | LC_ALL=en_US.UTF-8 tr -d '[:space:]' | LC_ALL=en_US.UTF-8 wc -m | tr -d ' ')
[ "${visible:-0}" -lt 2 ] && exit 0

if command -v pbcopy >/dev/null 2>&1; then
    printf %s "$buf" | pbcopy
else
    printf %s "$buf" | xclip -selection clipboard -i
fi
