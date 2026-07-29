# SINGLE_THREAD

One agent, one line of work. The default.

Execution control, not epistemology. No conceptual anchor.

## Prefer this when

- the work shares mutable state — the same files, the same checkpoint directory,
  the same cache
- ordering and coherence dominate: step N genuinely needs step N-1's answer
- delegation overhead would exceed the parallelism gained, which is most small
  and medium tasks

## What it buys

- **Accounting is trivial.** All effort accrues to one counter, so the core's
  budget rules apply directly with no aggregation.
- **No duplicated work**, because there is nobody to duplicate it with.
- **No merge surface.** Two agents editing the same file is a cost that has to be
  paid back before any parallelism shows up as speed.

## Waiting is free

A long-running job does not need a second agent to watch it. Waiting burns no
effort and costs nothing against the evidence budget.

Spawning a monitor for a job that will simply finish is a way of appearing busy.
If the job needs watching because it can hang or die silently, that is a real
reason; "so something is happening" is not.

## Choosing against this profile

Switch to `SUBAGENT_DRIVEN` when there are genuinely independent pieces of work —
separate investigations, matched experiment arms, or long jobs that really do
need monitoring. The test is whether the pieces can run without shared mutable
state and without waiting on each other.

Being busy is not a reason. Wanting results faster is not a reason unless the
work actually parallelizes.
