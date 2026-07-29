# Research Collaboration Mode — Specification

Status: **implemented as `research-mode` v0.**

This document matches the shipped skill in `skills/research-mode/`. Where the
two ever differ, the skill is what runs and this document is the bug.

The design discussion that produced it — including the proposals that were cut,
and why — is preserved separately, in the private research repository where the
originating experiment lived. It is not needed to use or extend this one.

A skill is an SOP for an agent — accumulated working experience and
collaboration conventions. It is not a compliance system. This specification is
written to that standard: every clause below either changes what an agent does
next, or it does not belong here.

## 1. The problem

Research fails two ways. One is fooling yourself about what you built. The other
is never finding out, because the budget went to process.

The second one is what prompted this. From a real session:

```
elapsed:                10+ hours
spend:                  large
tests written:          thousands
curves from real data:  zero
```

A negative result was being reproduced across multiple seeds to make it
"rigorous". The owner had asked for a model implemented, trained, and tested,
expecting results to iterate on, and received a still-running test suite.

The correct rules already existed in writing and were followed to the letter.
"A negative result receives only cheap sanity checks" was on the page. So the
diagnosis is not that rules were missing:

> **Nothing made "no result yet" visible or costly.**

That is the gap this framework closes, and it is the reason the framework must
not itself become more process. More process is not more scientific.

## 2. The iron law

```
ONLY A REAL RESULT COUNTS AS PROGRESS.

BEFORE THE FIRST ONE, RIGOR MEANS ONLY:
SAY WHAT ACTUALLY RAN, AND DO NOT LEAK.
```

Stated at length, because this sentence is the load-bearing one:

> Before the first direct target-facing result, rigor means preserving
> scientific identity and preventing leakage — not maximizing test coverage,
> repeatability, documentation, or review completeness.

Tests, refactors, documentation, figures, review, diagnostics, and launching a
job are not progress. They are often necessary. They are still not progress.

A direct result comes from real data or a real environment, measures the
endpoint that was declared, and can change what happens next. Training loss and
throughput are real numbers, but they are not direct results unless they were
declared as the endpoint.

## 3. Reporting order

Every progress report follows this order:

```
1. WHY this is worth doing, and how it relates to the main goal
2. WHAT is being done and what the result means — in plain language
3. ONLY IF USEFUL: filenames, hashes, contracts, parity, step counts
```

Detail that would not change the reader's understanding or decision is left out.

> A report that opens with a hash has buried what the reader needed.

This replaces the structured status block proposed during design. A fixed field
dump front-loads exactly the material this rule pushes to the end.

## 4. The two floors

Never traded away, in any phase. Everything else is phase-dependent and can wait.

### Say what actually ran

The claimed mechanism must equal the computation actually executed. Be able to
state, on demand:

- which tensors entered the model — name, shape, axis semantics, source frame
- what the supervision was, and which frame it came from
- which checkpoint and step, and the rule that selected it
- how state was initialized, reset, and carried

None of it may be inferred from a directory name, config name, nickname, or UI
label. **If you cannot state it, it is not a result.**

Write it down once per mechanism and point at it afterward rather than restating
it in every report. No identifier scheme is required for this; a named section
in the working document is enough.

Changing a mechanism because of a result is legitimate research. Changing it and
still reporting under the old description is not.

Where the repository defines its own construct-validity rules — as this one does
in `AGENTS.md` — those rules are how this floor is discharged here, and they
bind. The generic statement above is the fallback that makes the skill portable.

```
immutable scientific goal > repository construct-validity rules
> these two floors > phase and execution profiles
```

### Do not hack the result

- no evaluation-set information in training, normalization, checkpoint
  selection, or hyperparameter selection
- no changing a definition to fit a result
- no keeping only favorable runs, no retrying until it looks good, no deleting
  unfavorable trajectories
- no proxy reported as a terminal endpoint
- no weakening a validator to make an old command run

## 5. Phases

Four research phases. They are not collapsed into coarser states: `MAIEUTIC` and
`RAPID_PROTOTYPE` have different legal outputs — an executable description
versus a first direct reading — and merging them reintroduces the ambiguity of
"should I keep asking or start running".

