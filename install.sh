#!/usr/bin/env bash
#
# install.sh — link this repo's skills into the agent skill directories.
#
# Idempotent: re-running refreshes symlinks and never duplicates. Because the
# links point back into this checkout, `git pull` alone updates the installed
# skills; re-running install.sh is only needed when a skill is added or removed.
#
# Usage:
#   ./install.sh            # install into every harness found
#   ./install.sh --dry-run  # show what would change, touch nothing
#   ./install.sh --uninstall

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO/skills"

TARGETS=(
  "$HOME/.codex/skills"
  "$HOME/.claude/skills"
)

DRY_RUN=0
UNINSTALL=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run)   DRY_RUN=1; shift ;;
    --uninstall)    UNINSTALL=1; shift ;;
    -h|--help)      sed -n '2,12s/^# \{0,1\}//p' "$0"; exit 0 ;;
    *)              echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

say() { printf '%s\n' "$*"; }
run() { if [[ $DRY_RUN -eq 1 ]]; then say "  would: $*"; else "$@"; fi; }

[[ -d "$SRC" ]] || { echo "ERROR: no skills/ directory in $REPO" >&2; exit 1; }

mapfile -t SKILLS < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
[[ ${#SKILLS[@]} -gt 0 ]] || { echo "ERROR: skills/ is empty" >&2; exit 1; }

installed_any=0

for target in "${TARGETS[@]}"; do
  parent="$(dirname "$target")"
  if [[ ! -d "$parent" ]]; then
    say "skip $target — $parent not present"
    continue
  fi

  installed_any=1
  say "$target"
  run mkdir -p "$target"

  for skill in "${SKILLS[@]}"; do
    link="$target/$skill"
    dest="$SRC/$skill"

    if [[ $UNINSTALL -eq 1 ]]; then
      if [[ -L "$link" ]]; then
        say "  remove $skill"
        run rm "$link"
      elif [[ -e "$link" ]]; then
        say "  SKIP $skill — not a symlink, leaving it alone"
      fi
      continue
    fi

    # A real directory here is somebody else's install, or hand-edited work.
    # Refuse rather than clobber it.
    if [[ -e "$link" && ! -L "$link" ]]; then
      say "  SKIP $skill — $link exists and is not a symlink"
      continue
    fi

    if [[ -L "$link" && "$(readlink -f "$link")" == "$(readlink -f "$dest")" ]]; then
      say "  ok $skill"
      continue
    fi

    say "  link $skill"
    run ln -sfn "$dest" "$link"
  done
done

if [[ $installed_any -eq 0 ]]; then
  echo "ERROR: found no agent skill directories (looked for ${TARGETS[*]})" >&2
  exit 1
fi

if [[ $DRY_RUN -eq 1 ]]; then
  say ""
  say "Dry run. Nothing changed."
fi
