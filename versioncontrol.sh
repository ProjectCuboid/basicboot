#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 \"commit message\""
    exit 1
fi

LARGE_FILES=$(find . -type f -size +100M)

for f in $LARGE_FILES; do
    echo "Tracking large file with Git LFS: $f"
    git lfs track "$f"
done

if [ -f .gitattributes ]; then
    git add .gitattributes
fi

git add .

git commit -m "$1"

git push origin main