| Where you are | Phase |
|---|---|
| No executable mechanism description yet | `MAIEUTIC` |
| Executable, but no result from real data yet | `RAPID_PROTOTYPE` |
| A result says it is worth pursuing, and a specific gate is named | `BATTERING_RAM` |
| Strong positive result on the primary endpoint, **and** the owner authorized confirmation | `CONFIRMATION` |

Execution style is orthogonal and composes with any phase:
`DAY_INTERACTIVE | OVERNIGHT_UNATTENDED` and `SINGLE_THREAD | SUBAGENT_DRIVEN`.

**Uncertain between two adjacent phases: pick the earlier, cheaper one.
Uncertainty is never a reason to enter `CONFIRMATION`.**

A strong result makes a project *eligible* for confirmation; it does not by
itself authorize the budget. A first prototype result strong enough to qualify
goes directly — there is no requirement to pass through `BATTERING_RAM`.

A negative result gets the cheapest checks that rule out an implementation or
alignment mistake, then a decision to revise or abandon. It never triggers
`CONFIRMATION`.

### `MAIEUTIC` — midwifery

Socrates, whose mother Phaenarete was a midwife, called his method μαιευτική: he
is barren of wisdom himself and only helps others deliver what is already in
them. The second duty of the art is judging whether the newborn is genuine or a
wind-egg.

Two duties, not one: deliver the owner's unformed research intent into an
executable mechanism, *and* judge whether what was delivered can bear empirical
weight. The midwife is not a passive stenographer — Socrates induces, presses,
tests, and discards false offspring. "Barren of wisdom" forbids passing your own
research goal off as the owner's; it does not forbid judgement.

**Criterion:** would the answer change the mechanism, the endpoint or comparator,
the smallest faithful run, or the next decision and its budget? If not, do not
ask — settle it by repository convention.

**Completion condition:**

```
The mechanism is executable, AND the claim names an observable result or pattern
of results that would force rejection, narrowing, or revision.

One sentence. Not preregistration, statistics, multi-seed, or power analysis.

No defeater means no experiment and no budget.
```

Stated as a pattern of results rather than "one run that refutes it", because
probabilistic and distributional claims are often not overturned by a single run.

A wind-egg is not necessarily a bad idea. It is an idea that has not yet earned
the right to consume experimental budget. "Improves the model's understanding of
spatial structure" can be a valuable research *intent*; until someone can say
what result would make us concede it did not improve, it cannot proceed.

Externalize the owner's intent accurately *before* proposing anything. Bounded
alternatives are appropriate at a genuine scientific fork, at a
construct-validity risk, or on request. What is prohibited is treating your own
alternative as the default answer before the owner's intent has been faithfully
reconstructed.

**Stop condition:** the moment the plan can be written in under two minutes and
the claim has a named defeater, stop asking and start.

### `RAPID_PROTOTYPE` — the ranging shot

The first round is not for hitting; it is for seeing where it lands so aim can be
corrected. It must be a real gun firing real ammunition at the real target — but
it needs neither a full charge nor five rounds to characterize dispersion.

That image explains all three constraints at once: the run must stay faithful
because a simulator round has a different trajectory; multi-seed is wrong because
dispersion is not what is being measured; a proxy endpoint is fatal because it
measures a different gun.

**Criterion:** the admission test of Section 6.

```
A smallest faithful run may reduce sample count, training steps, model width,
and non-critical data volume.

It may not sever the path, time span, state, feedback, or reset/carry semantics
the claimed mechanism depends on, and it may not substitute a proxy for the
declared endpoint.

What shrinks is cost, not scientific identity.
```

Reuse is qualified: prefer existing assets whose provenance, alignment, and
identity are known. Reuse is *not* required for assets of unknown origin or
unclear frame semantics, or where verifying the old asset costs more than
rebuilding a minimal one. Otherwise "reuse the cache" is satisfied to the letter
by an archaeology expedition.

**Stop condition:** once the first interpretable result exists, report it and
make the decision. Remaining budget is not a reason to keep adding tests,
polishing code, or gathering extra results.

### `BATTERING_RAM` — the ram

Stepping back and summarizing is the backswing, not going home to rebuild and
polish the ram.

