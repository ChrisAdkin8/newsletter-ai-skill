#!/bin/bash
# install-agent.sh: install the launchd agent that runs scripts/weekly.sh.
#
# Copies the pinned CLI and the wrapper to ~/.local/share/newsletter-ai, so
# launchd never runs anything the model could have written in the repo, then
# renders the plist and (re)loads it. Re-run it after editing scripts/weekly.sh;
# the wrapper notifies on every slot until you do.
#
# PROBE=1 scripts/install-agent.sh sets PROBE=1 in the agent's environment, so
# the next kickstart only runs "say ok". Running it again without PROBE clears it.
set -euo pipefail

# Vetted by spikes 1 and 2. Before bumping it, re-run spike 1's probe and a
# PROBE=1 kickstart (docs/specs/2026-09-13-weekly-local-publishing.md).
CLAUDE_PIN=2.1.270

REPO=$(cd "$(dirname "$0")/.." && pwd)
DEST=$HOME/.local/share/newsletter-ai
LABEL=local.newsletter-ai.weekly
PLIST=$HOME/Library/LaunchAgents/$LABEL.plist
PIN_SRC=$HOME/.local/share/claude/versions/$CLAUDE_PIN
DOMAIN=gui/$(id -u)

if ! security find-generic-password -s claude-newsletter >/dev/null 2>&1; then
  cat <<'EOF'
There's no claude-newsletter item in the Keychain. Create one, then re-run this:

  claude setup-token
  security add-generic-password -s claude-newsletter -a "$USER" -w

-w comes last so that security prompts for the token rather than taking it
on the command line.
EOF
  exit 1
fi

[ -x "$PIN_SRC" ] || {
  echo "The pinned CLI $PIN_SRC isn't there. Vet another version and update CLAUDE_PIN." >&2
  exit 1
}

mkdir -p "$DEST" "$HOME/Library/Logs/newsletter" "$HOME/Library/LaunchAgents"
cmp -s "$PIN_SRC" "$DEST/claude" || install -m 755 "$PIN_SRC" "$DEST/claude"
install -m 755 "$REPO/scripts/weekly.sh" "$DEST/weekly.sh"
DISABLE_AUTOUPDATER=1 "$DEST/claude" --version | grep -qF "$CLAUDE_PIN" || {
  echo "$DEST/claude doesn't report version $CLAUDE_PIN." >&2
  exit 1
}

extra_env=
[ -n "${PROBE:-}" ] && extra_env='<key>PROBE</key><string>1</string>'
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
sed -e "s|@HOME@|$HOME|g" -e "s|@REPO@|$REPO|g" -e "s|@EXTRA_ENV@|$extra_env|" \
  "$REPO/scripts/$LABEL.plist.in" >"$tmp"
plutil -lint -s "$tmp"
install -m 644 "$tmp" "$PLIST"

launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
for _ in 1 2 3 4 5; do # bootout can take a moment to finish
  launchctl bootstrap "$DOMAIN" "$PLIST" 2>/dev/null && break
  sleep 1
done
launchctl print "$DOMAIN/$LABEL" >/dev/null

echo "Loaded $LABEL (CLI $CLAUDE_PIN${PROBE:+, PROBE=1}). Runs daily at 09:07 and 18:07."
echo "Run it now: launchctl kickstart -k $DOMAIN/$LABEL"
