# research-collaboration

A personal research methodology, packaged as agent skills for Codex and Claude
Code.

Experimental and evolving. It is refined against real research work, so the
content changes often. **This README documents only the install mechanics, which
do not.** For what the skills actually say, read them.

## Skills

| Skill | Read |
|---|---|
| `research-mode` | [`skills/research-mode/SKILL.md`](skills/research-mode/SKILL.md) |
| `distilling-principles` | [`skills/distilling-principles/SKILL.md`](skills/distilling-principles/SKILL.md) |

## Install

Needs `bash` and `git`. Nothing else.

```bash
git clone https://github.com/aod321/research-collaboration.git ~/research-collaboration
cd ~/research-collaboration
./install.sh
```

`install.sh` symlinks each skill in `skills/` into `~/.codex/skills/` and
`~/.claude/skills/`, installing into whichever of the two exists. Preview with
`--dry-run`.

Skills load at session start, so start a new session, then check with
`/research-mode` (Claude Code) or `$research-mode` (Codex).

## Deploy to many machines

One command per machine, with auto-update:

```bash
git clone https://github.com/aod321/research-collaboration.git ~/research-collaboration && \
  ~/research-collaboration/install.sh --cron
```

Pushing to this repo is then the whole release process. Each machine pulls
within thirty minutes and relinks, so skills added later appear without visiting
the machine.

The cron job runs `install.sh --self-update` — `git pull --ff-only` plus a
relink. A machine with local edits or a diverged branch fails loudly rather than
silently merging.

## Update

```bash
cd ~/research-collaboration && git pull
```

Installed skills are symlinks into this checkout, so a pull updates them in
place. Re-run `./install.sh` only when a skill has been added or removed.

A running session keeps the version it loaded; start a new one to pick up
changes.

## Uninstall

```bash
cd ~/research-collaboration && ./install.sh --uninstall
```

Removes the symlinks it created and the cron job. A real directory sitting at a
target path is left alone rather than deleted.

## Adding a skill

Put it under `skills/`, then re-run `./install.sh`. Conventions for writing one
are in [`CLAUDE.md`](CLAUDE.md).

## License

MIT.
