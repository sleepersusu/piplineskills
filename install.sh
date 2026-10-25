#!/usr/bin/env bash
# 把 skills/ 底下的每個 skill 裝到 ~/.claude/skills/（已存在且內容不同時先備份到 ~/.claude/skills-backup/）
set -euo pipefail
src="$(cd "$(dirname "$0")" && pwd)/skills"
dest="$HOME/.claude/skills"
backup_root="$HOME/.claude/skills-backup"
mkdir -p "$dest"
for dir in "$src"/*/; do
  name="$(basename "$dir")"
  if [ -d "$dest/$name" ] && ! diff -rq "$dir" "$dest/$name" >/dev/null; then
    mkdir -p "$backup_root"
    backup="$backup_root/$name-$(date +%Y%m%d%H%M%S)"
    mv "$dest/$name" "$backup"
    echo "備份舊版：$backup"
  fi
  rm -rf "$dest/$name"
  cp -R "$dir" "$dest/$name"
  echo "已安裝：$name"
done
echo "完成。重開 Claude Code 後用 /skills 確認。"
