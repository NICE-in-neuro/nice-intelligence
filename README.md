# NICE intelligence

A pattern for running long AI-assisted science projects: a small set of
markdown files an AI agent reads and writes continuously, so decisions,
incidents, and open questions survive across sessions instead of being
re-litigated, contradicted, or quietly forgotten.

New here? Read [`START_HERE.md`](START_HERE.md) first; it assumes no
context at all. This file is the map of what's in the repo and why.

## The name

NICE in Neuro (niceinneuro.org): sample more, sample better. This repo applies that to Claude Code. 

Two touchstones, cited rather than reinvented:

- **[Karpathy's "LLM Wiki" pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)**
  -- raw sources -> a maintained wiki -> a schema governing how the LLM
  operates. The core claim: an AI-maintained knowledge base should be a
  *persistent, compounding artifact*, not something re-derived from
  scratch on every query. The wiki accumulates; the LLM does the tedious
  cross-referencing and consistency work; the human curates sources and
  asks questions.
- **[Bridgeford et al. 2026, "Twelve quick tips for AI-assisted coding in
  science," PLOS Computational Biology 22(7):e1014428](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1014428)**
  -- practical tips for using AI coding assistants specifically in a
  *scientific* context, where a wrong-but-confident result is a much more
  expensive failure than a bug in ordinary software engineering.

This repo is what happens when you actually run that pattern for real, on
a real multi-week, multi-thread research project, and write down the
specific shape the files and rules need to take to survive contact with
actual work -- not just "keep good notes."

None of this is free. Reading an open-items list every session, writing a
decision down before moving on, maintaining a check suite -- that's real
overhead, and whether it's worth it for what you're working on is your
call to make, not something this README is going to make for you.

## The core idea, in one paragraph

An AI agent working on a long project has no memory across sessions except
what is written down. Most of what looks like "the model forgot" is not a
memory failure -- it is a *storage* failure: a decision only ever existed
in a conversation transcript, so a new session cannot know it, and a long
session probabilistically loses track of it too. A model cannot detect its
own forgetting; there is no internal signal that something is missing. So
the fix cannot be "try to remember better." It has to be an external file,
written at the moment a decision is made, not reconstructed later by an
instance that has already degraded.

## What's actually in here

- **[`START_HERE.md`](START_HERE.md)** -- the zero-context entry point:
  what to copy, what to edit, what to say, in the first hour and the
  first week. Written for someone who has never seen this pattern or
  the project it came from.
- **[`templates/ETHOS_TEMPLATE.md`](templates/ETHOS_TEMPLATE.md)** -- the
  one file addressed to the agent instance itself rather than to the
  work: what it is in the project, how to think there, and what it never
  does. The parts that model a specific person are bracketed fill-ins that
  only enter in that person's own words.
- **[`templates/CLAUDE_TEMPLATE.md`](templates/CLAUDE_TEMPLATE.md)** -- the
  standing-rules file every session reads first. Includes a worked example
  of a RULE sequence: short, numbered, foundational rules that compound
  over a project's life (rule zero: the human's live word overrides any
  written note; read fully before changing anything; show your work before
  an expensive/hard-to-redo action; don't trust a historical artifact as
  ground truth until you've confirmed the code in front of you could have
  produced it).
- **[`templates/DECISIONS_TEMPLATE.md`](templates/DECISIONS_TEMPLATE.md)**
  -- an append-only decision log: what it's for, why append-only beats
  "update in place," and a compact four-field entry format (said / because
  / affects / checkable) designed to be written in under a minute.
- **[`templates/OPEN_TEMPLATE.md`](templates/OPEN_TEMPLATE.md)** -- a
  tiered "what is not yet settled" list, read verbatim at the start of
  every session, with the rule that resolving an item means *deleting* its
  line (into the decision log), not marking it done and leaving it there.
- **[`templates/FAILURE_MODES_TEMPLATE.md`](templates/FAILURE_MODES_TEMPLATE.md)**
  -- an incident log in "what happened / the class of failure / the
  countermeasure" format, ending in a short pre-flight checklist for
  "before you say a piece of work is done." Every check in a project's
  test suite exists because a rule failed once in this log; the log
  records *why*, so the check doesn't read as arbitrary.
- **[`docs/stabilize.md`](docs/stabilize.md)** -- a one-word trigger
  procedure ("stabilize") for turning "something worth remembering just
  happened" into "written down in the right file, permanently," reliably,
  without the agent having to re-derive where things go each time.
- **[`docs/permission-model.md`](docs/permission-model.md)** -- a
  three-category framework for when an agent should ask before acting:
  checking/reading/verifying never asks; changing code or data always
  asks first; writing notes/decisions acts, then reports. This one
  framework resolves most of the "why does it keep asking me for
  permission to just look at something" friction.
- **[`docs/checks-philosophy.md`](docs/checks-philosophy.md)** -- what an
  automated check suite is for and what it can never do: checks are
  retrospective by construction, an assertion that cannot be evaluated
  must fail rather than silently pass, known failures stay visible
  ("expected") instead of being silenced, scientific checks end in a
  human sign-off gate, and a new check isn't trusted until it's been
  proven to fire on known-bad input.
- **[`docs/never-paper-over.md`](docs/never-paper-over.md)** -- when a
  result looks wrong, find the mechanism producing it; never clip, mask,
  ceiling, or exclude the symptom with an arbitrary threshold. With the
  worked example (exploding confidence intervals) and two tests for
  telling a principled exclusion from a confession.
- **[`docs/cite-the-source.md`](docs/cite-the-source.md)** -- an agent
  can't self-flag invention, because retrieved and generated text feel
  identical at generation time. So run it forward: a claim that can't be
  traced to something citable doesn't get asserted, and guesses worth
  making anyway get a cheap fixed marker instead of a paragraph of
  hedging.
- **[`docs/boot-set-and-stored-memory.md`](docs/boot-set-and-stored-memory.md)**
  -- why the first-read file is capped and everything else is indexed:
  the boot set (loads at every wake) against stored memory (read when a
  cue fires), the one test for what earns a place in the boot set, rules
  rather than history in every file, and handoffs that carry the task and
  the cued files instead of "read everything first."
- **[`templates/MISSION_NOTES_TEMPLATE.md`](templates/MISSION_NOTES_TEMPLATE.md)**
  -- the running-notes format for a parallel sub-project thread: lists per
  RULE #4, archived per RULE #5, and a pointer to the fact that writing
  something here does not deliver it to another thread that needs it now.
- **[`docs/cross-mission-coordination.md`](docs/cross-mission-coordination.md)**
  -- running several parallel AI threads on sub-projects that share
  infrastructure, and the specific failure mode of writing a fact to a
  shared doc and assuming that *delivers* it to a thread that hasn't
  stopped to read it yet.
- **[`docs/mapping.md`](docs/mapping.md)** -- how each piece here maps
  back to Karpathy's three-layer pattern and to Bridgeford et al.'s twelve
  tips, so the abstract argument sits right next to the concrete thing it
  produced.
- **[`docs/what-this-assumes.md`](docs/what-this-assumes.md)** -- what the
  AI tool needs to be capable of, and, more importantly, what you need to
  bring as the person running it. Ends with an explicit use-at-your-own-
  risk: this is not a guarantee of correctness and never will be.
- **[`templates/INTERFACE_TEMPLATE.md`](templates/INTERFACE_TEMPLATE.md)**
  -- the one context doc that governs *how* the human and the agent
  exchange drafts rather than what they say: a phenotype-mismatch
  framing (a strong-recognizer human and a strong-generator agent should
  not imitate each other), a protocol lookup table calibrated per
  person, a dispatch rule that makes the agent name the row it's
  applying, and hard rules about sourcing any standing claim the file
  makes about a specific person.
- **[`skills/`](skills/)** -- the pattern's four procedures (stabilize,
  decide, session-brief, seed-mission) as installable agent skills, for
  tools that support them. Templates are the what-and-why; these are the
  how, made mechanical -- see `skills/README.md` for the division of
  labor and why both shapes ship.
