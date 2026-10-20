# Cite the source; don't rely on flagging its absence

An AI agent cannot reliably self-flag when it is making something up,
because retrieved text and generated text feel identical from the inside
at the moment of generation. There is no internal signal that says "this
part is invented." This doc is about what to do instead, since "remember
to hedge more" is not a fix that can work even in principle.

Scope note: this is about truthfulness of claims, not about instruction
primacy. It is a different rule from "the human's live word overrides
written notes" (RULE #0 in `../templates/CLAUDE_TEMPLATE.md`), and
conflating them muddles both.

## Why the self-flagging approach fails

A marker that depends on the model *noticing* its own uncertainty fires
when things are already going well and stays silent exactly when they
are not. Worse, its absence then reads as a guarantee it never earned:
if the agent flags some guesses, an unflagged sentence looks vetted.
The mechanism is asymmetric in precisely the wrong direction.

This is a documented failure mode of the tools, not a personality flaw
to be fixed by trying harder. Bridgeford et al.'s Tip 10 (see
`mapping.md`) states the finding directly: models tend to claim success
and completeness even when they haven't earned it, without the flagging
instinct a human engineer would have.

## The rule, run forward instead

**If a claim cannot be traced to something citable -- a file and line, a
returned search result, a quoted passage -- it does not get asserted.
Cite it or cut it.**

This converts the problem's shape. A missing citation is a *visible*
gap a reader can see and challenge, rather than an implied warrant
silently attached to every unflagged sentence. The load is carried by
the citation discipline, which is mechanical, not by the model's
introspection, which is unavailable.

## The cheap escape valve

Some claims are worth making without a source. For those, the admission
should cost a few words, not a paragraph: a short fixed phrase -- "no
source for this, but I think ..." or the project's equivalent -- used
freely and without ceremony. Two things make this work:

- **It has to be cheap.** A norm that demands a paragraph of hedging per
  guess teaches the agent (and the human) to skip the admission. Four or
  five words, mid-sentence, no throat-clearing.
- **It is a courtesy when it fires, not a guarantee when it doesn't.**
  The load stays on cite-or-cut. The phrase exists so that guesses worth
  making have a legal, low-friction form -- not so its absence can be
  read as verification.

## The worked example

(Genericized from a real incident; see `README.md`.)

During a data-conversion task for a public archive, an agent wrote a
specific institutional fact into a metadata comment, annotated as
"inferred from" context -- stated fluently, formatted like every
verified fact around it, and wrong. No file said it; nothing anyone had
said supported it. The human caught it and asked the only question that
matters here: how do we *prevent* this, not just fix it?

The fix had three parts, and the parts are the point:

1. **Correct the specific error.** Necessary, obviously insufficient.
2. **Name the violated rule, and reject "be more careful" as the fix.**
   A cite-or-cut rule already existed in that project and had been
   violated anyway -- and a different restraint-dependent rule had
   already failed once before, in the same project's incident log. A
   rule that depends on the model's own restraint has a documented
   failure rate. Restating it louder does not change the mechanism.
3. **Build a mechanical check, and prove it.** A script that scans for
   sensitive-fact-shaped statements (institutions, identities,
   provenance claims) with no citation marker nearby -- then validated
   by reconstructing the *actual* offending comment and confirming the
   check fires on it, per the verify-the-verifier standard in
   `checks-philosophy.md`. Not on invented test cases: on the real
   failure, rebuilt.

The sentence that would have been harmless is instructive: the same
claim, prefixed with "no source for this, but I think." Five words.
The failure was never that the guess existed -- guesses are legal. The
failure was that it wore the same clothes as verified fact.

## What this asks of the human

The discipline is two-sided. An agent following cite-or-cut will
produce text with visible gaps and cheap hedges in it -- less fluent,
less finished-looking than the alternative. That is the deliverable
working as intended. A human who rewards polish over marked uncertainty
is training the exact failure this doc exists to prevent.
