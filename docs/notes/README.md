# Notes

Raw observations, before they become rules. See the `distilling-principles`
skill for the method.

## Files

```
<hostname>.md            this machine's inbox - append only, never edited
2026-07-retrospective.md a one-time recovery of three months of lost notes
retired.md               rules that were promoted and later withdrawn
```

**One file per machine, deliberately.** Two machines appending to one file
conflict on every push, and a dirty shared file blocks the auto-update pull.
Per-machine files make both problems disappear: nothing else ever touches your
file.

## Capturing

Ten seconds, three lines. Do not judge it, do not generalise it, do not decide
where it belongs — that is the promotion step, and doing it now is what makes
capture expensive enough to skip.

```
2026-08-15  what happened
            what it cost
            candidate rule, if one is obvious
            → conflicts with: <rule name>     (only if it does)
```

## Syncing

`install.sh --self-update` commits this machine's notes file, pulls, and pushes.
The cron job installed by `install.sh --cron` runs it every thirty minutes.

If the push fails — no credentials on this machine, for instance — the commit
remains local and the next run retries. Nothing is dropped silently.