**Criterion:** is this the backswing, or building a new ram?

```
Every strike must be authorized by the previous evidence or its minimal
diagnosis, and must move exactly one named causal lever.

If the previous strike did not change our judgment of where the failure is or
which lever comes next, repeating a parameter sweep is churn, not siege.
```

One failure earns one minimal diagnosis answering only "which layer broke", then
the next strike. No diagnosis of diagnosis. No rebuilding infrastructure after a
single failure.

Hold the same scientific question; never move the target silently. The
measurement contract and the mechanism are separate things:

```
mechanism semantics change              -> new mechanism, return to prototyping
endpoint/comparator shown invalid       -> end this sequence, re-prototype the
                                           measurement; the mechanism may stand
endpoint/comparator changed only
  because results look bad              -> moving the goalposts
```

Parallel independent arms belong to the execution profile, not here.

**Stop condition:** stop when the gate is resolved, when the mechanism needs to
change, or when successive strikes stop reducing the key uncertainty. No fixed
strike count — the criterion is information gain.

### `CONFIRMATION` — load acceptance

The building is up and looks habitable; now prove it bears load. Acceptance items
are chosen by *how this building could collapse*, not copied from a generic form
— copying the form means seismic-testing a bungalow while missing that it sits
on sand.

**Criterion:** if this threat holds, would it overturn the claim, and is it worth
its cost?

Enumerate the threats that could overturn the claim — identity failure, leakage,
unfair comparator, alternative explanation, evaluation misalignment, data
distribution, RNG — and verify only those that genuinely could. Confirmation does
not automatically require multiple seeds, nor a full ablation suite, only the one
or two that discriminate between competing explanations.

Threat generation is ranked and bounded. A remotely imaginable failure is not a
live threat without a plausible route to overturning the claim. Start with the
highest-impact one; do not build an exhaustive catalogue before testing anything.

```
Confirmation protects only the claim actually made. It is not responsible for
proving general robustness, validity under all distributions, stability under
all initializations, or the impossibility of every alternative explanation.

When confirmation overturns part of the claim, the legal move is to narrow,
downgrade, or withdraw it — not to keep expanding the confirmation matrix until
the original claim survives.
```

**Stop condition:** confirmation ends when the pre-selected high-impact threats
are resolved, or when the claim has been narrowed to what the evidence supports.
There is no obligation to complete a generic reviewer checklist.

## 6. Before non-trivial work, say what you are testing

A few lines, written in under two minutes. Not needed for a rerun, one
hyperparameter, or one plot.

```
- the claim, and which mechanism it belongs to
- the endpoint, and what it is compared against
- the smallest faithful version of the run
- what positive, negative, and ambiguous would each mean
- the budget
```

**Writing this must cost far less than running the experiment.** If it cannot be
written, the idea is not formed — go form it rather than elaborating the
description.

It covers a bounded set of runs while the mechanism, claim, endpoint, comparator,
and the one lever being moved all stay fixed. Change any of those and say so
again. This is a hypothesis-and-decision unit, not a form filed per command.

### The admission test

Before launching anything, extra work is justified only if **both** hold:

```
1. the failure it rules out would make the next result uninterpretable
2. it is the cheapest way to rule that failure out
```

Name the run it unblocks. Tests, refactors, diagnostics, and review do not
qualify merely because they are normally good practice.

This governs *extra* verification proposed by the agent. **It never excuses
skipping an identity check the repository mandates** — those belong to the first
floor and always run.

## 7. Budget

Give each piece of work a budget before starting it, sized to that work.

**There are no standing default numbers.** A threshold calibrated on one
mechanism does not transfer to the next, and a default that survives contact with
every task is a default that never fires. The forcing function is the
declaration: naming a budget requires estimating what the work should cost, which
is exactly the judgement that goes missing when an agent drifts from
implementation into open-ended verification.

Count effort in tokens, not wall-clock. Waiting on a human or on a running
training job burns nothing — what is bounded is effort, not elapsed time. This
distinction matters: wall-clock conflates the good state (an experiment is
running) with the bad one (the agent is churning).

