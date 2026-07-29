---
name: distilling-principles
description: Use when turning working experience into durable rules - when something just went wrong or right and there is a lesson in it, when reviewing accumulated notes to decide what deserves promotion, when adding a rule to a skill, when a skill is getting long and needs pruning, or when asked to write or update a skill. Covers how to capture an observation in ten seconds, when a fragment has earned promotion, how to merge several observations without averaging them into mush, and how to write a rule that resists being rationalised past.
---

# Distilling Principles

## Overview

Insight arrives when work is busiest. The lessons that survive are otherwise
just the ones that happened to arrive on a quiet day.

Two failures, opposite directions. One is losing the lesson: it felt obvious at
the time, so it never got written, and six weeks later the same mistake costs
the same day. The other is promoting too eagerly: every passing irritation
becomes a rule, the skill bloats, and the rules that matter get buried among
maxims nobody follows.

**Core principle:** capture cheaply, promote expensively.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Iron Law

```
A PRINCIPLE EARNS THE CORE ONLY WHEN IT HAS RECURRED,
CARRIES A REAL INCIDENT, AND CHANGES THE NEXT ACTION.

EVERYTHING ELSE STAYS A NOTE.
```

## Capture

Ten seconds. Three lines. **Do not judge it, do not generalise it, do not
decide where it goes.** Judging is what makes capture expensive, and expensive
capture does not happen.

```
2026-07-30  wanted to finish the dataloader tests before running anything
            actual cost: 40 min, and the real bug was frame alignment,
            which those tests would not have caught
            candidate rule: only test what fails silently
```

What makes a note useful later is not the rule you guessed — it is **what
actually happened and what it cost**. Write those even when the rule is
obvious; especially then, because the obvious rule is often wrong and the
incident is what lets you notice.

Notes are append-only. Never edit one to match what you later decided it meant.

## Three levels

| Level | Evidence | Where it lives |
|---|---|---|
| **Note** | observed once | notes file, verbatim |
| **Candidate** | recurred | one row in a red-flag or rationalisation table |
| **Rule** | recurred + real incident + changes the next action | a section in the skill body, or a profile |

Most notes stop at level one, and should. A note that never recurs was probably
context, not principle.

**Do not skip levels because a note feels important.** Feeling important at the
moment of irritation is exactly the signal that is uncorrelated with being
load-bearing.

## Four conditions for promotion

**1. It recurred.** Once is a situation. Twice is a pattern. Said repeatedly
with visible frustration is load-bearing — that is a person who has paid for
this more than once.

**2. It carries an incident.** A rule with a real cost attached survives contact
with a deadline. A rule without one is a maxim, and maxims get rationalised past
in the moment they matter.

> *silent fallback is dangerous* is a maxim.
> *silent fallback once caused physical damage to a robot arm* is a rule.

**3. It changes the next action.** If an agent would do the same thing whether
or not it had read this, it does not belong. This is the filter that keeps a
skill from becoming a statement of values.

**4. It is general, not this project's instantiation.** The generic form goes in
the skill; the project's specific contract stays in the project. When unsure,
ask what would survive if the domain changed completely.

## Merging without averaging

When several observations point the same way, the instinct is to write one
general statement covering all of them. **That statement is weaker than any of
the originals.** Generality is bought with force, and force is what makes a rule
work under pressure.

Instead:

```
pick the SHARPEST original as the rule
demote the rest to calibration examples or red-flag rows
keep every original verbatim in the notes
```

The sharpest is usually the most specific and the most irritated, not the most
balanced. "Do not let irrelevant randomness crowd out the main budget" is
correct and inert. "跑五个 seed 去严谨地证明一个负面结果，这有什么意义？" is the
same rule with teeth.

## Writing the rule

Three parts. All three, or it will be argued past.

```
WHAT     the rule, in the sharpest available wording
WHY      the specific failure it prevents - with the incident, if there is one
LIMIT    what must NOT be inferred from it
```

Then, for anything that will be under pressure, **an enumerated forbidden
list**. This is not padding. A principle without a list gets rationalised past
one case at a time — each individual case looks like a reasonable exception, and
the rule dies by a thousand reasonable exceptions.

