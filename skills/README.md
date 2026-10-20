# Skills: the procedures, made mechanical

The templates and docs in this repo are the *what and why* of the
pattern. The four skills here are the *how, made mechanical* -- the
pattern's procedures with steps, packaged so an agent tool that supports
skills triggers them off their own descriptions instead of relying on
the model remembering to follow prose.

The division of labor is deliberate (decided 2026-08-13; the decision
record lives in the project's internal planning log, which keeps names
and specifics and is not part of the deliverable): everything that is
*read* -- the rules file,
the log formats, the failure-mode entries, the philosophy docs -- stays
canonical as templates, tool-agnostic and transparent, because copying
and editing a template is itself part of the onboarding. Everything that
is a *procedure with steps* gets a skill as its reference
implementation, because the repo's own core argument ("make it
mechanical, don't rely on the model remembering") applies more strongly
to the procedures than to anything else. The prose docs point here
rather than duplicating steps; two copies of a procedure drift apart,
and that drift is a failure the source project already lived through.

## What ships

- **`stabilize/`** -- the one-word trigger that persists the last
  exchange's keeper (decision, fact, incident, or open question) into
  the correct file. The prose account is `../docs/stabilize.md`.
- **`decide/`** -- formats a just-made decision into the four-field
  `DECISIONS.md` entry and clears the matching `OPEN.md` line in the
  same edit.
- **`session-brief/`** -- runs the project's own state scripts at
  session start (or assembles the same information from the files when
  no script exists) and summarizes, unexpected check failures first.
- **`seed-mission/`** -- scaffolds a new parallel sub-project repo,
  including the one genuinely dangerous step: initializing git in the
  only order that is safe inside a cloud-synced folder. Bundles a
  tested shell script; read its configuration block before first use.

## Installing

Copy the skill directories you want into your project's
`.claude/skills/` (or your agent tool's equivalent):

    cp -R stabilize decide session-brief seed-mission  <your-project>/.claude/skills/

Then read each `SKILL.md` once yourself. The skills reference your
project's own files (`DECISIONS.md`, `OPEN.md`, `CLAUDE.md`,
`run_checks.sh`) -- the starter-kit versions of those files carry the
formats the skills point at, so install the starter kit first if you
haven't. `seed-mission` additionally needs its script's configuration
block set for your project (designated-git-machine marker; sync-provider
ignore command).

If your agent tool has no skills mechanism, nothing is lost but the
auto-triggering: each `SKILL.md` is readable prose, and pasting its
procedure into your rules file recovers the old, weaker,
remember-to-follow-it arrangement.
