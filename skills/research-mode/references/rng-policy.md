# RNG and seed policy

Seed robustness is not a default research requirement. Two things that are
routinely conflated stay separate here:

- **not cherry-picking seeds is an integrity floor;**
- **proving seed-insensitivity is a specific research question.**

## Default

```
Use one recorded seed.

Where scientifically valid, compare baseline and mechanism variants under the
same random conditions.

Do not launch multi-seed runs merely to demonstrate generic robustness,
reproducibility, or publication polish.
```

A fixed seed is usually *more* informative during prototyping: it removes
irrelevant variation, so a change in outcome is more attributable to the change
in mechanism.

## When multi-seed work is justified

Only when RNG sensitivity is an explicit decision variable, because:

- randomness is part of the claimed mechanism (sampling, random search,
  stochastic routing, random initialization as the object of study);
- outcomes materially change across incidental reruns — sign flips, conclusion
  reversals, large spread;
- the scientific claim itself concerns a distribution over random runs; or
- a bounded final-reporting requirement has been explicitly selected, and the
  main mechanism conclusion is already complete.

When justified, multi-seed work is **its own Next Strike**: state the question it
answers, the decision it can change, its budget, and its stopping rule. This is
what stops seed work from attaching itself silently to every experiment as a
standing tax.

Otherwise seed sensitivity is `not investigated` — never
`assumed mandatory until disproved`.

## `RNG role`

```
IRRELEVANT
CONTROLLED_NUISANCE     # default: fixed seed, no sweep
CORE_RESEARCH_VARIABLE
```

Only `CORE_RESEARCH_VARIABLE` authorizes spending budget on seed variation, and
it means decision-relevant **for this NS** — not that RNG must be a central topic
of the whole programme. Repeating a run three times to check whether a conclusion
is only noise is legitimate under it. Prepaying a seed-calibration tax for all
future work is not.

## Integrity, stated precisely

```
Never inspect many seeds and selectively retain favorable runs.

Changing a seed is allowed; seed mining and selective reporting are not.
```

## Recording

Runs record the seed, data subset, and checkpoint actually used. Selection and
aggregation rules are pre-declared **only when the study actively compares
multiple seeds, subsets, or checkpoints**. Not doing multi-seed work requires no
justification and no explanation.

## Accounting consequence

```
Repeated runs with different seeds count as new research evidence only when RNG
sensitivity is the declared question.

Otherwise they are confirmation or appendix work, not new mechanism information.
```

This does not deny that repeated runs carry statistical information. It says such
runs usually carry no new *mechanism* information, so they may not crowd out the
idea-to-result budget.

## Negative results

The default response to a negative prototype result:

```
check the mechanism was actually executed
check alignment, reset, and leakage
accept the result and decide to revise or abandon
```

Not: run five more seeds to rigorously prove it failed. That spends real budget
confirming a conclusion whose precision changes nothing.

## Variation is not a reusable constant

Run-to-run variation differs across mechanisms, training stages, data subsets,
and initialization regions. One configuration's spread is not a pipeline
constant.

```
Reuse existing variation evidence only when it comes from a scientifically
comparable regime.

Otherwise measure it only when the current NS declares RNG sensitivity capable
of changing the decision, and budgets that question explicitly.
```

## In CONFIRMATION

Confirmation does not automatically require multiple seeds. Choose confirmation
dimensions from the threats to the actual claim. Include seed sensitivity only
where stochastic variation could materially overturn that claim, or where the
final reporting target explicitly requires it — in which case it is usually one
error bar, one small appendix table, or one sentence, not a tax paid on every
candidate and every negative result.
