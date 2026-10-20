# What this assumes

Two different kinds of assumptions: what the AI tool needs to be capable
of, and what you need to bring as the person running it. Both matter, and
the second one is easy to skip past.

## What the tool needs to be able to do

- Read and write files persistently, across an entire working session --
  not a single request/response exchange with no memory in between.
- Run shell commands (to run the check suite, git, etc.).
- Either run for long, uninterrupted sessions, or be resumable across
  separate sessions with enough of its own context restored from the
  files themselves that a new session isn't starting from zero. This
  pattern is built for that second case -- an agent that can pick up a
  project it's never seen a conversation about, entirely from what's
  written down.

If your tool is a single-turn chat with no file access, this pattern
doesn't apply to it directly -- there's nowhere for it to write things
down, and nothing to read them back later.

## What you need to bring

This is the half that's easy to skip past, because none of it shows up
as a missing feature -- it just shows up later, as a mistake nobody
caught.

- **You need to actually look at what gets put in front of you.** The
  entire review mechanism in this pattern (see
  `../templates/FAILURE_MODES_TEMPLATE.md`'s "how review is meant to work")
  depends on a human reading the plot, the before/after, the falsifier --
  not glancing at a green checkmark and moving on. A check suite and a
  decisions log make it *possible* to catch a problem cheaply. They do
  not catch it for you.
- **You need to be willing to say "that doesn't look right" even when the
  agent sounds confident.** An agent following this pattern rigorously
  will still, sometimes, produce a wrong result while sounding completely
  sure of itself -- confidence and correctness are not the same signal,
  and there's no way to fully automate telling them apart. Your own
  skepticism is not optional scaffolding here; it's the thing the whole
  system is built to support, not replace.
- **You need some domain judgment about the actual work.** This pattern
  helps an agent not lose track of decisions and not repeat known
  mistakes. It has no opinion on whether your science is right. That's
  still entirely your call.
- **The pattern assumes your recognition signal is reliable even when
  inarticulate.** You may not be able to say what is wrong with a draft;
  the pattern only needs you to know *that* it is wrong when you see it.
  That recognition is the only prospective mechanism in the loop (cf.
  "checks are retrospective" in `checks-philosophy.md`), and everything
  in the interface protocol (`../templates/INTERFACE_TEMPLATE.md`) is
  plumbing that routes drafts past that signal as cheaply as possible.
  Stated honestly: recognition can misfire too -- reject something fine,
  accept something broken -- and nothing here detects that. The pattern
  lowers the cost of each recognition event; it cannot supply the
  judgment.

## Use at your own risk

This is not a guarantee of correctness, and it will never be one. Every
piece of this pattern exists because something went wrong once and got
written down afterward -- which means, by construction, it can only guard
against the *shapes* of mistakes that have already happened at least once
to someone. It will not stop a new one. Nothing here removes the need for
a human who is paying attention; it only tries to make paying attention
cheaper and more reliable than it would be otherwise.
