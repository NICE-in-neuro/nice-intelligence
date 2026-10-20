# Failure modes

Every entry below should be something that actually happened, with the
class of failure it belongs to and the countermeasure adopted. Don't
pre-write entries for failures that haven't happened yet.

Every failure here should have been caught by a human looking at
something. Every check that exists was written AFTER the failure it
catches -- checks are retrospective, not prescient. The job of everything
else is to put things in front of that human early, in a form that's fast
to judge.

## Entry format

    ## N. <short, specific name for the shape of the failure>

    **What happened.** The actual incident, concrete enough to understand
    the mechanism without having been there.

    **The class.** The general shape, one level of abstraction up --
    what lets a different incident later get recognized as "the same
    class" instead of feeling novel.

    **Countermeasure.** What changed: a new check, a new rule, a changed
    process. If nothing changed, say why not.

<!-- First entry goes here. -->

---

## Before saying a piece of work is done

<!-- Build this checklist as your own failure modes accumulate -- each
     question should be one of the entries above, in the form it takes
     at the moment it can still be caught cheaply. Starting point: -->

1. What is my actual evidence for this claim? Name it. If it's a guess,
   say so in those words.
2. What have I actually put in front of a human -- a plot, a before/after,
   a falsifier stated in advance -- or just a summary of what I did?
3. Did I write the conclusion before the output arrived?
