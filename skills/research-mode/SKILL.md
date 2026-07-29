---
name: research-mode
description: Use at the start of any research or experiment task, and whenever deciding what to do next in one - implementing a mechanism, launching training or evaluation, reporting progress or results, judging whether an idea has earned compute, or deciding whether to scale up. Sets the research phase, defines what counts as progress, and governs how much verification is warranted before the first real result. Use when work has produced no result for a long stretch, when tests or refactoring are crowding out experiments, or when someone proposes multi-seed runs, full ablations, or publication-grade rigor for an unproven idea.
---

# Research Mode

## Overview

Research fails two ways. One is fooling yourself about what you built. The other
is never finding out, because the budget went to process.

**Core principle:** Rigor is proportional to what you have. Before a real result,
that means exactly two things — say what actually ran, and do not leak. After a
strong result, it means whatever could overturn it.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Iron Law

```
ONLY A REAL RESULT COUNTS AS PROGRESS.

BEFORE THE FIRST ONE, RIGOR MEANS ONLY:
SAY WHAT ACTUALLY RAN, AND DO NOT LEAK.
```

Tests, refactors, docs, figures, review, diagnostics, and launching are not
progress. They may be necessary. They are still not progress.

## Reporting Order

Every progress report, without exception:

```
1. WHY this is worth doing, and how it relates to the main goal
2. WHAT is being done and what the result means — in plain language
3. ONLY IF USEFUL: filenames, hashes, contracts, parity, step counts
```

Leave out detail that would not change the reader's understanding or decision.

**A report that opens with a hash has buried what the reader needed.**

## The Two Floors

Never traded away, in any phase. Everything else can wait.

**Say what actually ran.** Be able to state on demand: which tensors entered the
model, with what shape, axis semantics, and source frame; what the supervision
was and which frame it came from; which checkpoint and step, and the rule that
selected it; how state was initialized, reset, and carried.

Never infer any of it from a directory name, config name, nickname, or UI label.
**If you cannot state it, it is not a result.** Write it down once per mechanism
and point at it afterward.

Changing a mechanism because of a result is legitimate research. Changing it and
still reporting under the old description is not.

**Do not hack the result.** No evaluation-set information in training,
normalization, checkpoint selection, or hyperparameter selection. No changing a
definition to fit a result. No keeping only favorable runs, retrying until it
looks good, deleting unfavorable trajectories, reporting a proxy as a terminal
endpoint, or weakening a validator to make an old command run.

## Phases

| Where you are | Phase |
|---|---|
| No executable mechanism description yet | `MAIEUTIC` |
| Executable, but no result from real data yet | `RAPID_PROTOTYPE` |
| A result says it is worth pursuing, and a specific gate is named | `BATTERING_RAM` |
| Strong positive result on the primary endpoint, **and** the owner authorized confirmation | `CONFIRMATION` |

Execution style is separate: `DAY_INTERACTIVE | OVERNIGHT_UNATTENDED` and
`SINGLE_THREAD | SUBAGENT_DRIVEN`.

**Uncertain between two adjacent phases: pick the earlier, cheaper one.
Uncertainty is never a reason to enter `CONFIRMATION`.**

`MAIEUTIC` ends when the mechanism is executable **and** the claim names an
observable outcome that would make you reject, narrow, or rewrite it. One
sentence. Not preregistration, not statistics, not a power analysis.

**An idea immune to every possible result has not earned compute.**

A negative result gets the cheapest checks that rule out an implementation or
alignment mistake, then a decision to revise or abandon. It never triggers
`CONFIRMATION`.

## Before Non-Trivial Work, Say What You Are Testing

A few lines, written in under two minutes. Not needed for a rerun, one
hyperparameter, or one plot.

```
- the claim, and which mechanism it belongs to
- the endpoint, and what it is compared against
- the smallest faithful version of the run
- what positive, negative, and ambiguous would each mean
- the budget
```

**Writing this must cost far less than running the experiment.** If you cannot
write it, the idea is not formed. Go form it — do not elaborate the description.

This covers a bounded set of runs while the mechanism, claim, endpoint,
comparator, and the one lever you are moving stay fixed. Change any of those and
say so again.

## The Admission Test

Before launching anything, extra work is justified only if **both** hold:

```
1. the failure it rules out would make the next result uninterpretable
2. it is the cheapest way to rule that failure out
```

Say which run it unblocks. Tests, refactors, diagnostics, and review do not
qualify merely because they are normally good practice.

This governs *extra* verification you propose. **It never excuses skipping an
identity check the repository mandates** — those are part of the first floor, and
they always run.

## Budget

Give each piece of work a budget before starting, sized to that work. There are
no standing default numbers; a threshold calibrated on one mechanism does not
transfer to the next.

