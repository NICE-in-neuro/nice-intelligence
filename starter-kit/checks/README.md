# checks/

Every check here exists because a specific failure already happened once.
When you add a check, add a line below explaining what it guards and why
-- a check with no documented reason reads as arbitrary the next time
someone considers deleting it.

Two kinds of checks:

- **Hygiene/infrastructure checks** -- fully mechanical, a human never
  needs to look at the output for these to be trustworthy. Wire these
  into `run_checks.sh` and require them to pass.
- **Content/science checks** -- these enumerate exhaustively and present
  compactly, but the actual pass condition is a human's sign-off, not
  anything the check can verify on its own. These often should NOT be
  wired into the pass/fail exit code of `run_checks.sh` -- say so
  explicitly if one isn't, and why.

| check | guards against | wired into run_checks.sh? |
|---|---|---|
| <!-- check_example.py --> | <!-- what failure prompted it --> | <!-- yes/no, why --> |
