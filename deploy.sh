#/usr/bin/env bash

cd ~/projects/blog

# Optimize images
# From https://virtubox.github.io/img-optimize/
if test -f "$HOME/.img-optimize/optimize.sh"; then
    echo "[!] Optimizing images"
    
    # Run optimization script
    cd static/media && bash $HOME/.img-optimize/optimize.sh --all 2>/dev/null
    
    # Rename converted files to .webp
    rename s/\.png// *.png.webp && rename s/\.jpg// *.jpg.webp 2>/dev/null
    
    # Update references to images in content
    cd ../../content
    grep -rl '.png' . | xargs sed -i 's/png/webp/g' 2>/dev/null
    if [ $? -ne 0 ]; then
        echo '[!] No *.png references to update'
    fi
    grep -rl '.jpg' . | xargs sed -i 's/jpg/webp/g' 2>/dev/null
    if [ $? -ne 0 ]; then
        echo '[!] No *.jpg references to update'
    fi
    
    cd ..
    echo "[!] Done optimizing images"
fi

# Get/prompt for commit message
if [ $# -gt 0 ]; then
    msg="$*"
else
    read -p "Message: " msg
fi
if [ -z "$msg" ]; then
    msg="No commit message provided"
fi
echo "[!] Base commit message: $msg"

# Build and commit changes to blog
rm -rf public
hugo --minify --gc && git add . && git commit -m "$msg" && git push
echo "[!] Done pushing blog"

# Build and commit changes to theme
cd themes/hugo-port-theme
git add . && git commit -m "[PARENT BUILD] $msg" && git push
cd ../..
echo "[!] Done pushing theme"

# Deploy live
firebase deploy
