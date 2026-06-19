#!/bin/bash

set -euo pipefail

source "$HOME/.tmux.env"

SESSION="${SESSION:-dev}"
PROJECT_A="${PROJECT_A:-$HOME/projects/project-a}"
PROJECT_B="${PROJECT_B:-$HOME/projects/project-b}"
CMD_A="${CMD_A:-nvim}"
CMD_B="${CMD_B:-nvim}"
CMD_CHAT="${CMD_CHAT:-opencode}"

TERM_WIDTH="${COLUMNS:-}"
TERM_HEIGHT="${LINES:-}"

if [[ -z "$TERM_WIDTH" || -z "$TERM_HEIGHT" ]] && [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    TERM_WIDTH="${TERM_WIDTH:-$(tput cols 2>/dev/null || true)}"
    TERM_HEIGHT="${TERM_HEIGHT:-$(tput lines 2>/dev/null || true)}"
fi

TERM_WIDTH="${TERM_WIDTH:-120}"
TERM_HEIGHT="${TERM_HEIGHT:-30}"

attach_session() {
    if [[ -n "${TMUX:-}" ]]; then
        exec tmux switch-client -t "$SESSION"
    fi

    exec tmux attach-session -t "$SESSION"
}

if tmux has-session -t "$SESSION" 2>/dev/null; then
    attach_session
fi

name_a="$(basename "$PROJECT_A")"
name_b="$(basename "$PROJECT_B")"

tmux new-session -d -s "$SESSION" -x "$TERM_WIDTH" -y "$TERM_HEIGHT" -n "[$name_a]" -c "$PROJECT_A" \; \
    select-pane -t :.1 \; \
    send-keys "$CMD_A" C-m \; \
    \
    new-window -n "[$name_b]" -c "$PROJECT_B" \; \
    select-pane -t :.1 \; \
    send-keys "$CMD_B" C-m \; \
    \
    new-window -n "[chat]" -c "$HOME" \; \
    select-window -t "$SESSION:3" \; \
    select-pane -t :.1 \; \
    send-keys "$CMD_CHAT" C-m \; \
    \
    new-window -n "[home]" -c "$HOME" \; \
    \
    select-window -t "$SESSION:1" \; \
    select-pane -t :.1

attach_session
