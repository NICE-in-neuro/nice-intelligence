# The trigger word: STABILIZE

An installable reference implementation of this procedure ships in
`../skills/stabilize/` -- for agent tools that support skills, install
that, so the procedure triggers mechanically instead of relying on this
prose being remembered. This doc stays the what-and-why; the skill is
the how. If the two ever disagree, that is a bug -- fix whichever one is
wrong, in the same edit that finds it.

## The problem this solves

Every piece of the pattern in this repo shares one failure mode: it only
works if someone remembers to use it. A decisions log needs writing to. An
open-items list needs updating. A check needs running. Each of those is a
separate thing to remember, at a separate moment, and "remember to write
this down" is exactly the kind of task that gets skipped when a session is
moving fast.

A single word is the smallest possible interface to the whole system --
which is the only reason to expect it to survive contact with an actual
working session.

## The procedure

When the project owner says the trigger word (alone, or "stabilize this"
/ "stabilize that"), run this immediately. Do not ask what they mean. Do
not ask permission. Do it, then report in three lines or fewer.

1. **Look back** over the immediately preceding exchange and identify
   what's worth persisting. Usually one of: a decision, a durable fact, an
   incident, or a question that should stay explicitly open.

2. **Write it to the right file.**
   - A decision that changes what a future session should do ->
     `DECISIONS.md`
   - A durable fact about the project (not a decision, just true) ->
     `CLAUDE.md`
   - An incident -> `FAILURE_MODES.md` for the class and countermeasure,
     plus `CLAUDE.md` too if the underlying fact is durable beyond the
     incident itself
   - A figure or a claim headed for a manuscript -> a project-specific
     manifest, if one exists (a figure manifest, a claims list);
     otherwise `DECISIONS.md`
   - Still moving, not yet settled -> `OPEN.md` -- do not file an
     unsettled thing as settled just because "stabilize" was said

3. **Quote, don't paraphrase.** Where the project owner's own words exist,
   use them verbatim. Paraphrasing silently strips hedges, scare quotes,
   and agency, and the result reads more certain than the source actually
   was.

4. **State checkability, always.** Either name the check that enforces
   the thing just written, or write "checkable: no" and why. Silence in
   that field reads as "this is enforced," which is worse than an honest
   "it isn't."

5. **If checkable and no check exists yet, build it**, wire it into the
   check suite, and verify it actually fires against a known-bad input
   before claiming it works. A check that has never failed is not
   evidence that it works.

6. **If this closes an open item, delete that line from `OPEN.md` in the
   same edit.** Writing the decision without clearing the corresponding
   open item leaves the open-items list lying about what's still
   unsettled, which is the exact failure that list exists to prevent.

7. **Report** what was written where, and whether a check was added.
   Three lines maximum. No recap of what was just discussed -- the
   project owner was there for that part.

## When to volunteer it, without being asked

If something passes through a session that clearly should be stabilized
and the trigger word hasn't been said, say so in one sentence and wait.
Do not stabilize unprompted -- whether something has actually been
sampled/settled enough to write down permanently is the project owner's
judgment call, not the agent's.
