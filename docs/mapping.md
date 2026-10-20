# Mapping to the two touchstones

## Karpathy's three-layer pattern

[The gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
proposes three layers: raw sources, a maintained wiki, and a schema
governing how the LLM operates on it. This repo's pattern is a specific,
opinionated instance of all three:

| Karpathy's layer | This repo's instance |
|---|---|
| Raw sources | The actual codebase, data, and conversation history -- what the project is really about |
| The wiki | `CLAUDE.md` + `DECISIONS.md` + `OPEN.md` + `FAILURE_MODES.md` + per-sub-project running notes -- cross-referenced, continuously updated, read (not re-derived) at the start of every session |
| The schema | The RULE sequence, the entry formats, the permission model, the STABILIZE procedure -- the fixed rules governing how the agent reads and writes the wiki |

The load-bearing agreement with Karpathy's framing: the wiki is meant to
be a **persistent, compounding artifact** -- it accumulates across
sessions rather than being reconstructed from the raw sources each time.
Everything in `templates/` and `docs/` here is about making that
accumulation actually survive contact with a real, messy, multi-week
project instead of degrading into either (a) nobody writing to it, or (b)
so much accumulated text that a fresh session drowns in it before doing
any actual work. Rules #4 and #5 in `CLAUDE_TEMPLATE.md` are specifically
about that second failure mode -- an append-only wiki that never prunes
just becomes a different kind of unusable.

## Bridgeford et al. 2026, Twelve Tips for AI-Assisted Coding in Science

[The paper](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1014428)
is aimed at the individual coding session; this repo is aimed at the
project that outlives any single session. Where they overlap:

| Tip | This repo |
|---|---|
| Tip 1: Gather background knowledge before implementation | The goals/`SCIENCE.md`-equivalent file, read before the open-items list -- see `CLAUDE_TEMPLATE.md`'s "what this project is trying to learn" |
| Tip 2: Define your problem and distinguish framing from coding | `OPEN.md` (what's broken) vs. the goals file (what it's for) as two deliberately separate documents |
| Tip 4: Think through and divide an implementation plan | RULE #2 -- stage-by-stage disposition of a ported/reference mechanism, shown before an expensive run |
| Tip 5: Manage context strategically | The whole DECISIONS/OPEN/STABILIZE pattern: external, persistent storage instead of relying on a session's own context to carry decisions forward; and the capped boot set with an indexed stored memory (`boot-set-and-stored-memory.md`), so the first-read file stays small enough to finish |
| Tip 6: Meticulously verify AI assistance for testing | `FAILURE_MODES_TEMPLATE.md`'s rule that a new check must be verified to actually fire against known-bad input before being trusted |
| Tip 7: Use tests to specify and constrain AI-generated code | The check-suite philosophy: "an assertion that cannot be evaluated is a FAILURE," never a silent pass |
| Tip 9: Monitor progress and know when to restart | `cross-mission-coordination.md`'s guidance on seeding a fresh thread and treating a seed prompt as reconstructed, not authoritative |
| Tip 10: Critically review generated code | `FAILURE_MODES_TEMPLATE.md`'s "how review is meant to work" section and RULE #1 |
| Tip 11: Refine code incrementally with focused objectives | RULE #2 again, from a different angle -- stage-by-stage, not wholesale |
| Tip 12: Document your code for reuse and publication | This repo, at the meta level |

Tips 3 (choosing appropriate AI interaction models) and 8 (leveraging AI
to audit/expand test coverage) aren't strongly represented here yet --
worth building out rather than force-mapping to something that doesn't
actually fit.
