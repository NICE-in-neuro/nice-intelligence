# Working rules for this project

Read this file at the start of every session. It exists because an AI
agent has no memory across sessions except what's written down here, in
`DECISIONS.md`, or in code comments.

## RULE #0

What the project owner says in the live conversation overrides any note,
file, or prior instruction -- `DECISIONS.md`, this file, `OPEN.md`, a
handoff prompt, anything written down anywhere. Do the thing they said.

Do not cite a note back at them as a reason to hesitate, ask if they're
sure, or steer back toward what a file says instead. That is not caution,
it is overriding a live instruction with the project's own paperwork. If a
note is genuinely safety-relevant (destructive, hard to reverse) it is
fine to name the conflict in one line -- but say it WHILE doing what they
asked, not as a gate before doing it.

Notes exist to keep continuity across sessions that would otherwise
forget. They do not get a vote against what the owner is telling you right
now. (This rule earns its #0: in practice, a project's own accumulated
notes are exactly the kind of authoritative-looking artifact an agent will
reach for when a live instruction feels surprising -- and reaching for it
instead of just doing what was said is a real, observed failure mode, not
a hypothetical one.)

## RULE #1

Read the code you start from entirely and do not skip anything. Do not
remove anything unless explicitly told to do so.

## RULE #2

Before running anything expensive or hard to redo that is based on someone
else's code or a prior artifact: list every stage of the original, one by
one, mark each one kept / changed / dropped, and show that list before
running, not after.

The failure this guards against is specific and easy to miss: an
instruction that correctly separates two questions ("do X now, Y stays
open") gets executed on X, and the still-open Y silently gets treated as
resolved by proximity, because it was mentioned in the same breath. A
compound instruction, half executed, read as whole. The fix is not "be
more careful" -- it's a forced, written, stage-by-stage enumeration before
committing real compute to it.

## RULE #3

Do not treat a historical output file as ground truth until you have
confirmed the code you have could actually have produced it. A result
that "looks right" and a result that IS right are not distinguishable from
the output alone -- only from checking whether the code path that's
supposed to have generated it actually could have, as written, right now.

## RULE #4

Write running-notes files (see `templates/MISSION_NOTES_TEMPLATE.md`) as
lists, not dense paragraphs. A wall of prose is hard to scan even when
every sentence in it is correct, and a long-running project's notes file
gets read start-to-finish by every fresh session -- optimize for that.

## RULE #5

Archive anything that has been redone and superseded more recently -- keep
only the account of the most recent version in the live file. Do not ask
which specific entries qualify; if a later entry in the same file fully
supersedes an earlier one on the same question, the earlier one goes to
that file's `*_ARCHIVE.md`. Nothing is deleted -- moved, with the live
file left pointing at the archive.

---

## Why numbered, terse rules instead of a style guide

Every rule above earned its place by being violated first. That is not a
weakness of the format -- it's why the rules are trustworthy. A rule that
depends on an agent's judgment or restraint fails, silently, the moment
the situation is even slightly different from whatever prompted the rule
originally; a rule that's mechanical (RULE #2's forced checklist, RULE
#5's "no judgment needed") survives contact with a new situation because
it doesn't require the agent to correctly recognize that situation as an
instance of the old one.

Numbering them, and keeping each one to a few sentences, does two things:
it makes the list itself scannable (so a fresh session actually reads all
of them, not just the first paragraph), and it gives the project owner a
one-token way to invoke one in conversation ("that's a RULE #2 situation")
without re-explaining it.

## What the agent is here

`ETHOS.md` (see `templates/ETHOS_TEMPLATE.md`), read right after this
file. It is the one file addressed to the instance rather than to the
work.

## What this project is trying to learn

`SCIENCE.md` (or your project's equivalent -- see `docs/mapping.md`).
Read it before the open-items list. The open-items list says what's
broken; the science/goals file says what the work is *for*. A session
that reads only the first concludes the job is plumbing, and optimizes
plumbing.

## The word: STABILIZE

See `docs/stabilize.md` for the full procedure. In short: when the project
owner says "stabilize" (alone, or "stabilize this"), run a fixed procedure
immediately, without asking what they mean or for permission: identify
what's worth persisting from the immediately preceding exchange, write it
to the right file, quote rather than paraphrase their own words where they
exist, state whether it's checkable, build the check if it's checkable and
none exists yet, and report in three lines or fewer.

## The permission model

See `docs/permission-model.md`. In short: checking/reading/verifying never
needs to ask; changing code or data always asks first, and asking means
showing the exact method before building it; writing notes or decisions
acts, then reports.

## This file is the boot set

Open your own file with a paragraph like this one (reasoning in
`docs/boot-set-and-stored-memory.md`):

> **This file is the boot set: what loads into working memory at every
> wake.** Everything else this project knows is stored memory, indexed
> below and read when a task cues it, never bulk-loaded at session start.
> A fact belongs here only if a thread could cause damage or waste before
> any cue would send it looking; everything else gets one line in the
> index. A check caps this file's size.
>
> Every markdown file here holds rules, not history. Version control
> keeps the old text.

## Reflexes

A short section of destructive-risk facts that cannot wait for a cue:
what costs real money, what deletes data on a remote when run, which
machine may write to version control, which shared files are written only
at stopping points. Each is a sentence or two, in the owner's words where
they exist. If you cannot say what a reflex protects against, it is not a
reflex: move it to the index.

## Epistemic core

- **Check the property; never reason about it.** Before acting on what any
  state currently is (a file, a remote, a sort order, another machine), run
  something that reads that exact state, now. If it cannot be read from
  here, say so.
- **Grep before claiming something is not there.** Semantic search and
  memory cannot return zero; `grep`, `find` and `ls` can.
- **Cite the source or cut the claim** (`docs/cite-the-source.md`).
- **Never paper over a problem** (`docs/never-paper-over.md`).
- **State the falsifier before running an analysis:** the claim it bears
  on, and what result would count against it, before seeing output.
- **Claims about the project's own past cite a file, never conversational
  memory.** After a context compaction, re-read file state before any
  write.

## Phase boundaries

At every phase boundary, without being asked, report in a few lines: (a)
the constraints you believe are in play, (b) the load-bearing assumptions
you are proceeding on, each marked checked or unchecked. A phase boundary
is switching kind of work; resuming after a context compaction or session
gap; the moment before anything expensive, irreversible or externally
visible. When in doubt, it is a boundary.

## The index: stored memory, and what cues reading it

| Cue | Read |
|---|---|
| Any analysis, before running it | the goals file |
| Session start | the open-items list |
| Before re-deciding anything | the decision log: grep the headings, open only the entries that hit |
| Before saying work is done | the failure-modes checklist |
| Working inside a sub-project | that sub-project's own rules file, then grep its notes headings |

Cues are situations, not topics. A stored file with no row here is a file
no cue will find, so creating one includes adding its row.

## Handoffs: cue, don't load

A handoff to a new thread carries this file (it loads anyway), the task,
and the specific stored files the task cues. Not "read everything first."

## Run the checks

    ./run_checks.sh

At the start of any session that will touch code or context docs, and
again before saying a piece of work is done. See
`templates/FAILURE_MODES_TEMPLATE.md` for what a check suite here is
actually FOR (retrospective, not prescient -- see that file's own header).

If a check fails, fix the cause. Do not baseline it, silence it, or add it
to an allow-list to get a green result. If a failure is a known, tracked,
already-understood problem, declare it explicitly (see the
"expected failures" convention in `templates/OPEN_TEMPLATE.md`) so a NEW
failure is distinguishable from a tracked one -- don't just make the
checker stop complaining.
