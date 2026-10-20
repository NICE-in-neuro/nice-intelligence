#!/usr/bin/env bash
# STATUS: reusable
#
# Builds the copy of this repo a recipient actually gets: exactly the
# shipping set, nothing else, swept for private terms before it counts.
#
#   ./package.sh --check         classify every file in the repo; FAIL on
#                                any file in neither list. A new file has
#                                to be sorted before it can be forgotten.
#   ./package.sh <target-dir>    copy the shipping set into a new directory
#                                (refuses if it exists), then sweep the
#                                copy. Exit 0 only if the sweep ran and
#                                found nothing.
#
# The sweep-terms file (.sweep_terms.txt: one extended regex per line,
# matched case-insensitively at word boundaries) is PRIVATE. It carries
# the very names it guards against, so it never ships. Without it the
# copy step still runs but reports the sweep as SKIPPED, not passed, and
# exits non-zero: an assertion that cannot be evaluated is a failure.
#
# LICENSE is excluded from the sweep on purpose and the exclusion is
# printed every run: an MIT license names its copyright holder by design.
#
# Changes nothing inside this repo. Safe to run any time.

set -uo pipefail
cd "$(dirname "$0")"

SHIP_DIRS=(templates docs skills starter-kit)
SHIP_FILES=(README.md LICENSE START_HERE.md package.sh .gitignore)
PRIVATE_FILES=(TODO.md TEACHABLE_MOMENTS.md CAPTURE_LOG.md .sweep_terms.txt)
PRIVATE_GLOBS=('HANDOFF_*.md')
SWEEP_TERMS=".sweep_terms.txt"

# Every file git knows about, plus untracked files git would not ignore.
# .DS_Store and friends are gitignored and therefore never listed.
ALL=()
while IFS= read -r f; do ALL+=("$f"); done \
  < <( { git ls-files; git ls-files --others --exclude-standard; } | sort -u )
if [ ${#ALL[@]} -eq 0 ]; then
  echo "FAIL: file listing returned nothing; cannot classify an empty set."
  exit 1
fi

classify() {
  local f="$1" d g
  for d in "${SHIP_DIRS[@]}"; do
    case "$f" in "$d"/*) echo ship; return;; esac
  done
  for g in "${SHIP_FILES[@]}"; do
    [ "$f" = "$g" ] && { echo ship; return; }
  done
  for g in "${PRIVATE_FILES[@]}"; do
    [ "$f" = "$g" ] && { echo private; return; }
  done
  for g in "${PRIVATE_GLOBS[@]}"; do
    case "$f" in $g) echo private; return;; esac
  done
  echo unclassified
}

SHIP=(); PRIVATE=(); UNCLASSIFIED=()
for f in "${ALL[@]}"; do
  case "$(classify "$f")" in
    ship) SHIP+=("$f");;
    private) PRIVATE+=("$f");;
    *) UNCLASSIFIED+=("$f");;
  esac
done

echo "SHIPS (${#SHIP[@]}):"
printf '  %s\n' "${SHIP[@]}"
echo
echo "STAYS PRIVATE (${#PRIVATE[@]}):"
# The copy has no private files, and bash 3.2 (macOS) fails on an empty
# "${PRIVATE[@]}" under set -u.
[ ${#PRIVATE[@]} -gt 0 ] && printf '  %s\n' "${PRIVATE[@]}"
echo
if [ ${#UNCLASSIFIED[@]} -gt 0 ]; then
  echo "FAIL: ${#UNCLASSIFIED[@]} file(s) in neither list. Sort them into"
  echo "  SHIP_* or PRIVATE_* at the top of this script before packaging:"
  printf '  %s\n' "${UNCLASSIFIED[@]}"
  exit 1
fi
echo "classification: every file sorted."

if [ "${1:-}" = "--check" ] || [ -z "${1:-}" ]; then
  [ -z "${1:-}" ] && echo "(no target given; classification only)"
  exit 0
fi

TARGET="$1"
if [ -e "$TARGET" ]; then
  echo "REFUSING TO RUN: $TARGET already exists."
  exit 1
fi

mkdir -p "$TARGET"
for f in "${SHIP[@]}"; do
  mkdir -p "$TARGET/$(dirname "$f")"
  cp -p "$f" "$TARGET/$f"
done
echo
echo "copied ${#SHIP[@]} file(s) to $TARGET"

# ---- sweep -----------------------------------------------------------
echo
if [ ! -f "$SWEEP_TERMS" ]; then
  echo "SWEEP SKIPPED: $SWEEP_TERMS not found here. The copy exists but has"
  echo "  NOT been checked for private terms. Not a pass."
  exit 1
fi
echo "sweep: LICENSE excluded (its copyright line names the author by design)"

# Verify the verifier: plant a known-bad file, prove the sweep fires on
# it, remove it. A sweep that has never failed proves nothing.
FIRST_TERM=$(grep -v -E '^\s*(#|$)' "$SWEEP_TERMS" | head -1)
if [ -z "$FIRST_TERM" ]; then
  echo "FAIL: $SWEEP_TERMS has no terms."
  exit 1
fi
PLANT="$TARGET/.sweep_selftest.tmp"
printf 'selftest %s selftest\n' "$(printf '%s' "$FIRST_TERM" | sed -E 's/[^A-Za-z0-9_ ]//g')" > "$PLANT"
if ! grep -r -i -l -w -E --exclude=LICENSE -- "$FIRST_TERM" "$TARGET" | grep -q "sweep_selftest"; then
  rm -f "$PLANT"
  echo "FAIL: sweep self-test did not fire on a planted term ($FIRST_TERM)."
  echo "  The sweep cannot be trusted; nothing below counts."
  exit 1
fi
rm -f "$PLANT"
echo "sweep self-test: fired on planted term, as required."

HITS=0
while IFS= read -r term; do
  case "$term" in ''|'#'*) continue;; esac
  out=$(grep -r -i -n -w -E --exclude=LICENSE -- "$term" "$TARGET")
  if [ -n "$out" ]; then
    HITS=$((HITS+1))
    echo
    echo "HIT on /$term/:"
    echo "$out" | sed 's/^/  /'
  fi
done < "$SWEEP_TERMS"

echo
if [ $HITS -gt 0 ]; then
  echo "FAIL: $HITS term(s) hit in the packaged copy. Fix the source, not"
  echo "  the copy, and rerun. The copy at $TARGET is NOT clean."
  exit 1
fi
NTERMS=$(grep -c -v -E '^\s*(#|$)' "$SWEEP_TERMS")
echo "sweep: $NTERMS term(s), zero hits in $TARGET (LICENSE excluded)."
echo "packaged."
