# Working on this repository

This repo holds skills — SOPs for an agent doing research. Everything here is
read by an agent at work, so it is written for that reader.

## What a skill is here

Accumulated working experience and collaboration conventions. Not a compliance
system, not a workflow engine, not a delivery pipeline.

**Every clause must change what an agent does next, or it does not belong.**

**For how an observation becomes a rule** — capture, when it has earned
promotion, how to merge several notes without averaging them into mush, how to
write a rule that resists being argued past, and when to prune — use the
`distilling-principles` skill. The conventions below are only the mechanics of
this repository.

## Rules for editing skills

- **`SKILL.md` frontmatter carries `name` and `description` only.** Codex's
  validator also permits `license`, `allowed-tools`, and `metadata`, but a
  survey of every skill that works in Claude Code found none using `metadata` —
  it is a Codex-only field and risks the skill being rejected by other
  harnesses. Codex UI text belongs in `agents/openai.yaml`, which is where it is
  read from anyway.
- `name` is hyphen-case, ≤64 chars. `description` is ≤1024 chars and **must not
  contain angle brackets**.
- The `description` decides whether the skill loads at all. Write it in terms of
  triggering symptoms, not of the theory inside.
- **Split by kind, not by size.** The decision procedure and always-on rules go
  in `SKILL.md`; per-phase detail, templates, and background go in
  `references/`, loaded on demand. Never duplicate between the two.
  There is no line target — mature skills run from 60 to 700 lines of body, and
  the longest bodies also carry the longest references. Moving content out to
  hit a number makes it harder to reach without reducing anything.
- No `README.md`, `CHANGELOG.md`, or other auxiliary documentation *inside* a
  skill directory. The skill contains what the agent needs to do the job, and
  nothing about how the skill came to exist.
- No identifier namespaces, status blocks, or forms. If a rule needs an ID
  scheme to work, the rule is too complicated.

Validate before committing:

```bash
python3 ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/<name>
```

## House style

Blunt and imperative. State the rule, then the reason it exists, then what must
not be inferred from it. Tables over paragraphs. A red-flag list of the thoughts
that precede the failure works better than an explanation of the failure.

Ground the closing section in a real incident with real numbers. Abstract
warnings do not survive contact with a deadline.

## Adding a skill

Add it under `skills/`, then re-run `./install.sh` so the symlinks pick it up.
Bump the version in both plugin manifests together — they must not drift.

## Committing

English only, in files and in commit messages. No AI attribution or co-author
trailers.
