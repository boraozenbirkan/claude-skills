#!/usr/bin/env bash
# Install this repo's skills into ~/.claude/skills.
#
# Symlinks each skill under skills/ so edits here take effect without reinstalling.
# Any existing directory is backed up to ~/.claude/skills-backups/ -- outside the skills directory,
# because Claude Code loads every directory under skills/ as a skill.
#
#   ./install.sh                     # all skills
#   ./install.sh project-foundation  # one skill
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
target_dir="${HOME}/.claude/skills"
# Backups live outside skills/ on purpose: Claude Code loads every directory in there as a skill,
# so a backup left alongside would show up in the skill list and burn context on every turn.
backup_dir="${HOME}/.claude/skills-backups"
only="${1:-}"

mkdir -p "$target_dir" "$backup_dir"

found=0
for skill in "$source_dir"/*/; do
  name="$(basename "$skill")"
  [ -n "$only" ] && [ "$name" != "$only" ] && continue
  found=1
  dest="$target_dir/$name"

  if [ -L "$dest" ]; then
    # A symlink from a previous run holds no content of its own; replace rather than archive it.
    rm "$dest"
    echo "  removed previous link"
  elif [ -e "$dest" ]; then
    backup="$backup_dir/$name.backup-$(date +%Y%m%d-%H%M%S)"
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
