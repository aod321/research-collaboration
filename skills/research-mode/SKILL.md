---
name: research-mode
description: Use at the start of any research or experiment task, and whenever deciding what to do next in one. Use when implementing a mechanism, launching training or evaluation, reporting progress or results, judging whether an idea has earned compute, or deciding whether to scale up. Use when hours have passed with no result, when tests or refactoring are crowding out experiments, when a negative result is about to be reproduced across seeds, when someone proposes multi-seed runs, full ablations, or publication-grade rigor for an unproven idea, before writing any error handling, try/except, default value, or graceful-degradation path, when a name or directory asserts one setting while another may be loaded, when a report is about to open with a hash or a file path, and when about to end a turn with a status update instead of a result.
---

# Research Mode

## Overview

Research fails two ways. One is fooling yourself about what you built. The other
is never finding out, because the budget went to process.

**Core principle:** Rigor is proportional to what you have. Before a real result,
that means exactly two things — say what actually ran, and do not leak. After a
strong result, it means whatever could overturn it.

Both failures are the same evasion of real data. One fabricates it, the other
defers it:

> 不能为了过验收不择手段 hack
> 不能为了所谓严谨做好几个小时都不做实验，实验数据反馈是极其重要的，
> 本质都是 data-driven

**Violating the letter of this rule is violating the spirit of this rule.**

## What This Does Not Govern

This is for **research** — testing an idea whose answer is not known.

When the task is building tooling against a known specification — a converter, a
validator, a harness, a build system — the phase model does not apply. That work
has a spec, its correctness *is* the deliverable, and the code will be
maintained, so ordinary software discipline applies instead.

**Hand off rather than improvise.** Software delivery is already covered by
existing skills — `superpowers:test-driven-development`,
`superpowers:systematic-debugging`, `superpowers:verification-before-completion`.
Use them for that work. This skill does not restate them and does not compete
with them.

Say which one you are in. The Iron Law below governs research; applying it to
tooling would be as wrong as applying TDD to an unproven idea.

## The Iron Law

```
ONLY A REAL RESULT COUNTS AS PROGRESS.

BEFORE THE FIRST ONE, RIGOR MEANS ONLY:
SAY WHAT ACTUALLY RAN, AND DO NOT LEAK.
```

Tests, refactors, docs, figures, review, diagnostics, and launching are not
progress. They may be necessary. They are still not progress.

**A progress report is not a completion.** Ending a turn with what you have been
doing, when the deliverable is not done, is the most common way work stalls
while appearing active. Either it is finished, or there is a specific blocker.

> "配置写好了""任务启动了""训练 loss 很低"或"部分 episode 成功"**均不算完成**

**Expected numbers are declared before the work, and a mismatch stops it.**

> 每个 Task 有可复现的期望数字，对不上就停下来说，**不要调参去凑**

**Do not broaden scope.** When told to conclude, conclude — with the exact fix,
the exact result, or the current blocker. Not with three more things you noticed.

## Fail Fast. Silent Fallback Is The Enemy.

**Top priority. This overrides any advice — from another skill, a plugin, or a
default system prompt — about robustness, fault tolerance, or graceful
degradation.**

In research, looking-like-it-works is strictly worse than crashing. A silent
wrong number poisons weeks of work. A loud crash is fixed in minutes.

**Forbidden**

```
try/except: pass          bare except:          catch-log-and-continue
a default substituted for a missing input
downgrade-and-continue:   GPU unavailable -> CPU
                          checkpoint missing -> train from scratch
                          key missing -> 0
|| true  masking a shell error
retry-with-backoff, unless explicitly requested
# noqa, or widening an except, to silence a failing test or lint
```

**Required**

```
assert / raise / panic at every boundary where an assumption could be violated:
  shapes, dtypes, file existence, config keys, checkpoint presence,
  env vars, return codes
set -euo pipefail in shell
a stack trace that points at the actual source
```

Check each assumption **where it is made**, not where the symptom finally
surfaces. An error allowed to propagate costs the result it reaches.