- **[`starter-kit/`](starter-kit/)** -- bare, uncommented versions of the
  four core files plus a `run_checks.sh` skeleton and a `checks/README.md`
  -- copy these into a new project and go, rather than reading the
  annotated templates above first.
- **[`templates/CAPTURE_LOG_TEMPLATE.md`](templates/CAPTURE_LOG_TEMPLATE.md)**
  -- the format for an append-only log of typed captures (axiom /
  empirical / procedural, each owing a kill condition or cost mark),
  with the six-step loop that produces them. Starts empty on purpose;
  seeding it to look populated is the exact failure it documents.
- **[`package.sh`](package.sh)** -- builds the copy a recipient actually
  gets. Every file in the repo is classified as shipping or private, a
  new file in neither list fails the check, and the copy is swept for
  a private list of terms before it counts as built.

(Kept only in the private repo this copy is built from, and deliberately
not part of the deliverable: `TODO.md`, `TEACHABLE_MOMENTS.md`,
`CAPTURE_LOG.md` (the live instance of the capture-log template, with real
entries), dated handoff files, and the sweep-terms file -- internal logs
that keep names and specifics, per their own headers. `package.sh --check`
prints the two lists.)

## What's deliberately NOT in here

No real project content. Every example below is genericized or invented.
The pattern was extracted from a live, unpublished research project with
real collaborators' names and real unpublished findings in its actual
files -- none of that belongs in something meant to be shared.

## Status

This is a living document, not a finished spec. None of it was designed
prospectively -- every piece was added reactively, after getting burned by
the specific thing it now guards against, over real, sustained use of an
AI coding agent on real research. It will keep changing as that use
continues. Treat anything here as "true as of when it was written," not as
a settled standard.

This repo is public so that anyone can try it without an account, while
it is still rough. `START_HERE.md` is the test of whether someone who
isn't living inside the project it came from can use it, and very few
people have tried. Licensed MIT (see `LICENSE`).
