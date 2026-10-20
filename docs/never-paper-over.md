# Never paper over a problem

When a result looks wrong -- an implausible value, an outlier, a
blown-up confidence interval -- the fix is to find the actual mechanism
producing it. Never to mask, clip, ceiling, exclude, or otherwise hide
the symptom behind an arbitrary threshold or a made-up constant.

## The worked example

(Genericized from a real incident; see `README.md`.)

A model-fitting pipeline started producing confidence intervals that
exploded to physically absurd values -- many orders of magnitude beyond
anything the measured quantity could be.

The first "fix": exclude the poorly-sampled regions, on the theory that
sparse data was producing unstable estimates. Plausible, and it made
most of the absurd values go away. Not all.

The second "fix": a hard plausibility ceiling -- exclude any estimate
exceeding a round number chosen because nothing real could be that
large, regardless of how well-sampled the region was.

The project owner rejected the ceiling outright, with the reasoning that
became this rule: **if a region has plenty of data and still produces an
absurd estimate, something is genuinely wrong with the estimate there,
and silently zeroing it with an unexplained constant hides that instead
of surfacing it.** A clean-looking plot produced this way is a plot of
the masking, not of the data.

The actual fix required tracing the mechanism. The explosions came from
the fitted model's own parameter covariance being poorly identified for
specific combinations of basis functions near the domain's edges --
which is a different thing from sparse sampling. Data density is not the
same as parameter identifiability; a region can have abundant data and
still leave a particular coefficient unconstrained. Once that was
understood, the exclusion criterion could be principled: read the
model's *own self-reported confidence* directly (the width of its own
interval), rather than an indirect proxy (how much data landed in the
region) or an external arbitrary number (the ceiling).

## Why the bad fixes are so tempting

They work immediately. They look principled -- "quality filtering,"
"outlier removal," "plausibility bounds" all sound like rigor. They
produce clean figures on the first try. And each one quietly converts an
unexplained anomaly, which is *information*, into an absence, which is
nothing.

Two tests for whether a proposed fix is a paper-over:

1. **Can you state the mechanism?** Not "values above X are implausible"
   but *why* the pipeline produces values above X in the first place. If
   the answer is unknown, the fix is premature by definition.
2. **Where does the threshold come from?** A criterion derived from the
   mechanism (the model's own reported uncertainty, a known detector
   saturation point, a documented physical limit) is an exclusion rule.
   A round number chosen because it makes the symptom disappear is a
   confession.

## The escape hatch, stated honestly

Sometimes a mechanism-based fix is not reachable in reasonable time.
That is allowed -- what is not allowed is shipping the workaround
silently. Say explicitly: the cause is not understood, here is the
symptom, the result is flagged unresolved. An honest open problem costs
some polish. A silent workaround costs the moment where someone
downstream -- a collaborator, a reviewer, you in six months -- trusts a
number that was quietly manufactured.

## Relation to the check suite

This rule and the expected-failure mechanism in `checks-philosophy.md`
are the same stance applied to two different objects. A failing check
does not get baselined to green; a wrong-looking number does not get
clipped to plausible. In both cases the move that "cleans things up" and
the move that destroys the evidence are the same move, and the
alternative is the same too: keep the problem visible, on a ledger, with
its cause either found or explicitly marked unknown.
