# BATTERING_RAM

**Analogy: the ram.** Stepping back and summarizing is the **backswing** — not
going home to rebuild and polish the ram. The target is the *same door*.

This is the phase where an agent stays longest, and the one that degenerates
most easily. The characteristic failure is not giving up too early. It is
looking extremely busy — new diagnostics, tidier code, another threshold — while
drifting further from the door.

**Criterion:** is this the backswing, or building a new ram?

## Every strike must be authorized

```
Every strike must be authorized by the previous evidence or its minimal
diagnosis, and must move exactly one named causal lever.

If the previous strike did not change our judgment of where the failure is or
which lever comes next, repeating a parameter sweep is churn, not siege.
```

One failure earns **one** minimal diagnosis, answering only "which layer broke".
Then the next strike. No diagnosis of diagnosis. No rebuilding infrastructure
after a single failure.

Moving a threshold from 0.3 to 0.4 without being able to say which failure
explanation it tests is knocking on the wall at random.

**Strike the mechanism, not the symptom.** A run of local patches, each
addressing wherever the failure last surfaced, is the clearest sign the siege
has degenerated — it looks like steady work and moves the door not at all.

> 我怎么感觉你最近几条不本质呢，只是打补丁？没有从原因和机制分析出发，就像头疼
> 医头，脚痛医脚，不通病理

## Hold the same question

Never move the target silently. The measurement contract and the mechanism are
separate things:

```
mechanism semantics change          -> new mechanism, return to RAPID_PROTOTYPE

endpoint/comparator shown invalid
  by evidence                       -> end this strike sequence, re-prototype
                                       the measurement; the mechanism may stand

endpoint/comparator changed only
  because results look bad          -> moving the goalposts
```

The third one is not a transition. It is the thing this phase exists to prevent.

Parallel independent arms are an execution decision, not a phase decision. See
the orchestration profile.

## Stop condition

Stop attacking when **any** of these holds:

- the gate is resolved;
- the mechanism itself needs to change;
- successive strikes stop reducing the key uncertainty.

There is no fixed strike count. The criterion is information gain. "One more
hit" is not a reason to extend indefinitely.

## Calibration examples

Examples, not a checklist. The criterion governs.

**Backswing — legitimate**

- one bounded diagnostic that discriminates between two named failure locations
- reading the trace of the last failure to locate which layer broke
- a strike that moves one lever the previous evidence pointed at
- running independent arms concurrently when each answers the same gate

**Building a new ram — degeneration**

- a second diagnostic to interpret the first diagnostic
- refactoring, generalizing the config, tidying the code
- sweeping a threshold with no explanation attached to the sweep
- adding a proxy metric and reporting its improvement as progress
- rebuilding the data pipeline because one strike failed
- changing what is measured because the current measurement is unflattering

## The question after every strike

> What do we now know about **why the door did not open**, such that the next
> strike must be this one?

If the answer is only "the code is tidier", "the config is more general", "three
more diagnostics exist", "a proxy went up", or "let us try another threshold" —
that is degeneration, not a backswing.

## Conceptual anchor

```
Anchor:              Peirce's abduction-deduction-test cycle, under Lakatos'
                     distinction between progressive and degenerating
                     problem-shifts. A surprising result provokes an explanation;
                     deduction draws a discriminating consequence; the next
                     strike tests it. A programme can look busy while drifting
                     from its original target.
Design consequence:  minimal diagnosis is legitimate not because diagnosis is
                     progress, but because it determines where the next strike
                     lands. Hence: no explanation provoked by the previous
                     evidence, no licence for the next parameter change.
Do not import:       Lakatos' hard core / protective belt, entirely. A
                     conservative agent reads it as licence to protect the
                     mechanism indefinitely and absorb every failure into
                     auxiliary conditions - the exact firefighting this phase
                     exists to stop.
```
