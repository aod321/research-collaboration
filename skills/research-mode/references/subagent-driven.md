# SUBAGENT_DRIVEN

Multiple agents on genuinely independent work.

Execution control, not epistemology. No conceptual anchor.

**The characteristic failure is fan-out that produces motion instead of
results** — several agents rediscovering the same fact, or a swarm dispatched
before anyone knew what question it was answering.

## Use it for

- genuinely independent investigations that do not share mutable state
- matched experiment arms that must run under identical conditions
- monitoring long jobs that can hang or die silently
- bounded analysis of artifacts that already exist

## Do not use it for

- work where step N needs step N-1's answer
- anything sharing a checkpoint directory, cache, or output path without
  isolation
- making progress look faster on work that does not actually parallelize
- exploring a question that has not been formed yet — fan-out multiplies a vague
  question into several vague answers

## Rules

**Bounded ownership.** Each agent gets one question, one output, and one place to
write. Overlapping ownership produces duplicated work and conflicting edits.

**Isolate what mutates.** Agents that write to the repository need separate
worktrees or separate output roots. Two agents editing one tree is a cost paid
before any speed appears.

**The main agent stays on the critical path.** Delegate the branches, keep the
trunk. An orchestrator that has delegated everything cannot tell whether the
answers fit together.

**Do not leak the answer.** When a subagent is used to check something, give it
the minimum task-local context and the raw artifacts — not your hypothesis, not
the suspected bug, not the conclusion you expect. Otherwise it reconstructs your
answer and reports it back as independent confirmation.

## Accounting

```
Tokens from all participating agents aggregate.
```

This is the rule most easily lost. Effort spent by five subagents is effort
spent; fan-out does not reset the evidence budget, and neither does a subagent
finishing. The core's persistence rules apply across the whole fleet.

A subagent that produced no direct result produced no progress, exactly as if the
main agent had done that work itself.

## Verify before believing

A subagent's report of success is a claim, not evidence. Check the artifacts it
says it produced — the diff, the file, the number — before building on it.

## Stop condition

Collapse back to `SINGLE_THREAD` when the independent pieces are done. Keeping a
fleet alive because it exists is the orchestration form of "there is budget left,
keep improving it".
