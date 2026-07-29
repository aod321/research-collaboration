# research-collaboration

Working conventions for doing research with a coding agent, packaged as
installable skills.

Not a software-delivery methodology. The failure this exists to prevent is the
opposite one: an agent spending ten hours and a large bill on tests, refactors,
and multi-seed reproductions of a negative result, and producing no curve from
real data.

## The iron law

```
ONLY A REAL RESULT COUNTS AS PROGRESS.

BEFORE THE FIRST ONE, RIGOR MEANS ONLY:
SAY WHAT ACTUALLY RAN, AND DO NOT LEAK.
```

Rigor is proportional to what you have. Before a real result it means exactly
two things — the claimed mechanism equals the computation actually executed, and
nothing leaks from the evaluation set. After a strong result it means whatever
could overturn that result, chosen by what could actually go wrong rather than
copied from a generic checklist.

Tests, refactors, documentation, figures, review, diagnostics, and launching a
job may all be necessary. None of them is progress.

## Skills

| Skill | Use when |
|---|---|
| `research-mode` | Starting any research or experiment task, or deciding what to do next in one — implementing a mechanism, launching training, reporting results, judging whether an idea has earned compute, deciding whether to scale up. |

`research-mode` carries four research phases, the rule for how much
verification is warranted before the first result, the reporting order, the seed
policy, and rationalization tables. Phase and execution profiles ship in
`skills/research-mode/references/` and are read on demand.

## Install

Works for both Codex and Claude Code. Requires `bash` and `git`; nothing else.

```bash
git clone https://github.com/aod321/research-collaboration.git ~/research-collaboration
cd ~/research-collaboration
./install.sh
```

Expected output:

```
/home/you/.codex/skills
  link research-mode
/home/you/.claude/skills
  link research-mode
```

`install.sh` symlinks each skill in `skills/` into `~/.codex/skills/` and
`~/.claude/skills/`. It installs into whichever of the two exists — if only one
harness is set up, the other line reads `skip ... not present`, which is fine.

Preview before it touches anything with `./install.sh --dry-run`.

### Verify

Start a **new** session — neither harness re-scans skills mid-session — and:

- **Codex**: `research-mode` appears in the skill list. Or invoke it directly
  with `$research-mode`.
- **Claude Code**: `research-mode` appears in the available-skills list. Or run
  `/research-mode`.

If it does not appear, check the link resolves:

```bash
ls -l ~/.codex/skills/research-mode ~/.claude/skills/research-mode
cat ~/.codex/skills/research-mode/SKILL.md | head -3
```

### Update

```bash
cd ~/research-collaboration && git pull
```

That is the whole update. The installed skills are symlinks into this checkout,
so a pull updates them in place. Re-run `./install.sh` only when a skill is
added or removed.

### Uninstall

```bash
cd ~/research-collaboration && ./install.sh --uninstall
```

Removes only the symlinks it created. If a real directory sits at a target path,
it is left alone rather than deleted.

### Plugin manifests

`.codex-plugin/plugin.json` and `.claude-plugin/plugin.json` are present and
point at `./skills/`, for harnesses that install a repo as a plugin rather than
by symlink. **The symlink route above is the one that has been tested**; if you
install via a plugin manifest instead, verify the skill loads before relying on
it.

### Binding a repository to it

A skill only fires when it triggers. To make the conventions apply from the
first message of every session, add a short paragraph and a link to the
repository's own `AGENTS.md` or `CLAUDE.md`:

```markdown
## Research collaboration mode

This repository runs the research collaboration conventions. Before
implementing, training, evaluating, or reporting, determine the current research
phase and respect what counts as progress in it.

Before the first direct target-facing result, rigor means preserving scientific
identity and preventing leakage — not maximizing test coverage, repeatability,
documentation, or review completeness.
```

Repository-specific construct-validity rules — canonical identity contracts,
hash binding, evidence ordering — stay in that repository and take precedence
there. The skill carries only the portable floor.

## What is deliberately absent

No identifier namespaces, no status blocks, no forms, no per-run paperwork.
Fourteen reference skills were surveyed while designing this; none use them.

A framework whose remedy for "too much process" is more process has not
understood the problem. Every clause here either changes what an agent does
next, or it does not belong.

## Reporting order

Applies to every progress report:

```
1. WHY this is worth doing, and how it relates to the main goal
2. WHAT is being done and what the result means — in plain language
3. ONLY IF USEFUL: filenames, hashes, contracts, parity, step counts
```

A report that opens with a hash has buried what the reader needed.

## Prior art

The structure — an always-available entry skill, capability loaded on demand,
red-flag and rationalization tables, an iron law, and a "why this matters"
grounded in a real incident — is borrowed from
[Superpowers](https://github.com/obra/superpowers).

Not borrowed: the linear spec → plan → TDD → review → finish pipeline, hard
gates forbidding action until process completes, and treating every stage as a
final deliverable. Those are right for shipping software and wrong for an
unproven research idea.

## License

MIT.