> The abstract statement stops nobody. `try/except: pass`, bare `except`,
> `|| true`, `# noqa` — the list stops everybody, because a specific
> prohibition cannot be reinterpreted.

Write the red flag as **the thought that precedes the failure**, not the
failure. An agent does not think "I am about to bloat the scope". It thinks
"let me just refactor this first". Catch the second one.

## Where it goes

| Kind | Destination |
|---|---|
| Always applies, changes what happens next | skill body |
| Applies within one phase or mode | that profile |
| A specific wording that precedes the failure | red-flag / rationalisation table |
| Evidence that the design is right | design doc, not the skill |
| This project's contract | the project, not the skill |
| Everything else | stays a note |

**Detail belongs in a profile, not the body.** The body is loaded every time;
profiles are loaded when relevant. Do not duplicate between them — a rule
restated in two places drifts, and then neither is trustworthy.

## Pruning

A skill that only grows becomes a document nobody reads, which is the same as
having no skill.

- **Before adding a section, ask what it replaces.** Most additions are a
  sharper version of something already there.
- **A rule whose incident no longer applies should go.** This is why notes keep
  the original incident: without it, in a year, nobody can tell whether a rule
  is still load-bearing or is scar tissue.
- **If two rules never both fire, they are one rule.** Merge them and keep the
  sharper wording.
- **A rule nobody has violated in months is either working or dead.** Check
  which. Working rules get cited; dead ones just sit there.

## Red Flags - STOP

- "This is obviously important, it should go straight in the skill" — obvious at
  the moment of irritation is uncorrelated with load-bearing. Note it, wait.
- "Let me write a general version that covers all of these" — that version is
  weaker than any original. Pick the sharpest.
- "I'll clean up the wording when I promote it" — the cleaned wording is the
  inert one. Keep the teeth.
- "It's a principle, the list of specifics is redundant" — the list is what
  survives contact with a plausible exception.
- "I'll write it down properly later" — later is a quiet day, and by then the
  cost is a vague memory. Three lines now.
- "This rule is important enough to skip the note stage" — that is how a skill
  fills with things one person felt once.

## Common Rationalizations

| Excuse | Reality |
|---|---|
| "Writing it down is the hard part" | Capture is ten seconds. Promotion is the expensive step, and it is the one being skipped. |
| "The lesson is obvious, I'll remember" | Six weeks and one deadline later, the same mistake costs the same day. |
| "More rules means more rigor" | More rules means fewer read. The core is a scarce resource. |
| "I'll generalise it so it covers more cases" | Coverage bought with force. Under pressure, the forceful version is the one that fires. |
| "It only happened once but it was bad" | Note it, with the cost. If it is real it will recur, and then it has earned promotion. |
| "The old rule is close enough, I'll leave both" | Two overlapping rules drift and then neither is trusted. Merge, keep the sharper. |
| "Nobody has broken this rule, so it's working" | Or it is dead. Check which before defending it. |

## Why This Matters

A fail-fast rule was written down, in detail, with its reasoning and its
incident. It was still violated repeatedly afterwards.

Separately, three months of working notes were never captured at all, and had to
be reconstructed from 494 session transcripts by eight parallel agents — 16,017
messages, of which 46% were duplicates and 6% machine noise, to recover roughly
120 fragments that had been sitting in plain sight the whole time.

Both failures are this skill's subject. The first is promotion without
reachability: a rule that is written but not loaded. The second is capture that
never happened because it felt expensive in the moment.

Ten seconds at the time would have prevented the second one entirely.

## Quick Reference

| Question | Answer |
|---|---|
| Something just went wrong. Now what? | Three lines in the notes: what happened, what it cost, candidate rule. Do not judge it. |
| Does this note become a rule? | Has it recurred? Does it carry an incident? Would an agent act differently? Is it general? All four, or it stays a note. |
| Five notes say similar things. | Pick the sharpest as the rule. The rest become red-flag rows. Keep all five verbatim. |
| How do I write it so it survives? | What / why-with-incident / what-not-to-infer. Plus an enumerated forbidden list if it will be under pressure. |
| Body or profile? | Always applies → body. Phase- or mode-specific → profile. Never both. |
| The skill is getting long. | For each section ask what it replaces, and whether its incident still applies.
