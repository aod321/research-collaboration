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

## Artifact ownership

**Each agent writes only its own directory. One aggregator, running alone,
writes anything shared.**

```
agent writes:       its own output dir, manifest, JSON, log, hashes
agent never writes: the shared workbook, the shared index, the shared table
aggregator:         single-threaded, rebuilds the shared view from the parts
```

A shared file with several writers corrupts quietly — the failure looks like a
missing row, not like a crash — and it is the single most common way parallel
work destroys its own results.

The same rule covers the repository itself:

> 你不是唯一在仓库中工作的代理；不要回退他人修改，适配当前状态。严禁 git add/
> commit/clean，严禁停止、signal 或干扰任何训练/container/watcher，严禁修改
> results 中已封存产物

Concretely: do not revert another agent's edits, do not `git add`, `commit`, or
`clean`, do not stop or signal another process, and do not modify a sealed
result. Adapt to the working tree as you find it.

A failed row is marked failed, not silently dropped and not retried into a
different contract.

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
