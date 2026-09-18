#!/bin/bash
# A stand-in for `claude -p` used by tests/weekly_test.sh. It logs its
# arguments, writes a post named from the prompt's date: argument and a triage
# file, and prints a result like --output-format json does.
#
# FAKE_LOG   file to append one line of arguments to per call
# FAKE_MODE  clean (default), failing, secondary, wrongdate, notriage, readme or noload
# FAKE_TRIAGE  file to copy in as the triage file (default: one new item)
set -fuo pipefail

printf '%s\n' "$*" >>"${FAKE_LOG:-/dev/null}"

prompt=
while [ $# -gt 0 ]; do
  case $1 in
  -p) prompt=$2; shift ;;
  esac
  shift
done

arg() { # the value of key:<value> in the prompt
  local word
  for word in $prompt; do
    case $word in "$1":*) echo "${word#"$1":}" ;; esac
  done
}

if [ "$prompt" = "say ok" ]; then
  echo '{"is_error":false,"num_turns":1,"result":"ok","total_cost_usd":0}'
  exit 0
fi

mode=${FAKE_MODE:-clean}
if [ "$mode" = noload ]; then
  echo '{"is_error":false,"num_turns":0,"result":"Unknown command: /newsletter:newsletter-ai","total_cost_usd":0}'
  exit 0
fi

web=$(arg web)
date=$(arg date)
week=$(arg week)
triage=$(arg triage)
triage=${triage:-$PWD/.newsletter}

source_url="https://example.com/articles/fake-story-$date"
[ "$mode" = failing ] && source_url="https://example.com/"
# An outlet on the checker's SECONDARY list: a warning, not a hold.
[ "$mode" = secondary ] && source_url="https://www.theregister.com/articles/fake-story-$date"
name=$date
[ "$mode" = wrongdate ] && name=2020-01-03

mkdir -p "$web/content/posts"
cat >"$web/content/posts/$name.md" <<EOF
---
title: "Agentic AI & LLM Weekly — $week"
date: ${date}T09:00:00Z
draft: false
---

# Agentic AI & LLM Weekly
**$week**

### A story
\`[Community]\`

Two sentences.

[Source: [Example](${source_url})]
EOF

[ "$mode" = readme ] && echo "edited by the model" >>README.md

mkdir -p "$triage"
if [ "$mode" = notriage ]; then # the model wrote the post and skipped step 5
  :
elif [ -n "${FAKE_TRIAGE:-}" ]; then
  cp "$FAKE_TRIAGE" "$triage/triage.md"
else
  echo "- [A story](https://example.com/triage/$date): matches ai" >"$triage/triage.md"
fi

echo '{"is_error":false,"num_turns":3,"total_cost_usd":0}'
