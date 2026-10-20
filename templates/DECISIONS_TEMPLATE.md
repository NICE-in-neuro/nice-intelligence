# Decisions

Append-only log of decisions that change what future sessions should do.

## Why this file exists

Most of what looks like "the model forgot" is not memory failure. It is
storage failure: the decision only ever existed in a conversation
transcript, so a new session cannot know it, and a long session
probabilistically loses track of it too. A model cannot detect its own
forgetting -- there is no internal signal at generation time that
something relevant is missing -- so the fix cannot be "try to remember
better" or "read the whole conversation again." It has to be an external
file.

## The rule

**Write the entry when the decision is made, not at the end of the
thread.** Thread-end distillation is written by an instance whose context
has already degraded (compacted, truncated, or just diluted by everything
that happened since), and that distillation inherits the degradation. An
entry costs about four lines and thirty seconds. Add it before the
conversation moves on to the next thing.

## Format

One entry per decision. Newest at the top. Keep them short.

    ### YYYY-MM-DD  one-line statement of the decision
    said: the actual words, quoted, if they were distinctive. Paraphrasing
      strips hedges and scare quotes and reads more certain than the
      speaker actually was -- quote, don't paraphrase, wherever the exact
      words exist.
    because: the reason, if it is not obvious. Skip if it is.
    affects: which files, modules, or future choices this constrains
    checkable: name of the check enforcing it, or "no" with why not

`checkable` is the field that matters most. If a decision can be enforced
by an automated check, write the check and name it here. If it cannot,
say so explicitly -- "no, needs human judgment" is a completely fine
answer. Silence in that field is not fine: silence reads as "this is
enforced," which is worse than an honest "it isn't."

## Why append-only, not "keep it updated"

An editable, always-current decisions doc sounds tidier, but it throws
away exactly the information that makes a project's history legible: WHEN
something was decided, in what order, and what it superseded. Append-only
plus a separate archival step (see RULE #5 in `CLAUDE_TEMPLATE.md`) keeps
both: the live file stays short because superseded entries move out, but
nothing is silently rewritten in place.

## At a phase boundary in a long session

Restate the constraints actually in play before continuing. Drift caught
early is free to correct. Drift caught late arrives as an unpleasant
surprise -- that's the specific failure this file, read at the start of
every session, exists to prevent.
