# DAY_INTERACTIVE + SINGLE_THREAD

The one execution combination currently written. These are execution control and
resource accounting — they carry no conceptual anchor, because attaching one
would manufacture ceremony where none is needed.

## DAY_INTERACTIVE

The owner is available. That availability is a resource, and the characteristic
waste of this mode is failing to spend it.

- Short feedback loops. Surface a consequential choice immediately rather than
  silently freezing an assumption and discovering it was wrong six hours later.
- Show partial real results as they appear, not only finished ones.
- One high-information question beats an hour of guessing. A question earns its
  place when the answer would change mechanism identity, the direct endpoint or
  comparator, the smallest faithful run, or the next decision and its budget.
- The status block is required at formal updates and decision boundaries only —
  not on every turn. Reporting cadence is not a substitute for results.
- Do not stop for approval on ordinary implementation, training, testing, and
  non-destructive failure recovery. Stop for new permissions, external
  credentials, missing hardware, destructive data operations, or a decision that
  would change terminal acceptance criteria.

## SINGLE_THREAD

Preferred when work shares mutable state, when ordering and coherence dominate,
or when delegation overhead would exceed the parallelism gained.

- All token spend accrues to one counter; there is no aggregation problem, so
  the accounting in the core applies directly.
- A long-running job does not require a second agent to watch it. Waiting is not
  agent churn and costs nothing against the evidence budget.

## Choosing against these

Switch to `OVERNIGHT_UNATTENDED` when the owner will be away and the work needs
a bounded goal, a mutable progress ledger, explicit authority limits,
resumability, and precise blocker reporting.

Switch to `SUBAGENT_DRIVEN` for genuinely independent investigations, matched
experiment arms, or long-job monitoring — assigning bounded ownership and keeping
the main agent on the critical path.

Neither profile is written yet. Until they are, staying in this combination is
the correct default, and the core's accounting rules still bind if you leave it —
in particular, tokens from all participating agents aggregate.
