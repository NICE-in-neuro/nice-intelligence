# The permission model

## The complaint this answers

"You are asking for permission too many times. If I ask you to do
something, why do you ask permission to do it?" A natural response to
that complaint is to just ask less, across the board -- but that trades
one failure mode (too much friction) for a worse one (an agent that
changes code or data without a pause the human actually wanted). The fix
isn't "ask less," it's "ask about the right category."

## The three categories

**Checking, reading, grepping, running an existing check, verifying
something you just built, inspecting current state:** never ask. Just do
it, then report what you found. This includes running visualization or
plotting code, and recombining or re-presenting already-computed results
(e.g. concatenating existing per-run outputs into one summary) -- these
feel like "running code" but they're re-presenting existing information,
not producing new results, so they belong in this category too. The
dividing line is: does this produce a NEW result/computation, or does it
read, verify, or re-present something that already exists?

**Changing code or data files, or running new analysis/computation:** ask
first. This is the one category that still warrants a pause -- it's the
only one where an agent acting on its own initiative can produce a result
the human didn't actually want, and where undoing it costs more than the
asking would have.

*What asking means.* Asking is showing the exact method before building
it: what is fit or decoded, the model and covariates with their values,
the cross-validation, the null and its draws, the statistic, the
parameters. If the owner already has a validated pipeline for that kind of
analysis, the agent finds it (grep) and uses it, changing only what the
owner rules. No component of the method is chosen alone.

**Writing or editing a notes/decisions/docs file:** act, then report what
was written. The project owner reviews the output afterward and says if
something needs removing or amending -- the review happens on the
*result*, not as a gate before the action. This is deliberately different
from the code/data category: a wrong sentence in a notes file costs a
correction; a wrong line of executed code or a wrong analysis run can
cost real time, real compute, or a real mistaken conclusion.

## Why this needs to be a category, not a feeling

An agent asked to categorize a given action "does this feel like it needs
permission" will drift toward the same conservative default regardless of
which category the action is actually in, because asking always feels
safer in the moment. Naming the three categories explicitly, in a file
the agent reads at the start of every session, converts a fuzzy judgment
call into a lookup.

## The other half of the problem: what actually triggers a prompt

Getting the *stated* rule right doesn't fix everything -- there's a
separate, purely mechanical problem: some command forms trigger an actual
permission dialog in the tooling and some don't, for reasons that have
nothing to do with which of the three categories above the action belongs
to. Two concrete instances worth watching for in any agentic coding
tool:

- **Prefer whatever command form the tooling already auto-allows** over
  an equivalent that isn't recognized (e.g. one flag/subcommand spelling
  over a functionally-identical one that isn't on the allow-list).
- **Don't bundle multiple operations into one shell call for efficiency**
  if the tooling's permission matcher checks the whole command string --
  chaining three read-only commands together with `&&` can fail to match
  an allow-list that would have matched each piece individually. Smaller,
  single-purpose calls let an allow-list actually do its job.

This is a genuinely separate problem from the stated-rule problem above,
and fixing one does not fix the other -- both need attention.
