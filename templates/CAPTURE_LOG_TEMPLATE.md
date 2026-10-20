# Capture log

Append-only log of captures: one-sentence statements of what a break in
the work *proved*, typed and owing a kill condition. Same argument as
`DECISIONS_TEMPLATE.md` makes for itself: a capture that only exists in
a conversation transcript is not real, because nothing detects its own
forgetting. This file is the part that persists.

## The loop that produces entries

1. Work until something breaks: a result that will not fit, a step that
   fails, a part of the work that will not hold still. That friction is
   the entry signal. Go and look at it directly rather than turning it
   over in your head.
2. Write one sentence stating what the break *proved*. Not what
   happened; what it proved.
3. Test it three ways. **Askability:** pose one question that could not
   be posed before the sentence existed. **Portability:** the sentence
   must work on a reader with no context; if it needs the story of its
   discovery, it is scaffolding. **Priority:** check this log first,
   then the wider project record; a sentence the record already contains
   is a rederivation, labeled and cited, not a discovery.
4. Type it. An **axiom** owes no falsifier. An **empirical** capture
   owes one attached clause, "this dies if," written before data. A
   **procedural** capture owes a cost mark. A sentence that can accept no
   kill condition carries a visible doctrine-risk flag here, not in
   someone's head.
5. Offer it to the project owner for their record, not the agent's. An
   evidence-citing rejection triggers immediate concession; a
   taste-citing rejection gets logged; an unstated reason gets one
   question.
6. Pursue the new question until it breaks something; go to 2.

## What goes in here

Only step 2-4 output from an actual run of the loop. **Do not seed this
file with invented entries to make it look populated.** An empty log
with the format ready is the honest state until something actually
breaks. A capture manufactured to fill the log is an ungated capture
count, which is performable and therefore worthless.

## Format

One entry per capture. Newest at the top.

    ### YYYY-MM-DD  <the one sentence -- what the break proved, not what happened>
    type: axiom | empirical | procedural
    owes: <empirical: the "dies if" falsifier, written before any data that
      could settle it> | <procedural: the cost mark> | <axiom: none owed>
    broke: <one line -- the incident/friction that produced this, so a later
      reader isn't just trusting the sentence>
    tested:
      askability -- <the question this makes newly posable that wasn't before>
      portability -- <does it survive with no context attached? if it needs
        the story, it's scaffolding, not a capture -- say so and downgrade it>
      priority -- <checked against this log and the project record;
        rederivation of an existing entry (name it), or none found>
    offered: accepted | logged (taste-based rejection) | open (one question
      asked, unresolved) | not yet offered
    doctrine-risk: <flag, if this capture can't accept any kill condition -- or
      "none">

## Why append-only

What makes a capture log legible is WHEN something broke and in what
order, not a tidy always-current summary. Superseded or killed captures
stay, marked as killed, rather than being deleted. The first logged kill
is itself a capture, and a log with zero kills after a long stretch is a
thing to audit, not a thing to be proud of.

---

<!-- First entry goes here, when something actually breaks. -->
