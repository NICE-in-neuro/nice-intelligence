---
name: session-brief
description: Use this at the start of any session that will touch the project's code or context docs, or whenever asked to "brief me," "catch me up," "what's the state of things," or similar. Runs the project's own state scripts (./run_checks.sh, plus a brief script if the project has one) and presents a compact summary of what they report -- OPEN.md's items with the blocking tier first, the most recent DECISIONS.md entries, git status, and which checks are failing, distinguishing failures OPEN.md already declares as expected from any genuinely new one.
---

# Session brief

The scripts are the source of truth. Run them; do not reconstruct what
they print from memory or from this file. Either script can change
without this skill being updated to match, and a stale reconstruction
is worse than none -- it reads as current state while reporting an old
one.

## What to do

1. If the project has a brief script (commonly `./session_brief.sh` --
   check the project root and `CLAUDE.md` for one), run it from the
   project root.
2. If there is no brief script, assemble the same information by hand
   from the files it would have printed:
   - `OPEN.md`, read verbatim, top to bottom.
   - The last few entries in `DECISIONS.md`.
   - `git status` (per repo, if the project spans more than one).
   This is the fallback, not a lesser path: the point is the
   information, and these files are where it lives.
3. Run `./run_checks.sh` from the project root. It changes nothing and
   is safe to run any time.
4. Read all of it in full before saying anything -- especially
   `OPEN.md`'s tiered list and the check output's distinction between
   expected and unexpected failures. `OPEN.md`'s own header defines
   the tiers and the `EXPECTED-FAILURE:` line format; take their
   meaning from there, not from here.
5. Present a compact summary, not a wall of pasted output:
   - Which checks failed, and whether each one is declared in
     `OPEN.md`'s expected-failures list or is new. A new, undeclared
     failure is the one thing that must not get buried -- lead with it
     if one exists.
   - The blocking-tier items from `OPEN.md`, since those mean results
     are wrong right now.
   - Anything in the recent `DECISIONS.md` entries that changes what
     today's session should do differently than the last one did.
   - Git state in one line if it is clean; more only if something
     looks off (uncommitted work sitting for a while, no upstream,
     unpushed commits).
6. If something looks contradictory or stale, say so explicitly rather
   than smoothing it over: an `OPEN.md` item that reads as unresolved
   while the checks say it passes, an `EXPECTED-FAILURE:` line whose
   check now succeeds, a script reporting state that does not match
   the files. A document that has drifted from the state it describes
   costs the reader trust in every other line it contains; surfacing
   the mismatch is the brief doing its job, not a digression from it.

Do not ask permission to run any of this. Checking, reading, and
verifying state never needs permission; only changing code or data
files does.
