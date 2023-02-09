#/usr/bin/env bash
cd "${0%/*}"

screen -dmS "hugo" bash -c " \
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

screen -dmS "tail" bash -c " \
    themes/hugo-port-theme/tailwind/tailwind.sh
"
