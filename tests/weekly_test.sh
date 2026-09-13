#!/bin/bash
# Offline test of scripts/weekly.sh. Each scenario builds a repo from this
# working tree, with a bare remote, and runs the wrapper against
# tests/fake-claude.sh, with curl, security and notifications stubbed.
set -uo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
DATE=$(date +%F)
WEEK=$(date -v-4d +%G-W%V)
POST=site/content/posts/$DATE.md
PASS=0
FAILS=0
TMPROOT=$(mktemp -d)
trap 'rm -rf "$TMPROOT"' EXIT

export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.com
export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.com
export GIT_CONFIG_NOSYSTEM=1

check() { # description, then a command that must succeed
  local what=$1
  shift
  if "$@"; then
    PASS=$((PASS + 1))
  else
    FAILS=$((FAILS + 1))
    echo "FAIL [$SCENARIO] $what"
  fi
}

setup() {
  SCENARIO=$1
  T=$(mktemp -d "$TMPROOT/XXXXXX")
  mkdir -p "$T/seed/site/content" "$T/bin" "$T/home" "$T/log" "$T/notes"
  cp -R "$ROOT/scripts" "$ROOT/.claude" "$ROOT/.gitignore" "$ROOT/README.md" "$T/seed/"
  cp -R "$ROOT/site/content/posts" "$T/seed/site/content/"
  git -C "$T/seed" init -q -b main
  git -C "$T/seed" add -A
  git -C "$T/seed" commit -qm seed
  git clone -q --bare "$T/seed" "$T/remote.git"
  git clone -q "$T/remote.git" "$T/work"

  printf '#!/bin/sh\nexit "${FAKE_CURL_RC:-0}"\n' >"$T/bin/curl"
  printf '#!/bin/sh\necho fake-token\n' >"$T/bin/security"
  printf '#!/bin/sh\necho "$1" >>"%s/notify.log"\n' "$T" >"$T/bin/notify"
  chmod +x "$T/bin/"*
}

run_weekly() { # extra VAR=value settings for the run
  env PATH="$T/bin:$PATH" HOME="$T/home" NEWSLETTER_REPO="$T/work" NEWSLETTER_LOG="$T/log" \
    NOTES_DIR="$T/notes" CLAUDE_BIN="$ROOT/tests/fake-claude.sh" NOTIFY_CMD="$T/bin/notify" \
    FAKE_LOG="$T/fake.log" "$@" bash "$T/work/scripts/weekly.sh" >>"$T/out.log" 2>&1
  RC=$?
}

remote_commits() { git --git-dir="$T/remote.git" rev-list --count main; }
remote_added() { git --git-dir="$T/remote.git" diff-tree --no-commit-id --name-status -r main; }
calls() { if [ -f "$T/fake.log" ]; then wc -l <"$T/fake.log" | tr -d ' '; else echo 0; fi; }
notified() { grep -q "$1" "$T/notify.log" 2>/dev/null; }
last_ok() { cat "$T/log/last-ok" 2>/dev/null; }
inbox() { echo "$T/notes/inbox/$DATE-newsletter-triage.md"; }
has() { grep -qF -e "$2" "$1" 2>/dev/null; }
lacks() { ! grep -qF -e "$2" "$1" 2>/dev/null; }
eq() { [ "$1" = "$2" ]; }
not() { ! "$@"; }

