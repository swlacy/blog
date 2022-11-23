#/usr/bin/env bash

screen -dmS hugo bash -c "hugo server --bind=0.0.0.0 --port=80 --buildDrafts --buildExpired --buildFuture --enableGitInfo --gc"

screen -dmS tailwind bash -c "cd themes/hugo-port-theme && ./startTailwind.sh"

