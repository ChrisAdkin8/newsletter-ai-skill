#!/bin/bash
# weekly.sh: launchd runs the installed copy of this twice a day, and it
# publishes at most one issue per issue week (Friday to Thursday).
#
# The model runs with no shell and no ~/notes access. This script owns git:
# the post is committed and pushed only if scripts/check_issue.py passes, and
# only then is the model's triage file filtered into ~/notes/inbox.
# Design: docs/specs/2026-09-13-weekly-local-publishing.md.
#
# PROBE=1 sends "say ok" instead of the skill and stops after checking the
# result, without touching git. Use it to vet a new pinned CLI under launchd.
#
# Overrides, for tests: NEWSLETTER_REPO, NEWSLETTER_LOG, NOTES_DIR,
# CLAUDE_BIN and NOTIFY_CMD.
set -uo pipefail

REPO=${NEWSLETTER_REPO:-$HOME/code/github.com/newsletter-ai-skill}
LOG=${NEWSLETTER_LOG:-$HOME/Library/Logs/newsletter}
NOTES_DIR=${NOTES_DIR:-$HOME/notes}
CLAUDE_BIN=${CLAUDE_BIN:-$HOME/.local/share/newsletter-ai/claude}
PROBE=${PROBE:-}

DATE=$(date +%F)
WEEK=$(date -v-4d +%G-W%V) # Friday..Thursday map to the same issue week
TRIAGE_MAX=5

mkdir -p "$LOG"

notify() {
  echo "$(date '+%F %T') $1"
  if [ -n "${NOTIFY_CMD:-}" ]; then
    "$NOTIFY_CMD" "$1"
  else
    osascript -e 'on run argv' -e 'display notification (item 1 of argv) with title "Newsletter"' \
      -e 'end run' "$1" >/dev/null
  fi
}

fail() {
  notify "$1"
  exit 1
}

# The ISO issue week of a YYYY-MM-DD date, by the same rule as $WEEK.
week_of() {
  date -j -v-4d -f %F "$1" +%G-W%V
}

# Succeeds if main is exactly one unpushed "Newsletter <date>" commit that adds
# one post, i.e. an earlier run committed but failed to push. Prints the date.
unpushed_issue() {
  local subject d
  [ "$(git rev-list --count origin/main..main)" = 1 ] || return 1
  subject=$(git log -1 --format=%s main)
  [[ $subject =~ ^Newsletter\ ([0-9]{4}-[0-9]{2}-[0-9]{2})$ ]] || return 1
  d=${BASH_REMATCH[1]}
  [ "$(git diff-tree --no-commit-id --name-status -r main)" = "$(printf 'A\tsite/content/posts/%s.md' "$d")" ] ||
    return 1
  echo "$d"
}

# Step 11: filter the model's triage file into the notes inbox. Keeps only
# one-line items of the form "- [title](url): reason", drops URLs already
# anywhere in the notes, and appends the command itself.
move_triage() {
  local triage="$REPO/.newsletter/triage.md"
  local inbox="$NOTES_DIR/inbox/$DATE-newsletter-triage.md"
  local item='^- \[[^]]+\]\((https?://[A-Za-z0-9._~:/?#@!&+,;=%-]+)\): .+$'
  local line url tmp
  KEPT=0 DROPPED=0 KNOWN=0
  if [ ! -f "$triage" ]; then
    TRIAGE_NOTE="no triage file"
    return
  fi
  if [ -e "$inbox" ]; then
    TRIAGE_NOTE="$inbox already exists, not overwritten"
    return
  fi
  tmp=$(mktemp)
  while IFS= read -r line || [ -n "$line" ]; do
    line=${line%$'\r'}
    [ -z "${line// /}" ] && continue
    if [ "${#line}" -gt 300 ] || [[ $line == *'`'* ]] || ! [[ $line =~ $item ]] ||
      [ "$KEPT" -ge "$TRIAGE_MAX" ]; then
      DROPPED=$((DROPPED + 1))
      continue
    fi
    url=${BASH_REMATCH[1]}
    if grep -rqF --exclude-dir=.git -e "$url" "$NOTES_DIR" "$tmp" 2>/dev/null; then
      KNOWN=$((KNOWN + 1))
      continue
    fi
    printf '%s `/research quick %s`\n' "$line" "$url" >>"$tmp"
    KEPT=$((KEPT + 1))
  done <"$triage"
  mkdir -p "$NOTES_DIR/inbox"
  {
    printf '# Newsletter triage, %s (%s)\n\n' "$DATE" "$WEEK"
    if [ "$KEPT" -gt 0 ]; then cat "$tmp"; else echo "Nothing new this week."; fi
  } >"$inbox"
  rm -f "$tmp"
  TRIAGE_NOTE="triage: $KEPT kept, $KNOWN already in notes, $DROPPED dropped for format"
}

