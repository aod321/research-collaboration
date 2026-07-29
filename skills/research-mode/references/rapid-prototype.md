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
