---
name: seed-mission
description: Use this whenever the project owner wants to start a new parallel "mission" thread -- a new sub-project living in its own repo/subdirectory with its own CLAUDE.md and MISSION_NOTES.md, alongside the project's existing missions. Trigger on phrases like "seed a new mission about X," "let's start a new thread for Y," "spin up a repo for Z," or similar, even without the word "mission." Scaffolds the directory and initializes git in the one order that is safe inside a cloud-synced folder (init, then immediately mark .git ignored, before it has ever synced) -- do not skip the ignore step or improvise it differently. Writes a real CLAUDE.md from the context the human gives, not a generic template.
---

# Seed a new mission

A mission is a parallel sub-project thread: its own git repo (usually a
subdirectory of the main project), its own `CLAUDE.md` (standing rules
and facts specific to that mission), and its own `MISSION_NOTES.md` (a
running log, written to as work happens). Missions coordinate through
the project root's shared files (`DECISIONS.md`, `OPEN.md`, the root
`CLAUDE.md`), with the human as the only live channel between running
threads. This skill scaffolds a new one the same shape as the ones the
project already has.

## Before scaffolding anything

Ask the project owner (if the conversation hasn't already covered it)
what the new mission actually is: what question it answers, what
repo/data it starts from, where it should live (top-level or nested
under an existing mission group), and any standing facts or rules that
already apply to it. Do not invent this content. If the project already
has a mission, that mission's `CLAUDE.md` is the model to match -- real
context from an actual conversation, not a filled-in template. A
`CLAUDE.md` that reads like a placeholder is worse than no file at all,
because a future session will trust it.

## First use in a project

`scripts/seed_mission.sh` (bundled alongside this file) has a
configuration block at the top. Before its first run in a project:

- Set `GIT_MACHINE_MARKER` to the project's designated-git-machine
  marker file, and create that file (by hand, once) on the one machine
  that does git for this project. The script refuses to run anywhere
  the marker is absent; that refusal is the point, not an obstacle.
- The sync-ignore step as shipped implements Dropbox on macOS
  (`xattr -w com.dropbox.ignored`). If the project syncs through
  something else, replace that one command with the provider's
  equivalent. The ordering principle around it is the portable part;
  the command is not.

## Scaffolding

Run `scripts/seed_mission.sh <path> "<one-line summary>"`. It handles
the parts that are dangerous to get wrong by hand:

- Refuses to run unless the designated-git-machine marker exists.
  Exactly one machine does git in a cloud-synced project, because git
  metadata inside a synced folder cannot be shared across two machines
  without corrupting one of them.
- Refuses if the target path already exists.
- `git init`s the new repo, then **immediately** marks its `.git`
  ignored by the sync service, before it has ever synced anywhere.
  This is the safe order specifically for a repo that has NEVER
  synced: the machine creating it keeps its copy by ignoring first.
  It is the *opposite* of the order for a repo that is already
  syncing, where the ignore must be applied on the other machine
  first -- most sync services treat "ignore this folder" as "remove it
  from the server and every other device," so applying it here first
  deletes the other machine's copy. Getting this backwards is exactly
  how a live repo gets deleted from another machine. Do not improvise
  this step differently than the script does; if the script's
  verification prints a warning, stop and tell the project owner
  rather than trying to fix it a different way.
- Writes a `.gitignore` that keeps cloud-sync conflict artifacts out
  of git -- both the renamed-file spelling and the renamed-directory
  spelling, because a sync service deconflicts at both levels and
  either one committed is a mess to unwind.
- Writes a `MISSION_NOTES.md` stub.

The script deliberately does NOT write `CLAUDE.md` -- that needs real
synthesized content, which a script can't produce and shouldn't fake.

## After the script runs

1. Write `CLAUDE.md` yourself, in the new repo, from what the human
   told you. Model it on an existing mission's `CLAUDE.md` for shape
   (standing rules the human has stated explicitly, facts not to
   re-litigate, data/infrastructure facts worth knowing), but only
   include sections that actually have real content -- don't pad it
   out with empty headers just to match the shape.
2. Report what you wrote, then run the project's own checks from the
   project root (`./run_checks.sh`, plus a session-brief script if the
   project has one). This is checking, not changing, so just do it. If
   the project discovers its repos from the filesystem, this is also
   what registers the new one; if it keeps a hardcoded repo list
   anywhere, update it now.
3. Don't create a remote or make the first real commit yourself. Both
   are externally visible or hard to reverse (account/org choice for
   the remote; a first commit that should already have real
   `CLAUDE.md` content in it, not a placeholder) -- ask the project
   owner first, same as any other action that isn't just checking
   state or writing a doc.
