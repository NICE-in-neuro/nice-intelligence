# Open

Things that are not settled. Print this file verbatim at the start of
every session (a one-line shell script that cats it is enough) -- it is
the first thing a fresh session should see, before it does anything else.

**Resolving an item means deleting its line from here.** Do that in the
same edit that writes the decision into `DECISIONS.md`. An item that stays
here after it's done is worse than no list at all: it spends the reader's
trust on every other line in the file. If they catch one stale "open"
item, they stop trusting the list, and then it stops doing its job even
for the genuinely-open items.

**Tiers are load-bearing. Work the top tier first.** A flat list makes it
impossible to tell "this blocks everything downstream" from "this is a
nice-to-have someday." A fresh session cannot infer priority from a date
or from how something reads -- it has to be written down structurally.

    ## TIER 0 -- BLOCKING: results are wrong right now
    ## TIER 1 -- MAIN LINE: the actual work
    ## TIER 2 -- HOUSEKEEPING: not the science, don't let it eat a session
    ## SIDE QUESTS -- parked. Don't pick these up unless told to.

Do not promote an item out of SIDE QUESTS without the project owner saying
so -- a side quest that an agent decides on its own is actually important
is exactly how a session's time gets spent on the wrong thing.

## Expected check failures

If your check suite distinguishes "a known, already-understood, tracked
problem" from "something new broke," that distinction has to live in
exactly one place, or two sessions reading different copies will disagree
about what's expected and each conclude the other is wrong.

    EXPECTED-FAILURE: <check name>  -- <one-line reason>, <which tier>

Nothing is suppressed by this -- the check still prints in full and the
exit code is still non-zero. This just lets the runner distinguish a
tracked failure from a new one, and tells the reader WHY it's tracked
rather than leaving them to wonder if it's safe to ignore.

## Each open item

    - YYYY-MM-DD  **SHORT ALL-CAPS OR BOLD HEADLINE**
      One or two sentences of context: what's broken, what's known, what
      isn't yet. If two independent investigations found the same thing,
      say so -- that's real confirmation, worth recording as such.
      What's still open, as a short list if there's more than one thing.

Date items when they were opened, not when they were last touched --
that's what lets a reader see how long something's been sitting.
