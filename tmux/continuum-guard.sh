#!/usr/bin/env bash
# ============================================================================
# CONTINUUM GUARD — run from tmux.conf after TPM
# ============================================================================
# tmux-continuum decides "another tmux server is running" by counting tmux
# processes. zshrc runs `tmux new-session -A -s main` in every new shell, so
# when the terminal reopens several windows after a reboot, all those clients
# get counted as servers. Continuum then silently:
#   1. skips the auto-restore, and
#   2. never installs its autosave hook in status-right.
# This script does both unconditionally, and also refuses to restore from an
# empty snapshot (a 0-byte save once became `last` and wiped the history).
#
# Continuum's own restore is turned off in tmux.conf (@continuum-restore off)
# so the two never race; @dotfiles-auto-restore is the switch for this one.

continuum_dir="$HOME/.tmux/plugins/tmux-continuum"
save_hook="#($continuum_dir/scripts/continuum_save.sh)"

opt() { tmux show-option -gqv "$1"; }

resurrect_dir() {
    local dir
    dir="$(opt @resurrect-dir)"
    if [ -z "$dir" ]; then
        if [ -d "$HOME/.tmux/resurrect" ]; then
            dir="$HOME/.tmux/resurrect"
        else
            dir="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect"
        fi
    fi
    echo "${dir/#\~/$HOME}"
}

# --- 1. Autosave hook ---------------------------------------------------------
install_save_hook() {
    [ -x "$continuum_dir/scripts/continuum_save.sh" ] || return
    # Without a timestamp, continuum_save.sh fires on the very first status
    # refresh — snapshotting the bare boot session before the restore lands.
    [ -n "$(opt @continuum-save-last-timestamp)" ] ||
        tmux set-option -g @continuum-save-last-timestamp "$(date +%s)"

    local status_right
    status_right="$(opt status-right)"
    [[ "$status_right" == *"$save_hook"* ]] ||
        tmux set-option -g status-right "${save_hook}${status_right}"
}

# --- 2. Never restore from an empty snapshot ----------------------------------
repair_last_link() {
    local dir last newest
    dir="$(resurrect_dir)"
    last="$dir/last"
    [ -s "$last" ] && return 0

    for file in $(ls -1r "$dir"/tmux_resurrect_*.txt 2>/dev/null); do
        if [ -s "$file" ]; then newest="$file"; break; fi
    done
    [ -n "$newest" ] || return 1
    ln -fs "$(basename "$newest")" "$last"
}

# --- 3. Auto-restore on server start ------------------------------------------
server_just_started() {
    local started max_delay
    started="$(tmux display-message -p '#{start_time}')"
    max_delay="$(opt @continuum-restore-max-delay)"
    [ -n "$started" ] && [ "$started" -gt "$(( $(date +%s) - ${max_delay:-10} ))" ]
}

auto_restore() {
    [ "$(opt @dotfiles-auto-restore)" = "on" ] || return
    [ -f "$HOME/tmux_no_auto_restore" ] && return
    server_just_started || return
    repair_last_link || return

    local restore_script
    restore_script="$(opt @resurrect-restore-script-path)"
    [ -x "$restore_script" ] || return
    # Give `new-session` time to create the session we restore into.
    sleep 1
    "$restore_script"
}

install_save_hook
auto_restore
