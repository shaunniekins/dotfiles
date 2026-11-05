#!/usr/bin/env bash
# ============================================================================
# CONTINUUM GUARD — run from tmux.conf with `run -b`, BEFORE the TPM line
# ============================================================================
# Auto-restore and autosave must not depend on TPM finishing:
#
#   * On the 2026-10-31 boot, TPM hung inside tmux-yank (a `tmux bind-key`
#     client that never got a reply), so `run tpm` never returned. Every line
#     after it, including the old post-TPM guard, never ran: no restore, and
#     resurrect/continuum were never even sourced.
#   * tmux-continuum counts every `tmux new-session -A` client spawned by zshrc
#     as a second tmux server when the terminal reopens several windows, and
#     then silently skips both its restore and its autosave hook.
#
# So this script, started before TPM, does the whole job itself:
#   1. seeds the autosave timestamp so the bare boot session isn't snapshotted,
#   2. on the first config load of a server, restores the newest non-empty
#      snapshot (calling tmux-resurrect's scripts directly, not via TPM),
#   3. keeps continuum's autosave hook in status-right, re-adding it whenever a
#      theme plugin (tmux-dotbar) overwrites status-right, however late it loads.
#
# Continuum's own restore stays off in tmux.conf (@continuum-restore off) so
# the two never race; @dotfiles-auto-restore is the switch for this one.
# `touch ~/tmux_no_auto_restore` disables the restore (same file continuum uses).

plugins="$HOME/.tmux/plugins"
continuum_save="$plugins/tmux-continuum/scripts/continuum_save.sh"
resurrect_scripts="$plugins/tmux-resurrect/scripts"
save_hook="#($continuum_save)"

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

# True exactly once per tmux server: on its first config load. A later
# `source-file` (prefix + r) finds the marker and skips the restore. Unlike a
# start_time window, this can't be missed because startup was slow.
first_load_of_server() {
    [ -z "$(opt @dotfiles-guard-loaded)" ] || return 1
    tmux set-option -g @dotfiles-guard-loaded 1
}

# --- 1. Seed the autosave clock ------------------------------------------------
# Without a timestamp, continuum_save.sh fires on the very first status refresh,
# snapshotting the bare boot session and repointing `last` at it.
seed_save_timestamp() {
    [ -n "$(opt @continuum-save-last-timestamp)" ] ||
        tmux set-option -g @continuum-save-last-timestamp "$(date +%s)"
}

# continuum_save.sh reads these to find resurrect. They are normally set when
# TPM sources resurrect.tmux; set them here too so saving works even if TPM
# never gets that far.
ensure_resurrect_paths() {
    [ -n "$(opt @resurrect-save-script-path)" ] ||
        tmux set-option -g @resurrect-save-script-path "$resurrect_scripts/save.sh"
    [ -n "$(opt @resurrect-restore-script-path)" ] ||
        tmux set-option -g @resurrect-restore-script-path "$resurrect_scripts/restore.sh"
}

# --- 2. Never restore from an empty snapshot ----------------------------------
repair_last_link() {
    local dir last newest file
    dir="$(resurrect_dir)"
    last="$dir/last"
    [ -s "$last" ] && return 0

    for file in $(ls -1r "$dir"/tmux_resurrect_*.txt 2>/dev/null); do
        if [ -s "$file" ]; then newest="$file"; break; fi
    done
    [ -n "$newest" ] || return 1
    ln -fs "$(basename "$newest")" "$last"
}

# The script starts while the config is still loading, before `new-session`
# has created the session to restore into. Wait for it (up to ~60s).
wait_for_session() {
    local i
    for ((i = 0; i < 120; i++)); do
        [ -n "$(tmux list-sessions -F x 2>/dev/null)" ] && return 0
        sleep 0.5
    done
    return 1
}

auto_restore() {
    [ "$(opt @dotfiles-auto-restore)" = "on" ] || return
    [ -f "$HOME/tmux_no_auto_restore" ] && return
    repair_last_link || return
    wait_for_session || return
    # Let the attaching client finish sizing the new session first.
    sleep 1
    "$resurrect_scripts/restore.sh"
}

# --- 3. Keep the autosave hook in status-right --------------------------------
ensure_save_hook() {
    local status_right
    status_right="$(opt status-right)"
    [[ "$status_right" == *"$save_hook"* ]] ||
        tmux set-option -g status-right "${save_hook}${status_right}"
}

# Plugins load after this script starts (and on a slow boot, much later), and
# tmux-dotbar overwrites status-right when it does. Re-check every few seconds
# for 5 minutes, which covers the slowest observed TPM load.
keep_save_hook() {
    local i
    for ((i = 0; i < 100; i++)); do
        tmux show-options -g >/dev/null 2>&1 || return # server gone
        ensure_save_hook
        sleep 3
    done
}

[ -x "$continuum_save" ] || exit 0
seed_save_timestamp
ensure_resurrect_paths
keep_save_hook &
first_load_of_server && auto_restore
wait
