# The checks philosophy

A project running this pattern accumulates a `checks/` directory and a
`run_checks.sh` that any session can run in seconds. This doc is the
reasoning behind that suite: what a check is for, what it can never do,
and the specific design rules that survived contact with real failures.
Every worked example below is genericized from a real incident (see
`README.md` for why the originals aren't reproduced).

## Checks are retrospective, never prescient

Every check exists because a specific failure already happened. Nobody
writes the check for an error that hasn't occurred yet, and attempts to
do so speculatively produce checks that guard against imagined failures
while the real ones arrive from somewhere else.

Two consequences, both features rather than bugs:

- **The suite is never "done."** It grows one check at a time, each one
  planted on the grave of a specific mistake. A suite that stops growing
  means either the project stopped making novel mistakes (unlikely) or
  stopped converting them into checks (fixable).
- **The human is the only prospective mechanism.** Checks catch the
  *recurrence* of known failure shapes. The next novel error will be
  caught, if at all, by a person looking at something -- a plot, a
  before/after, a falsifier stated in advance. So the job of the whole
  apparatus is to put things in front of that person early, in a form
  that is fast to judge. (This is the central claim of
  `../templates/FAILURE_MODES_TEMPLATE.md`, restated here because the
  two docs are halves of one argument.)

## An assertion that cannot be evaluated must FAIL

Every code path through a check has to reach a real exit code. "I could
not evaluate this" is a failure, never a silent pass.

Worked example: a cleanup script was supposed to search for stale files
and delete what it found. Its search step silently failed to run at all
-- and the output it printed, "0 stale files found," was *identical* to
what genuine success would have printed. Nothing distinguished "searched
and found nothing" from "never searched." The fix was structural, not
more care: the script had to prove its search actually executed (for
instance, by first finding something it was known to be able to find)
before its zero was allowed to count.

The general form: any check whose failure mode produces the same output
as its success is not a check. It is a decoration.

## The expected-failure mechanism

A known, tracked problem and a brand-new breakage must be
distinguishable at a glance, without hiding either.

The mechanism: the project's open-items file declares known failures
explicitly ("EXPECTED-FAILURE: <check group> -- <why>, <priority>"). The
check itself still runs in full and still fails -- nothing is
suppressed, the exit code stays non-zero, the full output still prints.
The runner then partitions the failures: expected ones are listed as
tracked, anything else is flagged loudly as NEW. And when a declared
failure starts *passing*, the runner says so and instructs that the
declaration be deleted -- a stale "expected failure" that now passes is
the open-items file lying to the next session.

What this is not: baselining a check to get a green result. The
difference is visibility. An expected failure stays red, stays printed,
and stays on the open-items list as debt. A silenced check disappears.
The first is a ledger; the second is the same move as clipping an
outlier (see `never-paper-over.md`).

## Machine finds, human judges

This is the design rule specific to *scientific* checks, as opposed to
code-hygiene ones, and it is the least obvious.

Worked example: a check was built to reconcile every number in a
manuscript against the analysis outputs that should have produced it.
The first version was technically correct and useless: it buried one
real discrepancy in hundreds of false matches, because deciding whether
"n = 47" in a sentence refers to *this* table's 47 requires judgment no
matcher has. The fix was not a smarter matcher. It was accepting a
division of labor: the check's job is to enumerate exhaustively and
present compactly -- every number, every candidate source, laid out for
fast scanning -- and the *pass condition* is a recorded human sign-off.
The sign-off expires the moment the underlying input changes, so the
check fails again on any edit until a human re-reviews.

The point generalizes: for any property that genuinely requires
judgment, do not build a check that fakes the judgment. Build one that
does the mechanical gathering perfectly and then makes the human's
review a hard gate that no amount of model confidence can satisfy.

## Verify the verifier

A new check is not trusted until it has been proven to fire on known-bad
input -- ideally the *actual* bad artifact that motivated it,
reconstructed, not an invented test case that may share nothing with the
real failure's shape.

Worked example: a check written after an agent fabricated a plausible
fact in a code comment was validated by reconstructing the real
offending comment in a scratch file and confirming the check caught it.
Invented test cases had been the first instinct; the reconstruction
standard exists because an invented case tests the check's author's
imagination, not the failure.

There is a second level, discovered in practice rather than designed:
**have an independent session re-derive an incident's claims from the
raw files, not from the summary of them.** When this was actually done,
the independent pass confirmed the original report -- and, as a side
effect, found an unrelated real bug in a different, older check that the
original work had no reason to look at. Independent verification is not
just confirm/deny on the thing being checked. It is a second,
differently-angled pass over adjacent state, and what it turns up
incidentally is part of its value.

## The initiation axis: push and pull

Every check in the suite pushes: it fires on its own schedule, at
session start or before "done," without anyone asking. For correctness
content that is the whole point -- a wrong number does not care about
your feelings, and neither should the thing that catches it.

But correctness of a push is necessary, not sufficient. Some content is
*shame-prone*: the aged task, the long-overdue obligation, the
instrument nobody has used yet. For that content the initiation
direction carries the entire therapeutic load. A check that nags about
an overdue piece of work is correct and makes everything worse: each
firing adds to the exact avoidance debt that keeps the work undone. The
same information, waiting silently until the human invokes it, is care.

So the design rule: **classify the content before choosing the
mechanism's direction.** Correctness-critical, emotionally neutral,
file-targeted: push, loudly. Aged, avoidance-loaded, or aimed at the
human's own practice rather than the work's state: build it pull-only
-- it runs when invoked, appears nowhere by default, keeps no negative
records, and never initiates. And audit the borderline cases for
affect: an alarm-styled banner on a merely-slow item is a push
dressed as urgency; the calm one-line version carries the same
information without the tax.

The tell that this axis exists at all came from a real system where
every instrument pushed by design -- until a practice for long-overdue
work needed building, and the correct-but-harmful check became
conceivable. A suite's culture generalizes exactly one step too far:
"make it mechanical" is right; "make it mechanical *and
self-initiating*" is right only for content that cannot be hurt by
being brought up.

## What a green suite means

Less than it feels like it means. A passing suite says: none of the
failure shapes this project has already made, and converted into checks,
are currently recurring. It says nothing about the next novel error, and
nothing about whether the science is right. Treating green as "correct"
is the exact misreading this whole doc exists to prevent.
