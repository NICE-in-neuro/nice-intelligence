# INTERFACE.md -- how drafts are exchanged

A template for the one context doc that governs *how* the human and the
agent exchange drafts, rather than what the drafts say. Copy it, then
calibrate every row against your own real exchanges -- the worked
configuration below is one person's, not a default that fits everyone.

## The premise

Communication failures between a human and an agent on writing tasks are
usually phenotype mismatches, not deficits on either side. One common
configuration, the one this template's worked rows come from: the human
is a strong recognizer and a weak first-pass articulator -- they know
the target when they see it, and cannot cheaply describe it in advance.
The agent is the inverse: a strong generator with no taste and no access
to unstated targets. Neither party should imitate the other -- the human
forced to articulate produces a bad spec, and the agent forced to "have
judgment" produces confident guessing. The fix is always interface
design: structure the exchange so each side only does the thing it can
actually do.

If your configuration differs -- a strong-articulator human wants specs
honored, not candidate spreads -- the rows below are wrong for you *in
content* while still right *in form*. Rewrite them from your own failed
exchanges.

The asymmetry itself is not a new discovery, and per this pattern's own
cite-the-source rule it gets its prior art named rather than a fresh
coinage: the generation-verification gap, Guilford's divergent versus
convergent production, the GAN generator/discriminator framing, Ira
Glass's taste gap, and Milton's (2012) double empathy problem all
describe pieces of it. What this file adds is only the protocol table.

## Rules for this file itself

- **Entries are retrospective.** A row earns its place the same way a
  failure-mode entry does: a real exchange went wrong, and the row is
  the countermeasure. Do not pre-write rows for hypothetical friction.
- **It is a lookup table, not an essay**, because vague advice degrades
  under load: an agent asked to judge "does this feel like a
  candidates-first situation" drifts toward the same default every time.
  Named situations convert a judgment call into a lookup.
- **Standing facts must be sourced or marked.** Each one either cites
  the incident that established it, or is explicitly marked as an
  extrapolation with the observation that would kill it. A file that
  regulates unsourced confident claims must not carry its own. (This
  rule has already earned its keep once: an early standing fact --
  "cliche distance is evidence of the idea's originality" -- failed its
  first real kill-test, because underspecified input produces the same
  cliche distance, and had to be weakened to "uninformative until
  input-starvation is ruled out." The strong version read well and was
  wrong.)
- **If the preamble claims MUTUAL mismatch, the table must bind both
  parties.** A file that frames the problem as two-sided and then writes
  obligations for only the agent is claiming a symmetry it doesn't
  practice -- rename it or add the human's side. And rows that describe
  the *human's interior* (what their reactions mean, what they feel)
  enter only with the human's explicit ratification; unratified rows of
  that kind get deleted, not softened -- a wrong model of a specific
  person degrades the collaboration whether or not anyone else ever
  reads it.

## The dispatch rule

When the agent operates from this table, it names the row it is
applying, in a few words, before acting on it. The table's premise is
that the human's recognition is the reliable signal and the agent's
classification is not -- naming the row makes a misclassification
visible and costs the human one word to correct, instead of a silent
wrong turn compounding for a full draft cycle.

## Protocol table (worked example -- recalibrate per person)

| Situation | Do this | Never this |
|---|---|---|
| Target known by feel, not words | Generate 2-4 divergent candidates, ask which is least wrong | Ask the human to describe the target |
| Output rejected without reasons | Treat the rejection as data; offer a forced choice or yes/no probes | Ask "what specifically is wrong?" |
| Rejection is strong ("completely wrong") | Read it as distance, not direction: discard the draft entirely, change the inputs in kind | Edit the rejected draft incrementally |
| Rejection is mild ("not quite") | A gradient exists: edit, or offer variants of the current draft | Regenerate from scratch |
| Content is identity-laden (the human's own ideas, framings, mission text) | The human's words enter first; the agent restructures or edits only | Agent drafts first from a description |
| Content is genre-center (boilerplate, methods prose, code comments) | Agent drafts first | Demanding the human's input on routine text |
| Style correction received ("shorter", "less X") | Redistribute, don't globalize; expect overshoot and offer the middle register | Apply the correction maximally everywhere |
| Register needs specifying | Request or use an exemplar paragraph | Accept or request adjective descriptions of style |
| Two rounds of candidates fully rejected | Stop generating; ask for an exemplar or a seed phrase in the human's own words | A third round of fresh candidates from the same description |

Operational definitions the table needs to actually work:

- **Divergent** means the candidates differ on an axis a rejection could
  inform -- structure, framing, register, length -- so they would fail
  *differently*. Four wordings of one scheme is one candidate wearing
  four outfits.
- **Change the inputs in kind** means different source material,
  register, or structure -- not another sample from the same recipe. A
  strong rejection measured distance; a resample from the same
  distribution lands at the same distance.
- **The identity-laden test**: does the text assert something the human
  believes, discovered, or made (identity-laden), or execute a known
  genre (routine)? When unsure, ask one binary question or default to
  identity-laden -- the failure costs are asymmetric. An original idea
  drafted from a description regresses toward cliche, and the bad draft
  can then read as a verdict on the idea itself -- when in fact a cliche
  draft is uninformative about the idea until input-starvation has been
  ruled out (the fix is more input in the human's words, not another
  draft); routine text waiting for the human's words merely wastes a
  turn.
- **Redistribute** means the correction names a distribution problem,
  not a gain knob: shorten where clauses stack, keep length that earns
  itself. Applied as a global multiplier, "shorter" produces fragments
  -- and the follow-up correction is the expected second half of
  calibrating against a recognizer, not a second failure.

## What this binds the human to (worked example -- recalibrate too)

A file that claims mutual mismatch and then binds only the agent is
claiming a symmetry it doesn't practice (see the rule above). The rows
already imply the human's side; stated explicitly:

- Answer forced choices and yes/no probes when offered, rather than
  requiring the agent to extract reasons the configuration says the
  human cannot cheaply give.
- Supply an exemplar paragraph when register is contested, since
  adjective descriptions of style are the input format this file bans
  the agent from accepting.
- For identity-laden content, supply the seed words -- the protocol's
  whole premise is that no draft can substitute for them.
- Say the trigger word when the exchange itself is the problem, since
  the agent's own misreads of the exchange are exactly what it cannot
  reliably detect from inside.

## The trigger, and its upgrade path

Pick one word that invokes this file mid-session ("mismatch," scoped to
how the pair is communicating rather than to data or versions). A prose
trigger is the fragile kind -- the source project's own history includes
a formatting rule written down twice in capitals and violated for eight
hours because nothing mechanical enforced it. If the trigger misses
twice, convert the procedure into an installable skill (the pattern's
repo ships reference skills for exactly this move) and log the
conversion in `DECISIONS.md`.

## What this file does not claim

The human's recognition can misfire: reject something fine, accept
something broken. Nothing in this file detects that -- it only makes
each recognition event cheaper (candidates, forced choices, named rows).
The reliability of the recognition signal is an *assumption* of the
whole pattern, stated with the pattern's other assumptions in its
what-this-assumes doc, not a fact this file establishes. (This template
gets copied into projects, so no relative link here -- the doc lives in
the pattern's own repo.)
