#!/usr/bin/env bash
clear
set -euo pipefail

REPO_URL="https://github.com/shaneturon3-web/ninio-mar.git"
TARGET="${HOME}/book/ninio-mar"

mkdir -p "$(dirname "$TARGET")"

if [ -d "$TARGET/.git" ]; then
  cd "$TARGET"
  git pull --ff-only origin main
else
  git clone "$REPO_URL" "$TARGET"
  cd "$TARGET"
fi

git status --short
git branch --show-current
git --no-pager log --oneline --decorate -5
