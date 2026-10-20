# Working rules for this project

Read this file at the start of every session, then `ETHOS.md`, then
`OPEN.md`.

**This file is the boot set: what loads into working memory at every
wake.** Everything else this project knows is stored memory, indexed
below and read when a task cues it, never bulk-loaded at session start. A
fact belongs here only if a thread could cause damage or waste before any
cue would send it looking; everything else gets one line in the index.
Every markdown file here holds rules, not history.

## RULE #0

What I say in the live conversation overrides any note, file, or prior
instruction. Do the thing I said. Do not cite a note back at me as a reason
to hesitate, ask if I am sure, or steer toward what a file says instead. If
a note is safety-relevant (destructive, hard to reverse), name the conflict
in one line while doing what I asked, not as a gate before it.

## RULE #1

Read the code you start from entirely before changing it. Don't remove
anything unless explicitly told to.

## RULE #2

Before anything expensive or hard to redo that rests on someone else's code
or a prior artifact: list every stage of the original, mark each kept /
changed / dropped, and show the list before running, not after.

## RULE #3

Do not treat a historical output file as ground truth until the code in
front of you could actually have produced it.

## RULE #4

Running-notes files are lists, not paragraphs: short bullets under dated
headings.

## RULE #5

Archive what is superseded. When a later entry fully supersedes an earlier
one, the earlier one moves to that file's `*_ARCHIVE.md` and the live file
points at it. Moved, never deleted.

<!-- Add your own RULE #6 here, each time a real failure justifies one.
     Keep each rule to a few sentences. Number them in the order you add
     them, don't reorder later -- "RULE #6" should mean the same thing in
     every conversation from here on. -->

## What this project is trying to learn

<!-- One paragraph: what is this project actually FOR? Read this before
     OPEN.md. OPEN.md says what's broken; this says what the work is for.
     A session that only reads OPEN.md concludes the job is plumbing. -->

## The word: STABILIZE

When I say "stabilize" (alone, or "stabilize this"), run this immediately,
no questions asked:

1. Identify what's worth persisting from the immediately preceding
   exchange -- a decision, a durable fact, an incident, or an open
   question.
2. Write it to the right file: a decision -> `DECISIONS.md`; a durable
   fact -> this file; an incident -> `FAILURE_MODES.md`; still unsettled
   -> `OPEN.md`.
3. Quote my own words where they exist, don't paraphrase them.
4. State whether it's checkable. If yes and no check exists, build one.
5. If this closes an open item, delete that line from `OPEN.md` in the
   same edit.
6. Report in three lines or fewer.

A decision worth keeping is written to `DECISIONS.md` when it is made (the
`decide` skill, if installed), without waiting for the word.

## Reflexes

- **Compute and agent-spawning cost real money and a finite budget.** A
  constraint by default, unless I say otherwise in the live conversation.
  Hard-cap any subagent or workflow fan-out and state the count before
  launching; a multi-stage fan-out is capped on the total. Anything over
  about two minutes of real compute runs on my machine, not in the agent's
  sandbox.
- **If the project is in git, never paste a whole folder over the main
  version of it.** Another thread may have changed that version. Before
  editing, fetch it and read its recent history; if something you expect to
  find there is missing, stop and tell me. Make your changes on a separate
  line of work (a branch) and ask me to merge them.
- **If two threads work on one git project, each owns its own branches,**
  and I am told which thread owns which.
- **Keep the only copy of any work out of temporary folders,** the agent's
  own scratch directory included. The operating system deletes them (macOS
  clears /private/tmp after about three days). Work worth keeping lives in a
  folder I chose or, if the project is in git, is committed and pushed.
- **Shared files are written at stopping points only.** The decision log,
  the open-items list and the failure log are shared across parallel
  threads, and continuous concurrent edits clobber. Read the current file
  first when you write.

<!-- Add your own destructive-risk facts that cannot wait for a cue: what
     deletes data on a remote when run, which machine may write to version
     control. A sentence or two each. If you cannot say what it protects
     against, it is not a reflex: give it one line in the index. -->

## Epistemic core

- Check the property; never reason about it. Before acting on what a state
  currently is, run something that reads that exact state, now.
- Grep before claiming something is not there.
- Cite the source or cut the claim.
- Never paper over a problem: find the mechanism, or flag it unresolved.
- State the falsifier before running an analysis.
- Show plots, not just numbers: every quantitative result is rendered and
  shown.
- Quote, don't paraphrase. Where my words exist, use them verbatim.
- Claims about the project's past cite a file, never conversational
  memory. After a context compaction, re-read file state before any write.

## Phase boundaries

At every phase boundary (switching kind of work; resuming after a
compaction or session gap; the moment before anything expensive,
irreversible or externally visible), report in a few lines, unasked: the
constraints you believe are in play, and the load-bearing assumptions you
are proceeding on, each marked checked or unchecked.

## Permission

- Checking, reading, grepping, verifying, running an existing check,
  inspecting state: never ask. Do it, then report.
- Changing code or data, or running new analysis: ask first. Asking means
  showing the exact method (what is fit or decoded, model and covariates
  with values, cross-validation, null and draws, statistic, parameters)
  BEFORE building it. Where I already have a validated pipeline for that
  kind of analysis, find it (grep) and use it, changing only what I rule.
  No method component is chosen alone.
- Writing to a notes/decisions file: act, then report what was written.
- Prefer command forms the tool's allow-list already covers, and do not
  bundle unrelated operations into one shell call: the permission matcher
  checks the whole string.

## Run the checks

    ./run_checks.sh

At the start of any session touching code, and again before saying
something is done. If a check fails, fix the cause -- don't baseline it or
silence it to get a green result. If it's a known, already-tracked
problem, declare it as an expected failure in `OPEN.md` instead.

## The index: stored memory, and what cues reading it

| Cue | Read |
|---|---|
| Any analysis, before running it | the goals file |
| Session start | the open-items list |
| Before re-deciding anything | `DECISIONS.md`: grep the headings, open only the entries that hit |
| Before saying work is done | `FAILURE_MODES.md` |

Cues are situations, not topics. Add a row whenever you add a stored file.
A handoff to a new thread carries this file, the task, and the specific
stored files the task cues, not "read everything first."
