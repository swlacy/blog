#!/usr/bin/env bash

# Run Hugo build tasks:
#  - Remove public/ directory if it exists
#  - Run build w/ minification and garbage collection
function hugo_build() {
    printf "[!] Building Site\n\n"

    # Remove public/ directory if it exists
    public_dir="public"
    if [ -d "$public_dir" ]; then
        rm -rf $public_dir
        printf "    Removed $public_dir/ directory\n\n"
    else
        printf "    No $public_dir/ directory to remove; skipping\n\n"
    fi

    # Build site
    HUGO_BUILD_STATUS="$(hugo --minify --gc 2>&1 | sed 's/^/    /g')"

    printf "%s\n\n" "$HUGO_BUILD_STATUS"
}

# Pull latest changes
function git_pull() {
    printf "[!] Pulling Latest Changes on git:%s\n\n" "$(basename $(pwd))"

    GIT_PULL_STATUS=$(git pull | sed 's/^/    /g')

    printf "%s\n\n" "$GIT_PULL_STATUS"
}

# Commit changes to working tree
function git_commit() {
    printf "[!] Committing Changes on git:%s\n\n" "$(basename $(pwd))"

    # Check for changes to working tree; if none, return
    if [ ! "$(git status --porcelain)" ]; then
        printf "    No changes to commit; skipping\n\n"
        return 0
    fi

    # Show status of working tree
    GIT_STATUS="$(git status | sed 's/^/    /g')"
    printf "%s\n\n" "$GIT_STATUS"

    # Get commit message from arguments
    COMMIT_MESSAGE="$*"

    # If no commit message, prompt for one
    if [ -z "$COMMIT_MESSAGE" ]; then
        read -p "    Enter commit message: " COMMIT_MESSAGE
    fi

    # If still no commit message, set default
    if [ -z "$COMMIT_MESSAGE" ]; then
        COMMIT_MESSAGE="No commit message provided"
    fi
    
    # Show commit message text
    printf "    Committing changes to working tree with message '%s'\n\n" \
        "$COMMIT_MESSAGE"

    # Commit changes to working tree
    GIT_COMMIT_STATUS="$( { \
        git add . && \
        git commit -m "$COMMIT_MESSAGE"; \
    } 2>&1 | sed 's/^/    /g' )"
    GIT_BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"

    printf "[!] Committing to branch '%s' on git:%s\n\n%s\n\n" \
        "$GIT_BRANCH_NAME" "$(basename $(pwd))" "$GIT_COMMIT_STATUS"
}

# Push changes to remote
function git_push() {
    printf "[!] Pushing Changes on git:%s\n\n" "$(basename $(pwd))"

    # Check for changes to working tree; if none, return
    if [ ! "$(git status --porcelain)" ]; then
        printf "    No changes to push; skipping\n\n"
        return 0
    fi

    # Push changes to remote
    GIT_PUSH_STATUS="$(git push 2>&1 | sed 's/^/    /g')"

    printf "%s\n\n" "$GIT_PUSH_STATUS"
}

# Deploy site to Firebase
function firebase_deploy() {
    printf "[!] Deploying to Firebase\n\n"

    # Deploy site to Firebase
    FIREBASE_DEPLOY_STATUS="$(firebase deploy 2>&1 | sed 's/^/    /g')"

    printf "%s\n\n" "$FIREBASE_DEPLOY_STATUS"
}

# If not in directory of script, cd to it
if [ "$(dirname "$0")" != "." ]; then
    cd "$(dirname "$0")"
fi

# Build and push site changes to git
hugo_build
git_pull && git_commit "$*" && git_push

# Push theme changes to git
cd themes/hugo-port-theme
git_pull && git_commit "$*" && git_push
cd ../..

# Deploy site to Firebase
printf "[!] Dummy firebase deploy here\n\n"
# firebase_deploy

printf "[!] Done\n"