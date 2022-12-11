#/usr/bin/env bash
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
    --verbose