Count effort in tokens, not wall-clock. Waiting on a human or on a running job
burns nothing — what is bounded is effort, not elapsed time. If the harness
reports usage, read it. Otherwise estimate from time spent actively working;
polling, re-reading logs, and re-planning all count. **An estimate wrong by 2x
still catches an overrun by 10x.**

A new session, a compacted context, a retry, or a renamed mechanism does not
reset what has already been spent.

When the budget is gone, there are exactly three honest things to say:

| Say | Not |
|---|---|
| the running command, its job id, when the first number lands | "I am writing tests" |
| the number, what it was compared against, what it changes | "I am verifying" |
| the specific missing file, tensor, credential, or hardware, and the smallest action that unblocks it | "I am refactoring" |

## Seeds

One recorded seed by default; compare arms under the same random conditions.

**Not cherry-picking seeds is a floor. Proving seed-insensitivity is a specific
research question, not a standing duty.**

Full policy: `references/rng-policy.md`.

## Red Flags - STOP

If you catch yourself thinking:

- "Finish the tests before running it"
- "This negative result needs more seeds to be solid"
- "Refactor this part first"
- "One more diagnostic will settle it"
- "The proxy metric improved"
- "Build the full cache first"
- "I need to fully understand before acting"
- "There is budget left, keep improving it"
- "One more confirmation dimension will save the claim"
- "Try the other threshold and see"
- "This idea is too important to constrain with a falsifier"
- **Hours have passed and there is still no number**

**ALL of these mean: STOP. What is the shortest faithful run, and why has it not
started?**

## Common Rationalizations

| Excuse | Reality |
|---|---|
| "Being careful is being rigorous" | Rigor before a result is identity and leakage. The rest is cost. |
| "A negative result should be confirmed properly" | A negative gets the cheapest checks that rule out implementation and alignment mistakes. Nothing more. |
| "Refactoring will make the experiment cleaner" | Not progress. Run first. |
| "Proxy metric improved, we are on track" | Proxy improvement is not endpoint improvement. |
| "More data / full cache first" | Reuse what has known provenance. If a small sample can run, run it. |
| "I need to understand it fully first" | The shortest experiment is how you understand it. |
| "The process requires X" | If it is not a floor, not a repository-mandated identity check, and not this phase, it does not apply. |
| "Results only count with multiple seeds" | A real result counts immediately. Look at seed variation only when it could change this decision. |
| "I cannot measure token spend here" | Estimate it. Off by 2x still catches 10x. |
| "One more attempt at this threshold" | Which explanation of the failure does that test? Without one it is knocking at random. |
| "It is nearly done, then I will report" | Report the first interpretable result. Remaining budget is not a reason to keep polishing. |

## Letter vs Spirit

Read these conventions by the purpose they protect. Where following the words
literally would defeat that purpose, make the **smallest** change that restores
it, and ask what the author would have written had they known about this case.

Not "I judge the intent more important, so I need not comply." Rather "literal
compliance is destroying what this rule protects, so correct it minimally."

**This never overrides:** a goal, prohibition, or hard constraint the user
confirmed; a method the user said is itself required; the immutable goal of the
work; saying what actually ran; leakage boundaries; scientific integrity; a
declared hard resource cap; repository safety rules.

A method the user offered as a guess about the environment is not automatically a
constraint — preserve the outcome they wanted.

Mention a deviation only when it materially changes the phase, the mechanism,
what is being tested, the endpoint, the comparator, the budget, or what you
report. Small implementation choices need no announcement.

## Why This Matters

From a real session that produced this skill:

```
elapsed:                10+ hours
spend:                  large
tests written:          thousands
curves from real data:  zero
```

A negative result was being reproduced across multiple seeds to make it
"rigorous". The correct rules already existed in writing and were followed to the
letter — the failure was that nothing made "no result yet" visible or costly.

The owner asked for a model implemented, trained, and tested, expecting results
to iterate on. What came back was a still-running test suite.

**That is what this skill exists to prevent.**

## Quick Reference

| Question | Answer |
|---|---|
| What counts as progress? | A real result from real data on the declared endpoint. Nothing else. |
| How much rigor now? | Before a result: identity and leakage. After a strong result: whatever could overturn it. |
| Should I write this test? | Only if the failure it rules out would make the next result uninterpretable, and it is the cheapest way. |
| Multiple seeds? | No, unless seed variation could change this decision. |
| How do I report? | Why → what it means → details only if useful. |
| Budget is gone, now what? | Running command, or a number, or a specific blocker. |

## Profiles

Read only what applies now; do not preload everything.

| Axis | File |
|---|---|
| Phase | `references/rapid-prototype.md` |
| Execution | `references/day-interactive-single-thread.md` |

Profiles for the other phases and execution modes are not written yet; the
criteria above still apply. Examples inside a profile are calibration, **not a
checklist** — the criterion governs.