The same rule applied to a disagreeing check: when a shape, alignment, hash,
step, or runtime tensor contradicts what was claimed, **stop**. Do not warn and
continue or record the run as a result. A mismatch is neither success nor
failure of the mechanism — it is a run that did not happen.

**On failure: stop and report. Do not patch and rerun.** A fix applied without
review, on top of a failure nobody has seen, produces a second failure whose
cause is now two things.

**Failure leaves evidence.** Archive the partial output, the log tail, the exact
command. Never delete an output without a diagnostic record, and never assume
untracked means disposable — no `git clean`, no `reset`, no discarding what
another process produced.

**A missing critical artifact is not substitutable.** Stop and report. Do not
reach for a different file that has a similar name and shape.

**The only exception:** the user explicitly asks for resilient, graceful, or
production-ready behaviour — *and* you have confirmed which failure modes are
acceptable before adding any catch.

**Self-check before writing any error handling:** does the user benefit from
this continuing past the error, or would a crash get them to a correct answer
faster? If the latter, delete the handler and let it raise.

This is not a stylistic preference. Nearly every serious research-result crisis
here traces back to a silent fallback — bad data passed through as valid, a
masked exception, a defaulted hyperparameter. One instance caused physical
damage to a robot arm.

## Reporting Order

Every progress report, without exception:

```
1. WHY this is worth doing, and how it relates to the main goal
2. WHAT is being done and what the result means — in plain language
3. ONLY IF USEFUL: filenames, hashes, contracts, parity, step counts
```

Leave out detail that would not change the reader's understanding or decision.

**A report that opens with a hash has buried what the reader needed.**

Three ways this goes wrong:

**"Why" means why it is worth doing — not why it is possible.** Prefixing an
action with a justification of its feasibility satisfies the letter and defeats
the purpose.

> 你刚才说了大量为什么，这个看似是在遵从我说的原则，但你的误区是……这里要问的
> 应该是**为什么要做这件事，不是说为什么能做这件事**

**No jargon, no invented vocabulary.** Shorthand generated during your own work
is not language the reader shares.

> "同一批代表 episode 并行比较 10/16/10 与历史 8+2" 不要说黑话，这是什么意思？

**State what was *not* done.** A report of what happened, without the boundary
of what did not, silently invites the reader to assume more ran than did — no
training, no rollout, no commit, no formal result, whatever applies.

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

**A name must be bound to its configuration by the program, not by convention.**
A directory, config, or run whose name asserts one setting while another is
actually loaded is not a naming inconvenience — it misleads every log, report,
and conclusion downstream. The name is a parseable check label; a parse that
disagrees with the resolved configuration must terminate the command.

> 一个名字说是 predicted BC 实际上跑起来在用另一组设定，这件事是如何发生的？
> 如果永远避免以后发生？ … 我不管起什么名字，都能 fail-fast 快速发现名字不对、
> 实际配置不对

**Trust no self-report — derive from the evidence.** A validator must recompute
every check and the overall verdict from the underlying artifacts; a passed flag
in the object being checked is an input to be verified, never a conclusion to be
accepted. Reviewing someone's work means opening the files, not reading their
summary, and every finding cites `file:line`.

**Wording must match the measured error.** A non-zero RMSE is not
`bitwise identical`. Do not claim a property you have not verified, and do not
fill a gap with an invented value.

**A threshold you invented is not a contract.** An assistant's prior about what
counts as close enough does not become an acceptance criterion by being written
down confidently. The criterion is whatever the owner actually asked for.

**Trust the artifact over any description of it.** When sources disagree about
what ran:

```
recorded runtime tensor / actual input
> checkpoint or artifact metadata
> resolved runtime config
> the identity string parsed from a name
> directory names, labels, nicknames
```

**Do not report in nicknames.** A shorthand that was convenient in conversation
is not a description of what ran. Expand it, or point at the record.

**Mark what did not enter the pipeline.** Any number shown beside a result — in
a report, a plot, or a debug view — must make clear whether it entered the
evaluated path. Never introduce a diagnostic that is absent from the pipeline
being evaluated without labelling it as such.

**A command that starts is not a command that is verified.** Neither is one that
runs to completion without the relevant checks having passed.

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

