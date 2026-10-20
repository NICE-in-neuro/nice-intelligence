# Running several parallel AI threads on sub-projects that share infrastructure

## The shape of the problem

A project big enough to need this pattern is often also big enough to
split into several sub-projects running in parallel -- each with its own
AI agent thread, its own working directory, its own running-notes file --
that nonetheless share some infrastructure (a data loader, a set of
conventions, a piece of shared code) and sometimes depend on each other's
findings.

Two files at the shared root do the coordinating: a project-wide
`DECISIONS.md`/`OPEN.md` (see the templates in this repo) that every
thread can read, and a project-wide standing-rules file. But the threads
themselves are separate running sessions with no channel between them
except the human running the whole project.

## The failure: writing a fact down does not deliver it

A shared doc records a fact for whenever a thread next reads it, at its
own natural stopping point -- which, on an unpredictable working pace,
could be a while. If another thread needs to know something NOW, not
eventually (a changed inclusion criterion, a corrected shared function, a
bug in infrastructure everyone imports), writing it to the shared doc and
stopping there is not enough. The other thread has to actually be told.

**The rule: when you detect a fact another running thread needs to know
now, do both** -- write it to the shared doc as usual (for the permanent
record and for threads that stop there later), AND compose a short,
paste-ready message for the human to hand directly to each thread that
needs it now. The human is the actual delivery mechanism between threads;
the shared file is the permanent record, not the channel.

## Seeding a new thread

When starting a new sub-project thread (or handing off an existing one
whose context is running out), the seed prompt should:

- Point at the shared root files first (standing rules, current open
  items, the project's actual goal -- not just "what's broken").
- State explicitly that the seed prompt itself may already be stale by
  the time it's read, and that the thread's own running-notes file
  (updated more recently, likely by a different instance) wins on any
  conflict. A seed prompt is reconstructed from a compacted or ending
  context; treat it as a summary, not a source of truth, and say so in
  the prompt itself.
- Tell the thread to verify its own understanding of "expected state"
  against the actual repo (git log, current file contents), not to
  inherit a bullet list of claims from the seed prompt uncritically.
- Include the project's standing rules about asking permission (see
  `permission-model.md`) explicitly -- a fresh thread without this
  re-establishes the "ask about everything" default from scratch.

## When two threads might edit the same shared file

If a piece of shared infrastructure needs a change that both threads
depend on, pick one thread to make the edit (typically whichever owns the
file, if there's a clear owner) and have it cite the other thread's
verification as the source of any fact it's encoding, rather than
re-deriving it. Two threads independently editing the same shared file in
the same window is a conflict waiting to happen; one thread editing with
the other's already-verified input is not.

## A concrete hazard worth naming explicitly: reused identifiers across versions

If a shared piece of infrastructure gets a second version (a second
model, a second data source, a second config) and the two versions use
the same identifier (a state index, a numeric code) to mean DIFFERENT
things, that's a silent-wrong-result trap with no error and no warning --
whoever reuses the bare identifier from the old version against the new
version's data gets a confidently wrong answer. When this happens: give
the new version's constants distinct, unambiguous names (never reuse a
bare identifier near the old one), and put the collision explicitly in
both the old and new constants' documentation, not just in a chat message
that can be forgotten.
