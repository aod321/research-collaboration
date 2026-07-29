# OVERNIGHT_UNATTENDED

Nobody is watching. Every question you would have asked must instead be either
decided under stated authority, or reported as a named blocker.

Execution control, not epistemology. No conceptual anchor.

**The characteristic failure is coming back to nothing** — a session that spent
the night blocked on a decision it was authorized to make, or that ran and left
no way to tell what happened.

## Before starting, four things must exist

```
1. a bounded goal        what "done" means, written down, not inferred
2. a progress ledger     mutable, append-only in practice, separate from the goal
3. authority limits      what may be decided alone, and what must stop and report
4. resumability          the work survives a crash, a restart, or a fresh session
```

If the goal is not bounded, do not start. An unbounded goal plus no supervision
is how a night is spent on infrastructure.

## Goal and ledger stay separate

The goal states direction and terminal acceptance. **It is not edited to record
progress, and it is never edited to make a failure look like a success.**

Progress, failures, commands, job ids, artifacts, and next actions go in the
ledger. This separation is what stops "we hit the goal" from being achieved by
rewriting the goal.

## Default authority

Proceed alone on: implementation, training, evaluation, testing, diagnosis,
non-destructive recovery from failure, and a versioned revision of the mechanism
after a failure.

Stop and report on: new permissions, external credentials, missing hardware or
assets, destructive data operations, and anything that would change terminal
acceptance criteria.

**Never** on: deleting existing data, caches, checkpoints, outputs, or the
owner's uncommitted work; bypassing a validator; fabricating completion;
substituting a failed seed; deleting an unfavorable trajectory.

## Long jobs

A launched job is not a finished job. Every long run needs a resumable
checkpoint or manifest, and something that notices when it dies.

**"The command has started" is not a result.** It is a legal status exactly once;
after that, the next update needs a state change.

## Blocker reporting

A blocker report is only useful if it can be acted on without a conversation:

```
- the exact command or log location that failed
- the specific missing tensor, file, credential, or hardware
- the smallest action that would unblock it
- what was tried instead, and why it did not work
```

"Need user input" is not a blocker report.

## Stop condition

Declare blocked only when the **same** concrete obstacle has recurred across
repeated attempts and every safe alternative, recovery, and existing artifact has
been exhausted.

Budget exhaustion, difficulty, one failed training run, one failed candidate, or
a process exit are **not** completion conditions. Recover, repair, or form the
next candidate and continue.

## On return

Report in the core's order: why the night's work mattered, what happened in plain
language, then artifacts and identifiers. Lead with the result or the blocker —
not with a chronological log of everything attempted.
