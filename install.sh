#!/usr/bin/env bash
# Install this repo's skills into ~/.claude/skills.
#
# Symlinks each skill under skills/ so edits here take effect without reinstalling.
# Any existing directory at the destination is backed up to <name>.backup-<timestamp> first.
#
#   ./install.sh                     # all skills
#   ./install.sh project-foundation  # one skill
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
target_dir="${HOME}/.claude/skills"
only="${1:-}"

mkdir -p "$target_dir"

found=0
for skill in "$source_dir"/*/; do
  name="$(basename "$skill")"
  [ -n "$only" ] && [ "$name" != "$only" ] && continue
  found=1
  dest="$target_dir/$name"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    backup="$dest.backup-$(date +%Y%m%d-%H%M%S)"
    mv "$dest" "$backup"
    echo "  backed up existing -> $backup"
  fi

  ln -s "${skill%/}" "$dest"
  echo "linked  $name"
done

if [ "$found" -eq 0 ]; then
  echo "No skill found matching '${only}' in $source_dir" >&2
  exit 1
fi

echo
echo "Installed to $target_dir"
echo "Restart Claude Code if it was running when a new skill directory was created."
