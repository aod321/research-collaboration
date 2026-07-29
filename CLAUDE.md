# Working on this repository

This repo holds skills — SOPs for an agent doing research. Everything here is
read by an agent at work, so it is written for that reader.

## What a skill is here

Accumulated working experience and collaboration conventions. Not a compliance
system, not a workflow engine, not a delivery pipeline.

**Every clause must change what an agent does next, or it does not belong.**

## Rules for editing skills

- `SKILL.md` frontmatter takes only `name`, `description`, `license`,
  `allowed-tools`, `metadata`. `name` is hyphen-case, ≤64 chars.
  `description` is ≤1024 chars and **must not contain angle brackets**.
- The `description` decides whether the skill loads at all. Write it in terms of
  triggering symptoms, not of the theory inside.
- Keep `SKILL.md` well under 500 lines. Detail belongs in `references/`, loaded
  on demand, and must not be duplicated between the two.
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
