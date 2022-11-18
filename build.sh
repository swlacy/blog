#/usr/bin/env bash

hugo server --bind=0.0.0.0 \
            --port=80 \
            --buildDrafts \
            --buildExpired \
            --buildFuture \
            --minify \
            --enableGitInfo \
            --gc
