2026-07-30  first real note, written from a different repo to test the path
            resolution actually works end to end
            cost: nothing, this is the test

2026-07-30  claimed --self-update syncs notes without actually exercising the
            commit path, because a previous `git add -A` had already staged them
            cost: nearly shipped an unverified claim
            candidate rule: a path is verified when it ran, not when it exists
