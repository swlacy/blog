#/usr/bin/env bash

screen -dmS hugo bash -c "hugo server --bind=0.0.0.0 --buildDrafts --buildExpired --buildFuture --enableGitInfo --gc"
screen -dmS tailwind bash -c "cd themes/hugo-port-theme/tailwindcss && ./tailwindcss -i main.css -o ../static/css/style.min.css --watch --minify"
