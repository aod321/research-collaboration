# CONFIRMATION

Entered only on a strong positive result on the primary endpoint **and** explicit
authorization. A strong result makes the work *eligible*; it does not by itself
authorize the budget. Uncertainty is never a reason to enter this phase.

A first prototype result strong enough to qualify goes directly here. There is no
requirement to pass through `BATTERING_RAM` first.

**Analogy: load acceptance.** The building is up and looks habitable. Now prove
it bears load. Acceptance items are chosen by *how this building could collapse*
— not copied from a generic form. Copying the form means seismic-testing a
bungalow while missing that it sits on sand.

**Criterion:** if this threat holds, would it overturn the claim, and is it worth
its cost?

## Three questions per candidate check

```
1. Which specific error does it target?
2. If that error were present, would this check have a good chance of finding it?
3. Would its outcome reject, narrow, or rewrite the claim?
```

Any "no" disqualifies it from confirmation budget. A check that sounds rigorous
but could not have caught the error is ceremony wearing a lab coat.

## Threats, ranked and bounded

Enumerate what could overturn the claim — identity failure, leakage, unfair
comparator, alternative explanation, evaluation misalignment, data distribution,
RNG — and verify only those that genuinely could.

```
Threats are ranked and bounded. A remotely imaginable failure is not a live
threat without a plausible route to overturning the current claim.

Start with the highest-impact one. Do not build an exhaustive threat catalogue
before testing anything.
```

Confirmation does **not** automatically require multiple seeds, nor a full
ablation suite — only the one or two ablations that discriminate between
competing explanations. See `rng-policy.md` for when seed variation is a live
threat rather than a reflex.

## The boundary

```
Confirmation protects only the claim actually made. It is not responsible for
proving general robustness, validity under all distributions, stability under all
initializations, or the impossibility of every alternative explanation.

When confirmation overturns part of the claim, the legal move is to narrow,
downgrade, or withdraw it - not to keep expanding the confirmation matrix until
the original claim survives.
```

That second paragraph is the failure mode specific to this phase. An agent that
adds a dimension because the previous one went badly is no longer confirming; it
is searching for a framing in which the claim is true.

## Stop condition

Confirmation ends when the pre-selected high-impact threats are resolved, or when
the claim has been narrowed to what the evidence supports.

**There is no obligation to complete a generic reviewer checklist.**

## Making a comparison mean something

These are the specific ways a confirmation experiment fails to support the claim
it was built for.

**A control differs in exactly one thing.** Same forward pass, same
initialisation, same optimizer, same training budget — only the mechanism under
test changes. Anything else and the difference attributes to nothing.

**Comparing against nothing is not a control.** "Trained" versus "untrained"
shows that training happened. To show the *mechanism* was necessary, the control
must retain everything except that mechanism — a stop-gradient arm, a
readout-only arm, a shuffled-input arm. If the shuffled version also works, the
structure you claimed was doing the work was not.

**Every arm gets the same budget.** Do not tune the learning rate and training
length for the method you are advocating and run the baseline on defaults. The
resulting gap is your tuning effort, not your mechanism.

**Two overlapping curves are not evidence of small error.** A reviewer sees one
line. Give at least one of: a residual inset, an RMSE, a maximum absolute error,
an exact-match fraction.

**Report the distribution, not the best run.** Where multiple runs exist, give
the count, the median, an interquartile or bootstrap interval, and each run's
final value. Selecting the best curve is selective reporting whether or not it
was intended as such.

**A criterion is defined in writing before it is applied.** "Adapts quickly" read
off a curve is an impression. State the threshold and the measurement, then
apply it.

**Show cases that were chosen before the results.** Fix the episode or example
IDs in advance, and pair them across arms. Picking the illustrative case after
seeing the outcomes is the same defect as picking the best seed.

**Do not write causation you have not isolated.** Without the ablation that
removes the candidate cause, the honest phrasing is *consistent with*, not
*caused by*. And a placeholder in a draft stays visibly a placeholder until the
number exists — never write the expected conclusion in advance and plan to
confirm it later.

## Calibration examples

Examples, not a checklist. The criterion governs.

**Earns confirmation budget**

- a matched control that removes the one alternative explanation a reader would
  raise first
- an identity audit binding the reported result to the exact artifacts that
  produced it
- a leakage check on the specific path by which evaluation information could have
  reached training
- seed variation **when** the effect size and the observed run-to-run spread are
  comparable
- an ablation that discriminates between two live competing explanations

**Does not**

- multiple seeds by default
- the full ablation grid
- every dataset, every checkpoint, every numerical-equivalence test
- robustness sweeps against threats with no route to overturning the claim
- defending against an imagined reviewer rather than a real error mode
- a new dimension added because the last one was unfavorable

## Conceptual anchor

```
Anchor:              Mayo's severe testing. A test supports a claim only if it
                     had genuine capacity to expose the relevant error had that
                     error been present. Rigor is not quantity of testing.
Design consequence:  claim-contingent rigor. The three questions above are the
                     operational form, and they explain directly why multi-seed
                     is not a default: a run that cannot change the claim adds
                     statistical material without adding relevant severity.
Do not import:       Mayo's full statistical philosophy, or any particular
                     statistical method, as a general requirement. Do not misread
                     "severe" as "numerous, expensive, procedurally complete".
                     Borrow the counterfactual question; leave the package.
```
