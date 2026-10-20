# The boot set and stored memory

## The problem this answers

A project that only ever adds to its first-read file ends with a first-read
file nobody finishes. The agent skims it, and a skimmed rule is not a
rule. Each addition was justified when it went in; the sum is a file that
costs every session its attention before any work starts.

The project owner's words for the fix: "There's a difference between
storing a long term memory and then having to load it into working memory
every time you wake up."

## Two kinds of project knowledge

**The boot set** is what loads into working memory at every wake: the
standing-rules file (`CLAUDE.md`), `ETHOS.md`, the open-items list, and
nothing large besides. It is capped.

**Stored memory** is everything else the project knows: the decision log,
the failure-modes log, the goals file, per-mission notes, archives,
reference notes. It is indexed in one table inside the rules file and read
when a task cues it. It is never bulk-loaded at session start, and its
growth is uncapped by design, because reading it is optional until a cue
fires.

Moving a fact out of the boot set does not lose it. It changes the fact
from mandatory-by-default to retrievable-by-cue.

## What earns a place in the boot set

One test: **could a thread cause damage or waste before any cue would send
it looking?** If yes, the fact is a *reflex* and stays in the boot set:
what costs real money, what deletes data on a remote when run, which
machine may write to version control, which files are written only at
stopping points because parallel threads share them. If no, it gets one
line in the index: a cue (the situation in which to read) and a file (what
to read).

Cues are situations, not topics. "Before anything expensive" fires when
the agent is about to spend; "billing" fires only if the agent already
thought of it.

## The index

A two-column table in the rules file:

| Cue | Read |
|---|---|
| Any analysis, before running it | the goals file: the question, the claims, what falsifies each |
| Session start | the open-items list |
| Before re-deciding anything | the decision log: grep the headings, open only the entries that hit |
| Before saying work is done | the failure-modes checklist |
| Working inside a sub-project | that sub-project's own rules file, then grep its notes headings; do not bulk-read |

The index is the only place the boot set mentions stored memory, so a file
that is not in it is a file no cue will ever find. When a new stored file
is created, its index row is part of creating it.

## Rules, not history

Every markdown file in the pattern holds rules, not narrative. The project
owner, when told what the files had become: "I don't need you to save
stories about where mistakes were made. just save rules to live by." The
account of how a rule was learned belongs in version control, which keeps
the old text. The file keeps the rule, its reason in a clause, and the
check that covers it.

This is the same discipline as RULE #4 and RULE #5 in `CLAUDE_TEMPLATE.md`
(lists, not paragraphs; superseded entries archived), applied to the
boot set itself.

## The cap

A check measures the boot files in bytes against a small manifest: one
line per file with its cap, plus a total. It fails when any file or the
total is over.

Over budget means moving something to stored memory and leaving one index
line. It does not mean raising the cap. A cap that is raised whenever it
binds is not a cap, and the boot set returns to being the file nobody
finishes.

Sub-project rules files get the same check with their own cap. The agent
working inside a sub-project loads the root boot set and that sub-project's
rules file, so both count toward what loads.

## Handoffs: cue, don't load

A handoff to a new thread carries the boot set (it loads anyway), the
task, and the specific stored files the task cues. It does not say "read
everything first." Point at index rows and let the work pull the rest.
A thread told to read everything arrives having spent its attention on
files the task never needed.

## What this does not do

- An index only works if its cues are honest. An agent can skip a cue and
  not know it, and no check can tell whether the index is complete.
- The test for a reflex is a judgment call. Two reasonable people will
  disagree about whether a given fact is damage-before-cue. When unsure,
  start in the index; promote to a reflex the first time skipping it costs
  something.
- The cap measures size, not quality. A file can fit the budget and still
  be wrong.
