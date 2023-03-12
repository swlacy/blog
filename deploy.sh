#/usr/bin/env bash

cd ~/projects/blog

if [ $# -gt 0 ]; then
    msg="$*"
else
    read -p "Message: " msg
fi

if [ -z "$msg" ]; then
    msg="No commit message provided"
fi

cd themes/hugo-port-theme
git add . && git commit -m "[PARENT BUILD] $msg" && git push

cd ../..
rm -rf public
hugo --minify --gc && git add . && git commit -m "$msg" && git push
firebase deploy
