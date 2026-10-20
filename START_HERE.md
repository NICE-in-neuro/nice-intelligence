# Start here

You were handed this because you run, or are about to run, a long
project with an AI coding agent: weeks or months, many sessions, and
results that have to be right. This page assumes you know nothing about
where the pattern came from. You do not need to.

## The problem in three sentences

An AI agent has no memory across sessions except what is written down.
Most of what looks like "it forgot" is a storage failure: the decision
only ever existed in a chat transcript, so the next session cannot know
it, and a long session loses track of it too. The agent cannot detect
its own forgetting, so the fix cannot be "remember better." It has to be
a small set of files the agent reads and writes as it works.

## What you need

- An agent tool that can read and write files and run shell commands,
  across a whole working session (Claude Code, or anything equivalent).
  A single-turn chat with no file access cannot run this pattern.
- A project directory the agent works inside.
- You, actually looking at what the agent puts in front of you. Nothing
  here replaces that; every file here exists to make it cheaper.

## The first hour

1. Copy the starter kit into your project root. Run this from the top
   folder of this repo. The copy overwrites any file of the same name, so
   if your project already has a `CLAUDE.md` (or any file named below),
   copy into an empty folder and merge by hand instead:

       cp -R starter-kit/* <your-project>/

   You now have `CLAUDE.md` (standing rules), `ETHOS.md` (what the agent
   is here), `DECISIONS.md` (append-only log), `OPEN.md` (what is not
   settled), `FAILURE_MODES.md` (incidents), `run_checks.sh`, and an
   empty `checks/`.

2. Open `CLAUDE.md` and write the one paragraph under "What this project
   is trying to learn." Say what the work is *for*, not what is broken.
   A session that reads only the open-items list concludes the job is
   plumbing and optimizes plumbing.

3. Open `ETHOS.md`. Put your name in. Decide whether to write the
   bracketed statement in your own words or delete it. Do not leave a
   placeholder; the agent will trust it.

4. Start a session. Tell the agent to read `CLAUDE.md`, `ETHOS.md`, and
   `OPEN.md` before anything else, and to run `./run_checks.sh`. From
   then on, every session starts that way.

5. Optional, if your tool supports skills: copy `skills/` into your
   project's `.claude/skills/` (or the equivalent), so the procedures
   below trigger on their own instead of relying on the agent
   remembering prose. `skills/README.md` explains each one.

## The first week

- **When a decision is made, say "stabilize."** The agent writes it to
  the right file, quotes your words rather than paraphrasing them, and
  says whether a check can enforce it. One word is the smallest
  interface that survives contact with a moving session
  (`docs/stabilize.md`).
- **When something goes wrong, it becomes an entry in
  `FAILURE_MODES.md`:** what happened, what class of failure it is, what
  changed. Then, if a script could catch the recurrence, a check goes in
  `checks/`. Every check exists because something already broke once;
  nobody writes checks for imagined failures (`docs/checks-philosophy.md`).
- **When an item in `OPEN.md` gets resolved, its line gets deleted**, in
  the same edit that records the decision. A stale "open" item costs the
  reader's trust in every other line.
- **When the agent asks permission for something that is only reading
  or checking, point it at the permission model** in `CLAUDE.md`: check
  freely, ask before changing code or data, write notes and then report
  (`docs/permission-model.md`).
- **When a result looks wrong, do not let it get clipped, masked, or
  thresholded into looking right.** Find the mechanism or flag it
  unresolved (`docs/never-paper-over.md`).

## Reading order, after that

The `templates/` directory holds annotated versions of the starter-kit
files, with the reasoning behind each rule and worked examples. Read
them when a rule seems arbitrary; each one earned its place by being
violated first. `README.md` maps every file. `docs/what-this-assumes.md`
says what the pattern cannot do for you, and is worth reading before
you trust anything else here.

## What to expect

Overhead. Reading an open-items list every session, writing a decision
before moving on, maintaining a check suite: that is real work, and
whether it pays for itself on your project is your call. What it buys is
narrow and specific: the mistakes this pattern has already made once do
not get made again silently. New mistakes still arrive. You are still
the only thing that catches them.

## Sending things back

If a rule was unclear, a step failed, or a file did not fit your
project, that friction is the most useful thing you can report. The
pattern was built inside one project and has been used outside it by
very few people; what breaks on contact with yours is exactly what it
needs to know.
