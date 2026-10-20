---
name: decide
description: Use this whenever a decision has just been made in this project's conversation that changes what a future session should do -- a methodological choice, a version-of-record designation, a bugfix with real blast radius, a scope call, anything CLAUDE.md's "write decisions down when they are made" rule covers. Formats it into the project's fixed four-field entry (said/because/affects/checkable) and adds it at the top of the live log in DECISIONS.md, and removes the matching line from OPEN.md in the same edit if this decision closes an open item. Trigger this as soon as the decision is made, not at the end of the conversation -- also used internally by the "stabilize" skill whenever what's being stabilized is a decision.
---

# Decide

Write the entry when the decision is made, not at the end of the thread.
Thread-end distillation is written by a session that has already run long
and lost sharpness, and it inherits that. An entry costs about four
lines; add it before the conversation moves on to the next thing.

Why this skill exists at all: most of what looks like "the model forgot"
is not memory failure, it's storage failure -- the decision only ever
existed in a transcript, and a model has no way to detect its own
forgetting at generation time. The fix has to be external and
mechanical, which is what this skill is for.

## Where to write it

Your project's `DECISIONS.md` is append-only. The newest entry goes at
the top of the log, immediately after the file's own intro/format
section. Do not append at the bottom -- a reader who opens the file
wants the most recent decision first.

## The format

The authoritative format lives in the header of your `DECISIONS.md`
itself -- read it there, don't rely on this skill's copy staying
current. The shape is four fields:

```
### YYYY-MM-DD  one-line statement of the decision
said: the actual words, quoted, if they were distinctive
because: the reason, if it is not obvious
affects: which files, modules, or future choices this constrains
checkable: name of the check enforcing it, or "no" with why not
```

Date the entry for when the DECISION was made, which is not always the
same day the commit or edit lands -- a session that crosses midnight
still dates its entries to when the project owner actually said the
thing.

`checkable` is the field that matters most. If a decision can be
enforced by a script, name the check. If it's a judgment call nothing
can verify, write "no, needs judgment" or something similarly specific
-- never leave the field out. Silence there reads as "this is enforced,"
which is a worse state than admitting it isn't checkable at all.

Keep the entry itself short -- four lines is the target, though a
decision with real complications (a bug's full blast radius, a
superseded prior decision) can run longer. Quote the project owner's own
words rather than paraphrasing wherever they said something distinctive;
paraphrase strips hedges and agency and reads as more certain than they
actually were.

## Closing an OPEN.md item

Before finishing, check whether this decision resolves something listed
in `OPEN.md`. If it does, delete that line from `OPEN.md` in the **same
edit** -- not a follow-up, the same edit. A decision recorded without
clearing the open item it closes leaves `OPEN.md` (which a fresh session
reads verbatim before doing anything else) lying about what's actually
still unresolved. That is a worse failure than never having written the
decision down at all, because it actively misleads the next session
instead of just being silent.

## Report back

Say what was written and where, in a line or two. If this ran as part of
`stabilize`, that skill's own three-line report already covers it --
don't double-report.