If the harness reports usage, read it. Otherwise estimate from time spent
actively working, which excludes waiting on the user, queue waiting, blocking
training jobs, and passive tool runtime, and includes polling, re-reading logs,
and re-planning. **An estimate wrong by 2x still catches an overrun by 10x.**
"I cannot measure this" is not an answer.

A new session, a compacted context, a retry, or a renamed mechanism does not
reset what has already been spent. Otherwise every meter has an escape hatch.

When the budget is gone, there are exactly three honest things to say:

| Say | Not |
|---|---|
| the running command, its job id, when the first number lands | "I am writing tests" |
| the number, what it was compared against, what it changes | "I am verifying" |
| the specific missing file, tensor, credential, or hardware, and the smallest action that unblocks it | "I am refactoring" |

## 8. Seeds

Seed robustness is not a default research requirement. Two things routinely
conflated stay separate:

> **Not cherry-picking seeds is a floor. Proving seed-insensitivity is a specific
> research question, not a standing duty.**

Default: one recorded seed; compare arms under the same random conditions. A
fixed seed is usually *more* informative while prototyping, because it removes
irrelevant variation so an outcome change is more attributable to the mechanism
change.

Multi-seed work is justified only when RNG sensitivity is an explicit decision
variable — randomness is part of the claimed mechanism, outcomes materially
change across incidental reruns, the claim concerns a distribution over runs, or
a bounded final-reporting requirement was explicitly selected. When justified, it
is its own piece of work with its own question, budget, and stopping rule, not a
tax attached silently to every experiment.

Never inspect many seeds and selectively retain favorable runs. Changing a seed
is allowed; seed mining and selective reporting are not.

Run-to-run variation is **not** a reusable framework constant: it differs across
mechanisms, training stages, data subsets, and initialization regions.

The default response to a negative prototype result is to check the mechanism was
actually executed, check alignment, reset, and leakage, then accept the result and
decide. Not: run five more seeds to prove it failed.

Full policy ships at `references/rng-policy.md`.

## 9. Letter versus spirit

Read these conventions by the purpose they protect. Where literal compliance
would defeat that purpose, make the **smallest** change that restores it, and ask
what the author would have written had this case been known.

This is Aristotle's `ἐπιείκεια` — equity. Not "I judge the intent more important,
so I need not comply", but "literal compliance is destroying what this rule
protects, so correct it minimally".

**It never overrides:** a goal, prohibition, or hard constraint the user
confirmed; a method the user stated is itself required; the immutable goal of the
work; saying what actually ran; leakage boundaries; scientific integrity; a
declared hard resource cap; repository safety rules.

A method offered as a guess about the environment is not automatically a
constraint. Three cases stay distinct:

```
"make sure this link is reachable"       -> the goal
"you'll probably need a proxy for that"  -> a conjecture about the environment
"test it through the specified proxy"    -> the method IS the constraint
```

Mention a deviation only when it materially changes the phase, the mechanism,
what is being tested, the endpoint, the comparator, the budget, or what gets
reported. Small implementation choices need no announcement, or the rule becomes
its own logging tax.

## 10. What ships

```
~/.codex/skills/research-mode/
  SKILL.md                                    the SOP; always loaded when triggered
  references/rng-policy.md                    full seed policy
  references/rapid-prototype.md               phase profile
  references/day-interactive-single-thread.md execution profile
  agents/openai.yaml                          UI metadata
```

Read one phase profile and one execution profile; do not preload everything.
Examples inside a profile are calibration, **not a checklist** — the criterion
governs, and uncovered cases are judged by the criterion and its purpose.

Structural borrowings from Superpowers are deliberate: an always-loaded entry
point that identifies state and routes, capability loaded on demand, red-flag and
rationalization tables, an iron law, and a "why this matters" grounded in a real
incident. Not borrowed: the linear spec → plan → TDD → review → finish pipeline,
hard gates forbidding action until process completes, and treating every phase as
a final deliverable.

Explicitly **not** used, after surveying fourteen reference skills, none of which
use them: identifier namespaces, status blocks, and forms.

### Binding a project to it

Installing the skill is not enough. A skill loads when it triggers; these
conventions need to apply from the first message of a session. That takes one
short paragraph and a link in whatever file the harness reads first —
`AGENTS.md`, `CLAUDE.md`, or equivalent. The paragraph is in the repo README.