# --- A clean post is published, and triage lands in the inbox.
setup clean
mkdir -p "$T/notes/research"
echo "See https://example.com/known for details." >"$T/notes/research/old.md"
cat >"$T/triage.in" <<'EOF'
- [Known](https://example.com/known): already in the notes
- [New thing](https://example.com/new): matches kubernetes
not an item
- [Has `code`](https://example.com/code): matches ai
EOF
before=$(remote_commits)
run_weekly FAKE_TRIAGE="$T/triage.in"
check "exits 0" eq "$RC" 0
check "remote gains one commit" eq "$(remote_commits)" "$((before + 1))"
check "the commit adds only the post" eq "$(remote_added)" "$(printf 'A\t%s' "$POST")"
check "last-ok holds the week" eq "$(last_ok)" "$WEEK"
check "prompt names the plugin skill" has "$T/fake.log" "-p /newsletter:newsletter-ai "
check "flags include --plugin-dir" has "$T/fake.log" "--plugin-dir $T/work/.claude"
check "prompt has date:" has "$T/fake.log" "date:$DATE"
check "prompt has week:" has "$T/fake.log" "week:$WEEK"
check "a URL already in the notes is dropped" lacks "$(inbox)" "example.com/known"
check "a new URL is kept, with the command appended" has "$(inbox)" \
  '- [New thing](https://example.com/new): matches kubernetes `/research quick https://example.com/new`'
check "a line not in the format is dropped" lacks "$(inbox)" "not an item"
check "a line with backticks is dropped" lacks "$(inbox)" "example.com/code"
check "notifies the publish" notified "Published $WEEK"

run_weekly
check "second run exits 0" eq "$RC" 0
check "second run makes no commit" eq "$(remote_commits)" "$((before + 1))"
check "second run doesn't call claude" eq "$(calls)" 1

# --- An existing inbox file isn't overwritten.
setup inbox-exists
mkdir -p "$T/notes/inbox"
echo "mine" >"$(inbox)"
run_weekly
check "exits 0" eq "$RC" 0
check "inbox file untouched" eq "$(cat "$(inbox)")" "mine"

# --- A failing post is held.
setup failing
before=$(remote_commits)
run_weekly FAKE_MODE=failing
check "exits 1" eq "$RC" 1
check "nothing pushed" eq "$(remote_commits)" "$before"
check "post stays untracked" eq "$(git -C "$T/work" status --porcelain)" "?? $POST"
check "notifies held" notified "held"
check "no inbox file" test ! -e "$(inbox)"
check "no last-ok" eq "$(last_ok)" ""
run_weekly
check "a held issue blocks the next slot" eq "$RC" 1
check "the next slot doesn't call claude" eq "$(calls)" 1

# --- A post under the wrong date is held.
setup wrongdate
before=$(remote_commits)
run_weekly FAKE_MODE=wrongdate
check "exits 1" eq "$RC" 1
check "nothing pushed" eq "$(remote_commits)" "$before"
check "notifies held" notified "held"

# --- A post plus an edit elsewhere is held.
setup readme
before=$(remote_commits)
run_weekly FAKE_MODE=readme
check "exits 1" eq "$RC" 1
check "nothing pushed" eq "$(remote_commits)" "$before"
check "notifies held" notified "held"

# --- A skill that didn't load is a failed run, not a held issue.
setup noload
run_weekly FAKE_MODE=noload
check "exits 1" eq "$RC" 1
check "notifies a failed run" notified "run failed"
check "doesn't say held" not notified "held"

# --- A failed push is retried on the next slot without calling claude.
setup push-retry
before=$(remote_commits)
printf '#!/bin/sh\nexit 1\n' >"$T/remote.git/hooks/pre-receive"
chmod +x "$T/remote.git/hooks/pre-receive"
run_weekly
check "exits 1" eq "$RC" 1
check "nothing pushed" eq "$(remote_commits)" "$before"
check "the commit stays local" eq "$(git -C "$T/work" rev-list --count origin/main..main)" 1
check "no last-ok" eq "$(last_ok)" ""
check "notifies the failed push" notified "push failed"
rm "$T/remote.git/hooks/pre-receive"
run_weekly
check "retry exits 0" eq "$RC" 0
check "retry pushes the commit" eq "$(remote_commits)" "$((before + 1))"
check "retry doesn't call claude" eq "$(calls)" 1
check "retry writes last-ok" eq "$(last_ok)" "$WEEK"
check "retry moves triage" test -f "$(inbox)"

# --- An unrelated unpushed commit stops the run.
setup unrelated-commit
before=$(remote_commits)
echo "local edit" >>"$T/work/README.md"
git -C "$T/work" commit -qam "Local edit"
run_weekly
check "exits 1" eq "$RC" 1
check "nothing pushed" eq "$(remote_commits)" "$before"
check "doesn't call claude" eq "$(calls)" 0

# --- Offline: skip the slot quietly.
setup offline
run_weekly FAKE_CURL_RC=7
check "exits 0" eq "$RC" 0
check "doesn't call claude" eq "$(calls)" 0

# --- PROBE=1 runs "say ok" and leaves git and last-ok alone.
setup probe
before=$(remote_commits)
run_weekly PROBE=1
check "exits 0" eq "$RC" 0
check "prompt is say ok" has "$T/fake.log" "-p say ok "
check "no commit" eq "$(git -C "$T/work" rev-list --count HEAD)" "$before"
check "no last-ok" eq "$(last_ok)" ""
check "notifies the probe" notified "probe ok"

echo "weekly_test: $PASS passed, $FAILS failed"
[ "$FAILS" -eq 0 ]