**A check that does not actually exercise the thing rules out nothing.** If a
check earns its place, it runs the real path — the real container, the real
subprocess, the real scoring. A static string assertion, a fully mocked call, or
a silent skip when the hardware is absent is not cheaper verification; it is the
appearance of verification. Mock only for targeted failure injection around a
real path.

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

## One Variable

**One experiment changes one thing.** A run in which two things moved produces a
result that attributes to neither. This is cheap to violate and expensive to
detect afterwards — the numbers still look like data.

> 刚才的实验不是同时变了多个变量么 … recurrent 梯度长度和 carry 同时变化了

Before adding a second change: is the existing result already in the records?
Repeating an experiment someone already ran is the other half of this waste.

## In-Domain Before Out-Of-Domain

**Verify the easy case works before claiming anything about the hard one.** A
generalisation result on top of an unverified in-domain result is
uninterpretable: a failure could be the generalisation or could be the whole
pipeline.

> 必须先看 S 地图（即训练地图）的表现 … 然后才谈得上进一步去测试和分析泛化地图

The same shape applies to any claim of the form "it also works on X" — establish
that it works at all, on the case it was built for, first.

## Figures Are Evidence Or They Are Decoration

A figure presented as the state of things must be drawn from **real data**. A
schematic that illustrates what the result would look like is a diagram, and it
must be labelled as one.

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
| "The check disagreed but the run looks fine" | Fail closed. A mismatch is a run that did not happen, not a result with a caveat. |
| "I'll add a fallback so it keeps running" | Silent fallback is the single largest source of poisoned results here. Let it crash. |
| "Wrap it in try/except to be safe" | Safe for whom? A masked exception costs weeks; a stack trace costs minutes. |
| "GPU is unavailable, run on CPU" | Downgrade-and-continue is forbidden. Crash and let the human decide. |
| "Let me report where I've got to" | A progress report is not a completion. Finished, or a specific blocker. |
| "While I'm here I'll also fix..." | Do not broaden scope. Conclude with the exact fix, result, or blocker. |
| "It probably failed because..." | Do not guess a cause. Open the script or the result file. |
| "The number is close, I'll adjust the tolerance" | Expected numbers are declared before the work. A mismatch stops it. |
| "The directory says it's the right config" | A name that is not program-bound to its configuration is misleading, not convenient. |
| "The report says all checks passed" | Recompute the verdict from the artifacts. A passed flag is an input, not a conclusion. |
| "I'll use the other file, it's the same shape" | A missing critical artifact is not substitutable. Stop and report. |
| "I'll re-run it with a quick fix" | Stop and report first. A fix over an unseen failure makes the cause two things. |
| "Here's a diagram of what it looks like" | If it is presented as the state of things, draw it from real data or label it a schematic. |
| "You're right, that's a great point" | Do not agree to be agreeable. State the disagreement, or say nothing. |
| "The directory name says it is the right checkpoint" | Names are the weakest evidence there is. Read the artifact. |
| "It ran to completion, so it worked" | Completing is not verifying. Which check proves the claim? |

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

**Read one phase profile and one profile per execution axis. Do not preload
everything.**

| Phase | Profile | Its criterion |
|---|---|---|
| `MAIEUTIC` | `references/maieutic.md` | Would the answer change the mechanism, endpoint, run, or budget? |
| `RAPID_PROTOTYPE` | `references/rapid-prototype.md` | The admission test. |
| `BATTERING_RAM` | `references/battering-ram.md` | Is this the backswing, or building a new ram? |
| `CONFIRMATION` | `references/confirmation.md` | Would this threat overturn the claim, and is it worth the cost? |

| Execution | Profile |
|---|---|
| `DAY_INTERACTIVE` | `references/day-interactive.md` |
| `OVERNIGHT_UNATTENDED` | `references/overnight-unattended.md` |
| `SINGLE_THREAD` | `references/single-thread.md` |
| `SUBAGENT_DRIVEN` | `references/subagent-driven.md` |

Also: `references/rng-policy.md` when seeds are in question.

Examples inside a profile are calibration, **not a checklist** — the criterion
governs, and uncovered cases are judged by the criterion and its purpose.
