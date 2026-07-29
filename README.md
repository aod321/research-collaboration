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

```bash
git clone <repo-url> ~/research-collaboration
cd ~/research-collaboration && ./install.sh
```

`install.sh` creates idempotent symlinks into `~/.codex/skills/` and
`~/.claude/skills/`. Re-running it is safe.

Harnesses that read a plugin manifest can install the repo directly instead:
`.codex-plugin/plugin.json` and `.claude-plugin/plugin.json` both point at
`./skills/`.

### Update

```bash
cd ~/research-collaboration && git pull && ./install.sh
```

Symlink installs pick up changes with no further action.

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