Three things then live in the project rather than in the skill:

- **the project's own construct-validity rules** — canonical identity contracts,
  hash binding, evidence ordering. These are how the first floor is discharged
  there, and they take precedence over the portable statement.
- **the current phase and execution mode**, somewhere a session reads early.
- **phase transitions and their reasons**, in whatever progress ledger exists.

**Not in an immutable goal document.** A goal describes direction and terminal
acceptance. Loading day-to-day collaboration method into it invites reading the
terminal criteria as the current implementation scope — one of the ways the
original failure happened.

One practical trap: a project that git-ignores its docs directory behind an
explicit allowlist will silently fail to add a new normative file there. Run
`git check-ignore -v <path>` rather than assuming the commit worked.

## 11. What is next

Validation is skill-creator validation plus real use. Staged agent evaluations
are deliberately not part of this — building an evaluation harness before knowing
whether the skill helps would be this framework's own first counterexample.

`MAIEUTIC`, `BATTERING_RAM`, and `CONFIRMATION` phase profiles, and the
`OVERNIGHT_UNATTENDED` and `SUBAGENT_DRIVEN` execution profiles, are not written.
Their criteria and stop conditions are in Section 5 and bind already. They get
written when real use shows they are needed, in that order, one at a time.

When `research-confirmation` is eventually split into its own skill, it should
carry `policy.allow_implicit_invocation: false` in `agents/openai.yaml`, so that
"do not self-invoke" is enforced by the loader rather than by prose a
conservative agent can rationalize past.

## 12. Conceptual anchors (non-normative)

These are calibration lenses, not authorities. No rule here is valid because a
philosopher said it. The value is that people have thought hard about closely
related epistemic problems, and borrowing their distinctions is a cheap way to
check this design for missing pieces, substituted goals, and drift toward
extremes.

An anchor earns a place only if it does all three: explains why an actual rule
exists; produces a concrete misuse-check question; and states what must **not**
be imported with it.

Sources are cited by work and passage rather than URL, from knowledge, and have
not been re-verified against the texts. Verify before any external publication.

| Phase | Anchor | Lens question | Do not import |
|---|---|---|---|
| `MAIEUTIC` | Plato, *Theaetetus* 149a–151e: midwifery, and judging the true child from the wind-egg | Is this idea yet willing to bear failure? | The midwife as passive stenographer. Socrates induces, presses, tests, discards. |
| `RAPID_PROTOTYPE` | Exploratory experimentation; the Bacon–Boyle distinction between experiments of light and of fruit | Is this run illuminating the mechanism, or manufacturing something that looks like an achievement? | "Exploratory" does not mean arbitrary search, an unfaithful toy path, a proxy endpoint, or that every parameter is worth sweeping. |
| `BATTERING_RAM` | Peirce's abduction–deduction–test cycle, under Lakatos' progressive versus degenerating problem-shift | What do we now know about *why the door did not open*, such that the next strike must be this one? | **Lakatos' hard core / protective belt, entirely.** A conservative agent reads it as licence to protect the mechanism indefinitely and absorb every failure into auxiliary conditions — the exact firefighting this framework exists to stop. |
| `CONFIRMATION` | Mayo's severe testing: a test supports a claim only if it could have exposed the error had it been present | Would this check have caught the error if the error were there? | Mayo's full statistical philosophy. Do not misread "severe" as "numerous, expensive, procedurally complete". Borrow the counterfactual question; leave the statistical package. |
| all | Aristotle, *Nicomachean Ethics* V.10: `ἐπιείκεια`, equity — correcting law where its universality errs in a particular case | What would the author have written had they known this case? | Equity reaches operational rules only. Never the floors, the immutable goal, integrity, explicit instructions, or declared caps. |

`DAY_INTERACTIVE` / `OVERNIGHT_UNATTENDED`, `SINGLE_THREAD` /
`SUBAGENT_DRIVEN`, and the token and spend meters get **no** anchors. They are
execution control and resource accounting. Attaching philosophical names to them
would manufacture exactly the decorative ceremony this framework exists to
prevent.
