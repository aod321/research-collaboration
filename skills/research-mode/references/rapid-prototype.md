# RAPID_PROTOTYPE

**Analogy: the ranging shot.** The first round is not for hitting; it is for
seeing where it lands so aim can be corrected. It must therefore be a real gun
firing real ammunition at the real target — but it needs neither a full charge
nor five rounds to characterize dispersion.

That one image explains all three constraints at once:

- the run must stay faithful, because a simulator round has a different
  trajectory and its landing point tells you nothing;
- multi-seed is wrong here, because dispersion is not what is being measured;
- a proxy endpoint is fatal, because it measures a different gun.

**Criterion:** the admission test. A pre-launch task is legitimate only if the
failure it excludes would make the next direct result uninterpretable, *and* it
is the lowest-cost way to exclude that failure.

## Smallest faithful run

```
A smallest faithful run may reduce sample count, training steps, model width,
and non-critical data volume.

It may not sever the path, time span, state, feedback, or reset/carry semantics
that the claimed mechanism depends on, and it may not substitute a proxy for the
pre-declared direct endpoint.

What shrinks is cost, not scientific identity.
```

`smallest` lowers cost. `faithful` guarantees that what comes back is still
information about the mechanism you claimed. A run that met its launch budget by
becoming unfaithful has produced nothing.

## Reuse, qualified

Prefer existing assets whose provenance, alignment, and identity are known.

Reuse is **not** required for assets of unknown origin or unclear frame
semantics, or where verifying the old asset costs more than rebuilding a minimal
one. Otherwise "reuse the cache" is satisfied to the letter by an archaeology
expedition.

## Let the small run find the problems

The alternative to a cheap real run is sitting and imagining what might go
wrong. That is unbounded, and it finds the failures you can already picture
rather than the ones actually there.

> 先用小代价的局部预实验/smoke 实验先跑一下 … 这样好处是不用费好几个小时反复想
> 还有什么没有封堵的隐患，而是根据实际小试验情况，直接针对问题做处理

A smoke run establishes that the chain executes. **It is not a scientific
result**, and its passing is not evidence about the mechanism.

**A cheap offline gate that fails is already a mechanism conclusion.** Do not
escalate to the expensive run to confirm it.

**A diagnostic that takes six hours is not a diagnostic.** If every question
costs most of a day, the question is wrong or the harness is. Shrink it until it
answers within a couple of hours.

## Searching a space

Explicitly asked to be remembered, so recorded here rather than in the body:

> 自顶向下，树状展开，并行探索，面向高 ROI 收束

Establish whether a direction works before refining any implementation detail
inside it. Branch broadly, run independent branches in parallel, converge on the
highest-information one rather than walking the tree evenly.

Parameter search is legitimate; blind search is not. Spend where the evidence is
strongest or the payoff largest, not uniformly.

## Stop condition

Once the first interpretable direct result exists, report it and make the
research decision. Remaining token budget is not a reason to keep adding tests,
polishing code, or gathering extra results.

## Calibration examples

Examples, not a checklist. The criterion governs.

**Typically passes the admission test**

- verifying the shape and axis semantics of the tensor actually entering the
  model
- verifying frame alignment — `t` versus `t-1`, pre- versus post-command
- verifying reset and carry across episode boundaries
- verifying the training set contains no evaluation-set information
- reusing an existing cache, checkpoint, or code path of known provenance

**Typically does not**

- a full unit-test matrix
- numerical-equivalence sweeps such as chunk parity, unless divergence would
  silently change mechanism semantics
- building the complete cache when a small sample can run
- multi-seed runs
- refactoring, abstraction, configuration systematization
- finishing tests and documentation before daring to report a result you already
  have

## Conceptual anchor

```
Anchor:              exploratory, light-bearing experiment. Early experiments
                     discover phenomena, find regularities, and set the next
                     question; they need not adjudicate a mature theory. The
                     first faithful run buys light about the mechanism, not
                     fruit.
Design consequence:  the prototype objective function — value is the next
                     research decision the run enables, not a polished artifact.
Do not import:       "exploratory" does not mean arbitrary search, does not
                     license an unfaithful toy path, does not let a proxy stand
                     in for the direct endpoint, and does not make every
                     parameter worth sweeping.
```

Lens questions when unsure:

- Is this run illuminating the mechanism, or manufacturing something that looks
  like an achievement?
- It is small enough — but does it still preserve the full path from the claimed
  mechanism to the direct endpoint?
