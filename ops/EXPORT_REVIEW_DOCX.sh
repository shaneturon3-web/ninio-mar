#!/usr/bin/env bash
clear
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/_review"
MD="$OUT/ninio-mar-review.md"
DOCX="$OUT/ninio-mar-review.docx"

mkdir -p "$OUT"

{
  echo "# ninio-mar — review bundle"
  echo
  echo "Generated from local repository files."
  echo
  for file in \
    "$ROOT/README.md" \
    "$ROOT/INDEX.md" \
    "$ROOT/docs/00_DOCTRINE_LANGUAGE_SEMANTICS.md" \
    "$ROOT/book/BIBLE.md" \
    "$ROOT/book/SPINE.md" \
    "$ROOT/book/PLACEHOLDERS.md" \
    "$ROOT/book/BLOCKAGES.md"; do
    if [ -f "$file" ]; then
      echo
      echo "\n---\n"
      cat "$file"
      echo
    fi
  done

  echo
  echo "\n---\n"
  echo "# Chapter slots"
  echo
  find "$ROOT/book/chapters" -maxdepth 1 -type f -name 'C*.md' | sort | while read -r chapter; do
    echo
    echo "\n---\n"
    cat "$chapter"
    echo
  done
} > "$MD"

if command -v pandoc >/dev/null 2>&1; then
  pandoc "$MD" -o "$DOCX"
  echo "DOCX created: $DOCX"
else
  echo "Markdown review bundle created: $MD"
  echo "Pandoc not found. To create DOCX on Debian/Ubuntu/Zorin/Mint:"
  echo "sudo apt-get update && sudo apt-get install -y pandoc"
  echo "Then rerun: bash ops/EXPORT_REVIEW_DOCX.sh"
fi
