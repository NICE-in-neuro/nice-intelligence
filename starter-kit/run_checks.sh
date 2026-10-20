#!/usr/bin/env bash
# STATUS: reusable
#
# Runs every check in checks/ and reports pass/fail. On failure it points
# you at OPEN.md's declared-expected-failures list; the expected-vs-new
# comparison is yours to make by reading it (this bare skeleton does not
# compute it -- a fuller version can, by parsing OPEN.md's
# EXPECTED-FAILURE lines and diffing them against the failed set).
# Changes nothing. Safe to run any time, as often as you like.

set -uo pipefail
cd "$(dirname "$0")"

FAILED=()
for check in checks/check_*.py; do
  [ -e "$check" ] || continue
  echo
  echo "--- $check ---"
  if ! python3 "$check"; then
    FAILED+=("$(basename "$check" .py)")
  fi
done

echo
echo "================================================================"
if [ ${#FAILED[@]} -eq 0 ]; then
  echo " all checks passed"
else
  echo " ${#FAILED[@]} CHECK(S) FAILED: ${FAILED[*]}"
  echo
  echo " Cross-reference against OPEN.md's 'Expected check failures' list --"
  echo " anything not declared there is new. Read it."
fi
echo "================================================================"
