#!/usr/bin/env bash
# STATUS: reusable
#
# Bundled with .claude/skills/seed-mission -- scaffolds a new parallel
# mission repo: git init in the order that is safe inside a cloud-synced
# folder, a .gitignore that keeps sync conflict artifacts out of git, and
# a MISSION_NOTES.md stub. See ../SKILL.md for when to use this and what
# happens after it runs.
#
# Usage: ./seed_mission.sh <path-to-new-repo> "<one-line mission summary>"

# ---------------------------------------------------------------------------
# CONFIGURE BEFORE FIRST USE IN A PROJECT
#
# GIT_MACHINE_MARKER: a file that exists ONLY on the one machine designated
# to do git for this project. Create it there by hand, once, e.g.:
#     touch ~/.PROJECT_git_machine
# and set the variable below to match. The guard exists because git
# metadata (.git) inside a folder synced by a file-sync service cannot be
# shared across two machines without corrupting one of them: the sync
# layer deconflicts concurrent internal-file changes by renaming, and a
# renamed ref or object file is a silently broken repository. So exactly
# one machine does git, and every git-writing script refuses elsewhere.
GIT_MACHINE_MARKER="$HOME/.PROJECT_git_machine"   # <-- set for your project
# ---------------------------------------------------------------------------

# ORDERING, the load-bearing part of this script:
#
# This script marks the new repo's .git as sync-ignored IMMEDIATELY after
# git init, before it can ever sync anywhere. That is the safe order for a
# repo that has NEVER synced: the machine creating it keeps its copy by
# ignoring first, and there is no other copy to lose.
#
# It is the OPPOSITE of the safe order for a repo that is ALREADY syncing
# between machines. Most sync services treat "ignore this folder" as
# "remove it from the server and from every other device" -- so for an
# already-synced repo the ignore must be applied on the OTHER machine
# first, or applying it here deletes that machine's copy. Do not confuse
# the two orders; confusing them is how a live repo gets deleted from a
# machine you are not sitting at.
#
# The ignore command below is Dropbox-on-macOS specific
# (xattr -w com.dropbox.ignored). Other sync providers need their own
# equivalent; the ORDERING principle above is the portable part, the
# command is not. If your provider has no per-folder ignore mechanism at
# all, do not keep .git inside the synced tree -- put the repo elsewhere.

set -uo pipefail

if [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
  echo "Usage: $0 <path-to-new-repo> \"<one-line mission summary>\""
  exit 1
fi

NEW_REPO="$1"
SUMMARY="$2"

if [ ! -f "$GIT_MACHINE_MARKER" ]; then
  echo "REFUSING TO RUN: this is not the designated git machine."
  echo "  Every git-writing script in this project refuses without"
  echo "  $GIT_MACHINE_MARKER; this one does not either. See the"
  echo "  configuration block at the top of this script."
  exit 1
fi

# OPTIONAL: some sandboxed or bridged environments mount the synced folder
# but cannot unlink files, which makes git operations that rewrite .git
# contents unsafe there. If your setup includes such an environment,
# uncomment and adapt the path test below so the script refuses inside it.
# case "$(pwd)" in
#   /sessions/*)
#     echo "REFUSING TO RUN: this environment cannot unlink files."
#     echo "  Run git operations from the primary environment instead."
#     exit 1
#     ;;
# esac

if [ -e "$NEW_REPO" ]; then
  echo "REFUSING TO RUN: $NEW_REPO already exists."
  exit 1
fi

mkdir -p "$NEW_REPO"
cd "$NEW_REPO"
git init -q

# Ignore-then-verify. See the ORDERING comment above: this must happen
# before the new .git has ever synced, and it does -- git init was the
# previous command.
xattr -w com.dropbox.ignored 1 .git 2>/dev/null
v=$(xattr -p com.dropbox.ignored .git 2>/dev/null)
echo "  .git ignore-verify=${v:-FAILED}"
if [ "${v:-}" != "1" ]; then
  echo
  echo "WARNING: could not verify the sync-ignore flag was set on .git."
  echo "  Do NOT let this repo sync to another machine until this is"
  echo "  fixed. Set it by hand and re-verify:"
  echo "    xattr -w com.dropbox.ignored 1 $(pwd)/.git"
  echo "    xattr -p com.dropbox.ignored $(pwd)/.git"
fi

cat > .gitignore <<'GITIGNORE'
__pycache__/
*.pyc
*.tmp

.DS_Store

.ipynb_checkpoints/
.virtual_documents/

# Cloud-sync collision artifacts -- never commit these, they are sync
# accidents, not files anyone made on purpose. BOTH patterns are needed
# because a sync service deconflicts at two levels: renamed FILE copies
# ("foo (conflicted copy ...).py") and renamed DIRECTORY copies
# (".git 2/" -- a second, divergent git metadata directory sitting next
# to the real one, which is exactly the corruption the git-machine guard
# exists to prevent). "conflicted copy" is Dropbox's spelling; adapt the
# first pattern to your provider's conflict-rename convention if it
# differs. If your project's checks/ suite has a repo-hygiene check for
# these patterns, it will catch one going missing later.
*conflicted copy*
.git [0-9]*
GITIGNORE

cat > MISSION_NOTES.md <<EOF
# Mission notes -- $(basename "$NEW_REPO")

Write findings, decisions, and open questions here as you work, as they
happen -- not reconstructed at the end of a session. Lists, not
paragraphs. See \`CLAUDE.md\` in this directory for this mission's
seeded context, and the project root's standing-rules file for the
notes format this project uses; read both first.

Seeded: $SUMMARY

(Nothing else logged yet -- this file was just scaffolded.)
EOF

echo
echo "Scaffolded $NEW_REPO (git initialized, .gitignore + MISSION_NOTES.md"
echo "stub written)."
echo "CLAUDE.md NOT written by this script -- see seed-mission/SKILL.md's"
echo "'After the script runs' section for what happens next."
