#!/usr/bin/env bash

THEME_NAME="hugo-port-theme"
TAILWIND_BIN_ARCH="tailwindcss-linux-x64"
TAILWIND_PATH="themes/$THEME_NAME/tailwind"
JS_PATH="themes/$THEME_NAME/static/js"
FONT_PATH="themes/$THEME_NAME/static/font"

# Remove file if it exists
# $1: file path
function rm_if_exists() {
    if [ -f $1 ]; then
        rm $1
        if [ -f $1 ]; then
            printf "[!] Failed to remove $1; quitting\n"
            exit 1
        fi
        printf "[-] Removed\t./$1\n"
    fi
}

# Fetch file and make it executable
# $1: file path
# $2: URL to fetch from
function fetch_file() {
    rm_if_exists $1
    curl -sLo $1 $2
    chmod u+x $1
    printf "[+] Fetched\t./$1\n"
    if [[ $1 == *.zip ]]; then
        unzip -q -o "$FONT_PATH/ubuntu.zip" -d "$(dirname $1)"
        printf "[*] Unzipped\t./$1\n"
        rm_if_exists $1
    fi
}

# If not in directory of script, cd to it
if [ "$(dirname "$0")" != "." ]; then
    cd "$(dirname "$0")"
fi

# Fetch latest TailwindCSS binary
fetch_file "$TAILWIND_PATH/tw_bin" "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/$TAILWIND_BIN_ARCH"

# Fetch latest minified Lucide icon JS
fetch_file "$JS_PATH/lucide.min.js" "https://unpkg.com/lunr@latest/lunr.min.js"

# Fetch Ubuntu font family
fetch_file "$FONT_PATH/ubuntu.zip" "https://www.fontsquirrel.com/fonts/download/ubuntu"
