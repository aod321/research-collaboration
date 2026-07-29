#!/usr/bin/env bash
#
# install.sh — link this repo's skills into the agent skill directories.
#
# Idempotent: re-running refreshes symlinks and never duplicates. Because the
# links point back into this checkout, `git pull` alone updates the installed
# skills; re-running install.sh is only needed when a skill is added or removed.
#
# Usage:
#   ./install.sh              # install into every harness found
#   ./install.sh --cron       # also install a half-hourly auto-update job
#   ./install.sh --self-update  # pull, then relink (what the cron job runs)
#   ./install.sh --dry-run    # show what would change, touch nothing
#   ./install.sh --uninstall  # remove symlinks and the cron job

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO/skills"
CRON_TAG="# research-collaboration auto-update"

TARGETS=(
  "$HOME/.codex/skills"
  "$HOME/.claude/skills"
)

DRY_RUN=0
UNINSTALL=0
WANT_CRON=0
SELF_UPDATE=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run)   DRY_RUN=1; shift ;;
    --uninstall)    UNINSTALL=1; shift ;;
    --cron)         WANT_CRON=1; shift ;;
    --self-update)  SELF_UPDATE=1; shift ;;
    -h|--help)      sed -n '2,14s/^# \{0,1\}//p' "$0"; exit 0 ;;
    *)              echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

# --self-update is what the cron job runs: commit this machine's notes, pull,
# push, then relink so that skills added upstream get picked up without anyone
# visiting the machine.
#
# --ff-only means a dirty or diverged checkout fails loudly instead of merging.
# Only this machine ever writes docs/notes/<hostname>.md, so an uncommitted note
# never blocks the pull and a push never conflicts.
#
# A failed push leaves the commit local and the next run retries it. Nothing is
# dropped; the failure is visible in the cron log.
if [[ $SELF_UPDATE -eq 1 ]]; then
  NOTES="docs/notes/$(hostname).md"
  # --porcelain, not diff: on a new machine the notes file is untracked, and
  # `git diff` does not see untracked files. That failure would be silent.
  if [[ -f "$REPO/$NOTES" ]] && [[ -n "$(git -C "$REPO" status --porcelain -- "$NOTES")" ]]; then
    git -C "$REPO" add "$NOTES"
    git -C "$REPO" commit -q -m "notes($(hostname)): capture"
  fi
  git -C "$REPO" pull --ff-only --quiet
  git -C "$REPO" push --quiet || echo "push failed; commit is local, will retry" >&2
  exec "$REPO/install.sh"
fi

say() { printf '%s\n' "$*"; }
run() { if [[ $DRY_RUN -eq 1 ]]; then say "  would: $*"; else "$@"; fi; }

[[ -d "$SRC" ]] || { echo "ERROR: no skills/ directory in $REPO" >&2; exit 1; }

# This machine's notes inbox. One file per machine so that concurrent capture
# never conflicts and a dirty note never blocks the auto-update pull.
if [[ $DRY_RUN -eq 0 && $UNINSTALL -eq 0 && -d "$REPO/docs/notes" ]]; then
  touch "$REPO/docs/notes/$(hostname).md"
fi

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

# ---------------------------------------------------------------------------
# Auto-update cron job
# ---------------------------------------------------------------------------

current_crontab() { crontab -l 2>/dev/null || true; }
crontab_without_ours() { current_crontab | grep -vF "$CRON_TAG" || true; }

if [[ $UNINSTALL -eq 1 ]]; then
  if current_crontab | grep -qF "$CRON_TAG"; then
    say "cron"
    say "  remove auto-update job"
    if [[ $DRY_RUN -eq 0 ]]; then
      crontab_without_ours | crontab -
    fi
  fi
elif [[ $WANT_CRON -eq 1 ]]; then
  if ! command -v crontab >/dev/null 2>&1; then
    echo "WARNING: crontab not found — skipping auto-update job" >&2
  else
    entry="*/30 * * * * $REPO/install.sh --self-update >/dev/null 2>&1  $CRON_TAG"
    say "cron"
    if current_crontab | grep -qF "$entry"; then
      say "  ok auto-update job"
    else
      say "  install auto-update job (every 30 min)"
      if [[ $DRY_RUN -eq 0 ]]; then
        { crontab_without_ours; printf '%s\n' "$entry"; } | crontab -
      fi
    fi
  fi
fi

if [[ $DRY_RUN -eq 1 ]]; then
  say ""
  say "Dry run. Nothing changed."
fi
