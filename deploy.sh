#/usr/bin/env bash

cd ~/projects/blog

# Optimize images
# From https://virtubox.github.io/img-optimize/
if test -f "$HOME/.img-optimize/optimize.sh"; then
    cd static/media && bash $HOME/.img-optimize/optimize.sh --all
    rename s/\.png// *.png.webp && rename s/\.jpg// *.jpg.webp
    cd ../../content
    grep -rl '.png' . | xargs sed -i 's/png/webp/g'
    grep -rl '.jpg' . | xargs sed -i 's/jpg/webp/g'
    cd ..
    echo "[!] Done optimizing images"
fi

# Get commit message
if [ $# -gt 0 ]; then
    msg="$*"
else
    read -p "Message: " msg
fi
if [ -z "$msg" ]; then
    msg="No commit message provided"
fi

# Build and commit changes to theme
cd themes/hugo-port-theme
git add . && git commit -m "[PARENT BUILD] $msg" && git push

# Build and commit changes to blog
cd ../..
rm -rf public
hugo --minify --gc && git add . && git commit -m "$msg" && git push

# Deploy to Firebase
firebase deploy
