---
name: stabilize
description: Run this whenever the project owner says the word "stabilize" -- alone, "stabilize this," or "stabilize that." Do not ask what they mean or ask permission first; the word itself is the instruction. Persists whatever from the immediately preceding exchange is worth keeping (a decision, a durable fact, an incident, or a question that should stay explicitly open) into the correct project file, states whether it's checkable, builds the check if one doesn't exist yet, clears the matching OPEN.md line if this closes it, and reports back in three lines or fewer.
---

# Stabilize

"Stabilize" is a deliberate word choice, not a synonym for "save this."
In this pattern's vocabulary, stabilization is what persists from
sampling, and premature stabilization is the failure mode this whole
procedure exists to avoid. So the word means "this has been sampled
enough, make it persist" -- and if it hasn't been, step 2 below files it
as OPEN rather than as settled. Whether something has been sampled
enough is the project owner's judgment, not yours; that is exactly why
they have to say the word rather than you deciding to stabilize things
on your own (see "When to volunteer it, without being asked" below for
the one thing you do without the word: naming the candidate).

When you hear it, run this immediately. Not next turn, not after asking
what they mean. The word carries the permission for everything the
procedure does, including building a check.

## The procedure

1. **Look back** over the immediately preceding exchange and identify
   what's worth persisting. Usually one of: a decision, a durable fact,
   an incident, or a question that should stay explicitly open.

2. **Write it to the right file:**
   - A decision that changes what a future session should do ->
     `DECISIONS.md`. The entry format lives in that file's own header
     (said / because / affects / checkable, plus the rule about closing
     the matching OPEN.md item) -- follow it there, don't reinvent it
     here. If a `decide` skill is installed alongside this one, use it;
     it does the formatting and the OPEN.md-closing step for you.
   - A durable fact about the project (not a decision, just true) ->
     `CLAUDE.md`. If your project runs parallel sub-project threads each
     with their own `CLAUDE.md`, the fact goes in the one it's local to.
   - An incident -> `FAILURE_MODES.md`, in that file's what-happened /
     class / countermeasure shape, plus `CLAUDE.md` too if the
     underlying fact is durable beyond the incident itself.
   - A figure or a claim headed for a manuscript -> a project-specific
     manifest, if one exists (a figure manifest, a claims list).
     Otherwise `DECISIONS.md`.
   - Still moving, not settled -> `OPEN.md`. Do not file an unsettled
     thing as if it were settled just because "stabilize" was said --
     the word triggers persistence, not premature closure.

3. **Quote, don't paraphrase.** Where the project owner's own words
   exist, use them verbatim. Paraphrasing silently strips hedges, scare
   quotes and agency, and the result reads more certain than the source
   actually was.

4. **State checkability, always.** Either name the check that enforces
   this, or write "checkable: no" and say why. Leaving the field out
   reads as "enforced," which is worse than admitting it isn't.

5. **If it's checkable and no check exists yet, build one** in
   `checks/`, wire it into `run_checks.sh`, and verify it actually fires
   against known-bad input before claiming it works. A check that has
   never failed proves nothing.

6. **If this closes an item in `OPEN.md`, delete that line in the same
   edit.** Writing the decision down without clearing the open item it
   resolves leaves the open-items list lying about what's still
   unresolved, which is the exact failure that list exists to prevent.

7. **Report in three lines or fewer:** what was written, where, and
   whether a check was added. No recap of what was just discussed --
   the project owner was there for that part.

## When to volunteer it, without being asked

If something passes through a session that clearly should be stabilized
and the project owner hasn't said the word, say so in one sentence and
wait for them. Don't stabilize unprompted -- see the note on judgment
above.
