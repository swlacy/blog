#!/usr/bin/env bash

THEME_NAME="hugo-port-theme"
TW_BIN_PATH="themes/$THEME_NAME/tailwind/tw_bin"

# Kill screen session if it exists
# $1: screen session name
function try_kill_screen_session() {
    # If screen session exists, kill it
    if [ ! -z "$(screen -ls | grep "$1")" ]; then
        screen -S "$1" -X quit
        printf "[-] Killed existing screen session \"$1\"\n"
    # If screen session doesn't exist, do nothing
    else
        printf "[!] Screen session \"$1\" not running\n"
    fi
}

# Start screen session if it doesn't exist
# $1: screen session name
# $2: command to run in screen session
function try_start_screen_session() {
    # If screen session doesn't exist, start it
    if [ -z "$(screen -ls | grep "$1")" ]; then
        screen -dmS "$1" bash -c "$2"
        printf "[+] Started new screen session \"$1\"\n"
    # If screen session exists, try to kill it and start it again
    else
        printf "[!] Screen session \"$1\" already exists; trying to kill\n"
        try_kill_screen_session "$1"
        # Exit if kill failed to prevent infinite loop
        if [ ! -z "$(screen -ls | grep "$1")" ]; then
            printf "[!] Failed to kill screen session \"$1\"; quitting\n"
            exit 1
        fi
        try_start_screen_session "$1" "$2"
    fi
}

# If passed "--shutdown" argument, kill all screen sessions and exit
if [ "$1" == "--shutdown" ]; then
    try_kill_screen_session "hugo-live"
    try_kill_screen_session "tailwind-live"
    exit 0
fi

# Check if screen and hugo are in path
if [ -z "$(which hugo)" ] || [ -z "$(which screen)" ]; then
    echo "hugo and screen must be in \$PATH"
    exit 1
fi

# Check if tw-bin executable is present at $TW_BIN_PATH
if [ ! -f "$TW_BIN_PATH" ]; then
    echo "tw-bin executable not found at $TW_BIN_PATH"
    exit 1
fi

# If not in directory of script, cd to it
if [ "$(dirname "$0")" != "." ]; then
    cd "$(dirname "$0")"
fi

# Launch hugo server and tailwind watcher in detached screen sessions
try_start_screen_session "hugo-live" " \
    hugo server \
    --bind=0.0.0.0 \
    --noHTTPCache \
    --gc \
    --enableGitInfo \
    --buildDrafts \
    --buildExpired \
    --buildFuture \
    --printPathWarnings \
    --printUnusedTemplates \
    --verbose \
"

try_start_screen_session "tailwind-live" " \
    cd themes/$THEME_NAME/tailwind && \
    ./tw_bin -i main.css -o ../static/css/style.min.css --watch --minify
"
