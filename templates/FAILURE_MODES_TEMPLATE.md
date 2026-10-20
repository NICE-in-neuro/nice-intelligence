# Failure modes

Every entry below should be something that actually happened in this
project, with the class of failure it belongs to and the countermeasure
adopted. Do not pre-write entries for failures that haven't happened yet
-- this file's whole value is that it's retrospective and honest, not a
speculative list of things that could theoretically go wrong.

**The central claim to carry, stated once and meant literally: every
failure below was caught by a human looking at something, and every
automated check that exists was written AFTER the failure it catches.**
Checks are retrospective by construction. They cannot catch the next
novel error, because nobody has written the check for an error that
hasn't happened yet. So the human reviewing the agent's work is the only
PROSPECTIVE mechanism available -- the job of everything else (checks,
this file, the rules in `CLAUDE_TEMPLATE.md`) is to put things in front of
that human early, in a form that's fast to judge, not to replace their
judgment.

## Entry format

    ## N. <short, specific name for the shape of the failure>

    **What happened.** The actual incident, concrete enough that a reader
    unfamiliar with the details still understands the mechanism.

    **The class.** The general shape, one level of abstraction up from the
    specific incident -- this is what lets a DIFFERENT incident later get
    recognized as "the same class" instead of feeling novel each time.

    **Countermeasure.** What changed as a result: a new check, a new rule,
    a changed process. If nothing changed, say so and say why not.

## Worked examples (genericized -- see README for why these aren't the
## real incidents that produced them)

## 1. Absence inferred instead of measured

**What happened.** An agent searched for something using a tool that
silently narrows what it searches (a wrapped command, an honored
ignore-file, a search index with stale coverage) and reported a clean
"not found" as if it were a measured absence.

**The class.** Absence claims about a bounded, searchable thing (a repo,
a folder, a file set) are cheap to check properly and should never be
asserted from a single search, a fuzzy/semantic lookup, or memory. A
semantic or fuzzy search in particular cannot return zero -- it's a
ranking, not a filter, so it always returns *something* whether or not
the thing being searched for actually exists.

**Countermeasure.** Use an exact tool that can return a literal, checkable
zero (grep/find/ls, not a semantic search) for absence claims about
bounded things. Verify the search actually covers the ground it claims to
by testing it against something you know it should find, before trusting
a zero result.

## 2. Agreement mistaken for correctness

**What happened.** Two independent-seeming checks or investigations
agreed with each other, and that agreement was treated as confirmation --
but both were downstream of the same upstream assumption, so agreeing
with each other proved nothing about whether the shared assumption was
right.

**The class.** Consensus between things that share a hidden common cause
isn't independent evidence. Before treating agreement as confirmation,
check whether the two things that agree could fail together for the same
underlying reason.

**Countermeasure.** When something needs real confirmation, seek a check
that could plausibly fail *differently* than the first one -- a genuinely
different method, a different data source, or a human reading raw output
directly -- not just a second pass over the same pipeline.

## 3. A property reasoned about instead of checked

**What happened.** A plan depended on a fact about some external or
hard-to-inspect state (another machine, a remote, a second process, a
collation order) that was assumed from how the system "should" behave,
rather than read directly on this occasion.

**The class.** A claim about what a system's state IS, asserted from what
a plan needs it to be, from memory of an earlier check, or from an
assumption about typical behavior, rather than from reading that state
right now. Generalizes "absence inferred instead of measured" (entry 1)
to live, cross-machine, or otherwise not-directly-inspectable state.

**Countermeasure.** Read the exact state a plan depends on, on this
occasion, before acting on it. Where the state genuinely cannot be read
from here, say so explicitly rather than proceeding on the assumption --
and where a procedure has two sides whose safety depends on a fact about
each other, redesign it so the side that CAN check its own state acts
unilaterally, instead of trusting an unverified handshake.

## 4. A compound instruction, half executed, read as whole

**What happened.** An instruction correctly separated two open questions
("do X now, Y is a separate, still-open decision -- don't conflate
them"). The agent executed X correctly, then treated Y as resolved by
proximity -- it had been mentioned in the same breath as X, and that was
enough for it to quietly stop being tracked as open.

**The class.** Resolving one half of a compound instruction gets treated
as resolving both, because the "what remains open" list was inherited
from the topic boundary of a note rather than freshly re-derived. Nothing
forced the list to be complete before real, expensive, hard-to-cheaply-
redo work went ahead on it.

**Countermeasure.** Before porting or replacing any nontrivial mechanism,
enumerate every one of its stages fresh, read directly from the source,
not from memory of what an earlier note already flagged. Every stage gets
an explicit disposition: replaced (with what), deliberately dropped (with
why), or open. Treat any note phrased "don't conflate X and Y" as "X and Y
each need their own explicit answer" -- never as "settling X handles Y."
(This is `CLAUDE_TEMPLATE.md`'s RULE #2.)

---

## How review is meant to work

The countermeasures above are all secondary. The primary mechanism is
that things get put in front of the human in a form they can judge in
seconds, not minutes.

**Always show the actual result, never just a summary of it.** A wrong
number in a table looks exactly like a right number; a wrong number in a
plot usually looks wrong. Every quantitative result gets rendered and
shown by default, not summarized in prose with an offer to show it if
asked.

**Show before/after when anything changes.** A rerun after a bug fix
should produce a comparison, not a claim that it worked.

**State the falsifier before running, not after.** For each claim, state
what result would mean the analysis is broken -- BEFORE seeing the output.
A prediction written after seeing the result is a rationalization wearing
a prediction's clothes.

**Surface ambiguity instead of resolving it quietly.** Do not pick the
most likely interpretation of an unclear instruction or an unclear result
and proceed. Name the ambiguity and ask, or list the possibilities
explicitly and say which one you're proceeding on and why.

## Before saying a piece of work is done

A handful of questions, each one a failure mode above in the form it
takes at the moment it can still be caught cheaply:

1. **Did I measure the absence, or infer it?** If a claim rests on a
   search returning nothing, search a second way that would fail
   differently, and show the command.
2. **Did I write the conclusion before the output arrived?** If the
   label was drafted first, re-read the output with the label deleted.
3. **What is my actual evidence?** Name it plainly. If it's a timestamp,
   or "the code looks right," say so in those exact words. If it's a
   guess, flag it as a guess -- cheaply, in a few words, rather than with
   a paragraph of hedging that buries the admission.
4. **Could this check have failed to evaluate and still reported a
   pass?** Every code path through a check must reach a real exit code.
5. **What class does this failure belong to, and where else does that
   class live?** Fix the shape, not just the specific trigger.
6. **What have I actually put in front of the human?** A plot, a
   before/after, a falsifier stated in advance. If the honest answer is
   "a summary of what I did," nothing has actually been checked yet.
7. **Is any claim here about a system's CURRENT state, rather than
   checked against it on this occasion?** See entry 3 above.
8. **If a broad search just returned zero, has it been proven to
   actually cover the ground it claims to?** See entry 1 above.