# Step 1: already published this week, or offline. Any HTTP response counts as
# online; the API host answers 404 at its root, so curl -f would always fail.
if [ -z "$PROBE" ] && [ "$(cat "$LOG/last-ok" 2>/dev/null)" = "$WEEK" ]; then
  exit 0
fi
curl -sI --max-time 10 -o /dev/null https://api.anthropic.com || exit 0

cd "$REPO" || fail "repo not found: $REPO"

retry=
if [ -z "$PROBE" ]; then
  # Step 2: warnings that don't stop the run.
  [ -e "$HOME/.claude/skills/newsletter-ai" ] &&
    notify "\$HOME/.claude/skills/newsletter-ai exists; runs use the repo's copy"
  cmp -s "$REPO/scripts/weekly.sh" "$0" ||
    notify "scripts/weekly.sh differs from the installed copy; re-run scripts/install-agent.sh"

  # Step 3: on main, clean. A held issue blocks later slots until dealt with.
  [ "$(git symbolic-ref --short -q HEAD)" = main ] || fail "not on main; nothing run"
  [ -z "$(git status --porcelain)" ] || fail "working tree not clean (a held issue?); nothing run"

  # Step 4: retry a failed push, refuse other local commits, else fast-forward.
  git fetch -q origin || fail "git fetch failed"
  if [ "$(git rev-list --count origin/main..main)" != 0 ]; then
    retry=$(unpushed_issue) || fail "main has unpushed commits that aren't a newsletter; nothing run"
  else
    git pull --ff-only -q || fail "git pull --ff-only failed"
  fi
fi

if [ -n "$retry" ]; then
  DATE=$retry
  WEEK=$(week_of "$DATE")
  OUT="$LOG/$WEEK.json"
  git push -q origin main || fail "push of Newsletter $DATE failed again; the next slot retries it"
else
  # Step 5: fresh scratch dir for the model. Nothing from ~/notes goes in. A
  # probe leaves it alone, so it can't wipe a held issue's triage file.
  if [ -n "$PROBE" ]; then
    PROMPT="say ok"
    OUT="$LOG/probe.json"
  else
    rm -rf "$REPO/.newsletter" && mkdir -p "$REPO/.newsletter" &&
      cp "$REPO/scripts/interests.txt" "$REPO/.newsletter/" || fail "couldn't prepare .newsletter/"
    PROMPT="/newsletter:newsletter-ai web:$REPO/site date:$DATE week:$WEEK triage:$REPO/.newsletter"
    OUT="$LOG/$WEEK.json"
  fi

  # Step 6: run the pinned CLI, confined to the repo, with no shell and no MCP.
  CLAUDE_CODE_OAUTH_TOKEN=$(security find-generic-password -s claude-newsletter -w) ||
    fail "token missing: no claude-newsletter item in the Keychain"
  export CLAUDE_CODE_OAUTH_TOKEN
  export SHELL=/bin/sh DISABLE_AUTOUPDATER=1
  caffeinate -i perl -e 'alarm shift; exec @ARGV' 3600 \
    "$CLAUDE_BIN" -p "$PROMPT" --model sonnet --restricted --plugin-dir "$REPO/.claude" \
    --strict-mcp-config --permission-mode dontAsk \
    --tools "WebSearch,WebFetch,Read,Write,Edit,Glob,Grep" \
    --allowedTools "WebSearch WebFetch Read(./**) Glob Grep Edit(./site/content/posts/**) Edit(./.newsletter/**)" \
    --max-budget-usd 10 --output-format json </dev/null >"$OUT"
  rc=$?

  # Step 7: a skill that didn't load exits 0 with no turns.
  if [ "$rc" -ne 0 ] || ! jq -e '.is_error == false and (.num_turns // 0) > 0' "$OUT" >/dev/null 2>&1; then
    fail "run failed (rc=$rc): $OUT"
  fi
  if [ -n "$PROBE" ]; then
    notify "probe ok: $(jq -r '.result // ""' "$OUT" | head -c 80)"
    exit 0
  fi

  # Step 8: the only change allowed is the new post, and it must pass the checker.
  POST="site/content/posts/$DATE.md"
  [ "$(git status --porcelain --untracked-files=all)" = "?? $POST" ] ||
    fail "held: expected only a new $POST; see git status"
  python3 scripts/check_issue.py "$POST" --week "$WEEK" >"$LOG/$WEEK.check" 2>&1 ||
    fail "held: $POST failed the checker; see $LOG/$WEEK.check"

  # Step 9: publish. A failed push is retried by step 4 on the next slot.
  git add "$POST" && git commit -qm "Newsletter $DATE" || fail "git commit failed"
  git push -q origin main || fail "push failed; the next slot retries it"
fi

# Step 10.
echo "$WEEK" >"$LOG/last-ok"

# Step 11: only published issues leave a triage note.
move_triage

# Step 12.
notify "Published $WEEK (~\$$(jq -r '.total_cost_usd // "?"' "$OUT" 2>/dev/null)); $TRIAGE_NOTE"
