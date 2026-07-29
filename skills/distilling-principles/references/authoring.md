# Authoring craft

How to word a skill so it survives contact with a busy agent under pressure.

Much of this is adapted from `superpowers:writing-skills`, which is the fuller
treatment and worth reading directly. What follows is the part that transfers to
research work, plus what we have learned here. Where the two disagree, theirs
was tested and ours was not.

## The description is triggers only

**The description must never summarise what the skill does.**

This is not a style preference. When a description summarises the workflow,
agents follow the description *instead of reading the skill*. In one documented
case a description mentioning "code review between tasks" produced exactly one
review, when the skill body specified two.

```yaml
# BAD - a table of contents. The agent now thinks it has the gist.
description: Covers how to capture an observation, when it earns promotion, and
             how to merge notes without averaging them.

# BAD - a workflow summary. The agent will execute this instead of the skill.
description: Sets the research phase, defines what counts as progress, and
             forbids silent fallbacks.

# GOOD - triggering conditions only
description: Use when something just went wrong and there is a lesson in it,
             when reviewing notes to decide what deserves promotion, when a rule
             keeps getting worked around.
```

**Include the symptoms of being about to violate the rule**, not only the task
types. "Before writing any try/except" is a better trigger than "for error
handling", because the first fires at the moment of the mistake.

Write in third person. It is injected into a system prompt.

## Match the form to the failure

**The form that bulletproofs one failure type measurably backfires on another.**
Classify the failure before choosing how to write the rule.

| The failure | Right form | Wrong form |
|---|---|---|
| Knows the rule, skips it under pressure | prohibition + rationalisation table + red flags | soft guidance — "prefer", "consider" |
| Complies, but the output has the wrong shape | **positive recipe**: state what the output IS, its parts, in order | prohibitions — "don't restate", "never narrate" |
| Omits a required element from something already produced | a REQUIRED slot in the template being filled | prose reminders near the template |
| Behaviour should depend on a condition | a conditional on an **observable** predicate | unconditional rule plus exemption clauses |

Prohibitions backfire on shaping problems because under a competing incentive an
agent negotiates with "don't X". A recipe leaves nothing to negotiate: the
output either matches the stated shape or it does not.

In head-to-head wording tests, the prohibition arm produced *more* of the
unwanted content than the recipe arm — and trended worse than giving no guidance
at all.

**This interacts with "keep the sharpest wording".** The sharpest phrasing of a
discipline rule is usually a prohibition, and that is right. The sharpest
phrasing of a shaping rule is a recipe, and reaching for the prohibition because
it sounds more forceful makes it worse.

## No nuance clauses

**"Don't X unless it matters" reopens the negotiation.** Appending a single
nuance clause to a working recipe degraded it from consistent to noisy.

A real exception is written as its own conditional on something observable:

```
BAD    Report deviations when they materially change the work.
       ("materially" is unobservable - the agent decides, and decides no)

GOOD   Report a deviation when it changes the phase, the endpoint, the
       comparator, or the budget.
```

**Exemption clauses do not scope.** "This limit does not apply to code blocks"
still suppresses code blocks. If part of the output must be exempt, restructure
so the rule cannot reach it.

## Close every loophole explicitly

State the rule, then forbid the specific workarounds. The abstract statement
stops nobody; the enumerated list stops everybody, because a specific
prohibition cannot be reinterpreted.

```
BAD    Never write silent fallbacks.

GOOD   Never write silent fallbacks.
       Not try/except: pass. Not bare except. Not a default for a missing
       input. Not GPU-unavailable-so-use-CPU. Not || true. Not # noqa to
       silence it.
```

Add early, once: **violating the letter of this rule is violating the spirit of
this rule.** That single line closes an entire class of "I'm following the
spirit" arguments.

## Build the tables from observed excuses, not imagined ones

A rationalisation table is only as good as its rows, and invented rows are
weak. The real ones come from watching what actually gets said — in transcripts,
in notes, in your own irritation.

**Write the red flag as the thought that precedes the failure**, not the
failure. Nobody thinks "I am about to bloat the scope". They think "let me just
refactor this first".

## Language that lands

Discipline rules need authority and commitment: imperative, absolute, no
hedging. "No exceptions" removes the decision fatigue that rationalisation feeds
on.

- **Authority** — "You MUST", "Never", "No exceptions". For discipline rules and
  safety-critical practices.
- **Commitment** — force an explicit announcement or choice, so later behaviour
  has something to be consistent with.
- **Social proof** — "Every time." "X without Y fails." Establishes the norm.
- **Never optimise for agreeableness.** It produces sycophancy, which is the
  opposite of what a research collaborator is for.

Guidance and reference material take the opposite register — moderate authority,
clarity over force. Applying discipline language to a reference makes it tiring
and no more effective.

## Cross-referencing

Name the skill, and mark how required it is:

```
GOOD   **REQUIRED:** Use superpowers:test-driven-development
GOOD   **BACKGROUND:** superpowers:systematic-debugging explains the four phases
BAD    See skills/testing/test-driven-development     (required? optional?)
BAD    @skills/testing/test-driven-development/SKILL.md
```

**Never use `@` links.** They force-load the file immediately and burn context
before it is needed.

**Do not restate what another skill owns.** Hand off. A duplicated procedure
drifts from its source, and then neither copy can be trusted.

## Naming

Verb-first, or a gerund for a process. Name it by what you do, or by the core
insight — not by the topic area.

```
GOOD   distilling-principles, condition-based-waiting, root-cause-tracing
BAD    principle-management, async-test-helpers, debugging-techniques
```

## Body or reference

Split by **kind**, not by size. Mature skills range from 60 to 700 lines of body
with no sign of a managed target, and the longest bodies also have the longest
references — length is not what is being managed.

```
BODY        the decision procedure: what to decide, when, and the criterion
            always-on rules
            red flags and rationalisation tables
REFERENCE   how to execute one step, once decided
            templates handed to a subagent
            background material
            per-phase or per-mode detail
```

Moving content to a reference to hit a line target does not reduce load — it
makes the same content harder to reach.

## Anti-patterns

**Narrative examples.** "In session 2026-07-13 we found that the empty projectDir
caused…" — too specific to reuse. Grounding a rule in a real incident is good;
using one as the worked example is not.

**Multi-language dilution.** One clear example beats the same example in four
languages.

**Generic labels.** A flowchart node reading "Handle error" or a table row
reading "Various issues" carries no information.

**Documenting what `--help` already says.** Reference the tool; do not transcribe
it.

## What we deliberately do not do

`superpowers:writing-skills` prescribes a RED-GREEN-REFACTOR cycle for skills:
run a pressure scenario against a subagent without the skill, write the minimal
skill that fixes the observed rationalisations, re-run, close loopholes,
repeat. It also prescribes micro-testing individual wordings with several
repetitions and a no-guidance control.

That is a stronger method than ours and it is worth knowing. **We do not use it
here** — validation is `quick_validate.py` plus real use, on the grounds that
building an evaluation harness before knowing whether the skill helps is the
failure this whole framework exists to prevent.

The cost of that choice is real: our wordings are untested, and a rule that
reads forcefully may not bind. Treat every rule here as provisional until it has
survived a situation where following it was inconvenient.
