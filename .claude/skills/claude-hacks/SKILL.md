---
name: claude-hacks
description: Search for Claude Code productivity hacks, CLAUDE.md recipes, MCP server recommendations, prompt techniques, custom skills, and agentic workflow patterns. Curates them into an awesome-list style README.md in a target GitHub repo. Each run appends only net-new items rather than regenerating. Use when the user asks to update the Claude Code hacks list, curate Claude Code tips, or discover new Claude Code workflows.
argument-hint: "[repo:~/path/to/repo, optional — default: ~/claude-code-hacks]"
disable-model-invocation: true
allowed-tools: WebSearch, WebFetch, Bash, Read, Write
model: claude-opus-4-6
---

# Claude Code Productivity Hacks Curator

You are curating a living, awesome-list style collection of Claude Code productivity hacks, tips, CLAUDE.md recipes, MCP server recommendations, prompt techniques, and workflow patterns. Your audience is developers and technical practitioners who use Claude Code daily.

## Optional arguments
$ARGUMENTS

---

## Step 1: Resolve the target repo path

Parse the `repo:` value from `$ARGUMENTS`. If no `repo:` argument is present, default to `~/claude-code-hacks`.

Expand `~` to the full home directory path.

Check whether the directory exists:

```bash
test -d <REPO_PATH> && echo "exists" || echo "missing"
```

If missing, create and initialise it:

```bash
mkdir -p <REPO_PATH>
cd <REPO_PATH> && git init && git checkout -b main
```

Check whether `README.md` already exists:

```bash
test -f <REPO_PATH>/README.md && echo "exists" || echo "missing"
```

Record whether this is a **first run** (README does not exist) or an **append run** (README exists).

---

## Step 2: Extract known URLs from existing README

**First run only**: skip this step. The known-URL set is empty.

**Append run**: Read the existing `README.md` using the Read tool. Extract every URL from markdown link syntax into a deduplicated skip-list:

```bash
grep -oE '\(https?://[^)]+\)' <REPO_PATH>/README.md | tr -d '()' | sort -u
```

Hold this set in memory for the entire run. Any candidate item whose URL matches an entry in this set is discarded without further processing.

---

## Step 3: Search for new hacks and tips

Work through each of the 9 source categories defined in [sources.md](sources.md) **sequentially** — no parallel searches. For each category, run one WebSearch query. If the first query returns 3+ usable candidates, move on. Only run a second query if the first returns nothing useful.

For each candidate item:
1. Check its primary URL against the known-URL skip-list. If already present, discard immediately.
2. Assess signal quality: does this contain a concrete, actionable Claude Code tip? Discard news articles, product announcements without tips, and vague opinion pieces.
3. Only `WebFetch` a URL if the search snippet alone is insufficient to write the description. One fetch per item maximum.

**Cap at 4 strong candidates per category.** Stop collecting once you have enough. Quality over quantity.

Unlike the newsletter skill there is **no recency filter** — a CLAUDE.md recipe from two years ago is as valid as one from yesterday. The duplicate-URL check is the primary freshness gate.

---

## Step 4: Categorise and format new items

For each net-new item, assign it to exactly one of these 9 sections:

| Section slug | Assign when the item covers... |
|---|---|
| `setup-config` | Initial setup, model selection, global config, `.claude/` directory structure |
| `claude-md` | CLAUDE.md content, patterns, template snippets, memory instructions |
| `prompt-techniques` | Prompting strategies, system prompt patterns, conversation management |
| `mcp-servers` | MCP servers, MCP configuration, tool extensions |
| `custom-skills` | Slash commands, SKILL.md files, repeatable workflow patterns |
| `agentic-workflows` | Multi-step autonomous tasks, subagent patterns, orchestration |
| `ide-editor` | VS Code, Cursor, JetBrains, keyboard shortcuts, editor settings |
| `cicd` | GitHub Actions, scheduled runs, headless Claude Code, automation |
| `video-tutorials` | YouTube videos, screencasts, walkthroughs (URL must be a video link) |

Write each entry as a single markdown list item — awesome-list style:

```markdown
- [Title](URL) — one-sentence description of what the hack does and why it is useful.
```

Keep descriptions punchy and concrete. No multi-sentence summaries. No tags or dates.

---

## Step 5: Update the README

### First run

If `README.md` does not yet exist:

1. Read the initial template from [template.md](template.md)
2. Write it verbatim to `<REPO_PATH>/README.md` using the Write tool
3. Then proceed to the append logic below to insert all new items

### Append logic (all runs)

For each section that has one or more new items, insert the new list items after the HTML anchor comment for that section. Each section in the README contains an anchor comment of the form:

```html
<!-- claude-hacks: SECTION-SLUG -->
```

Use this Python inline script to append items to a section. Replace `SECTION_SLUG` and `NEW_ITEMS` with the actual values:

```bash
python3 - <<'PYEOF'
import re, sys

readme_path = '<REPO_PATH>/README.md'
with open(readme_path) as f:
    content = f.read()

anchor = '<!-- claude-hacks: SECTION_SLUG -->'
new_items = """NEW_ITEMS
"""

idx = content.find(anchor)
if idx == -1:
    print(f"Anchor not found: {anchor}", file=sys.stderr)
    sys.exit(1)

insert_at = idx + len(anchor)
# Find the next section boundary (--- or ## heading)
boundary = re.search(r'\n(---|##)', content[insert_at:])
if boundary:
    insert_at += boundary.start()

content = content[:insert_at] + '\n' + new_items + content[insert_at:]
with open(readme_path, 'w') as f:
    f.write(content)
print("OK")
PYEOF
```

Run this script once per section that has new items. Build up the full updated file across all sections before moving to Step 6.

After all sections are updated, refresh the "Last updated" date in the README footer:

```bash
sed -i.bak "s/Last updated: [0-9-]*/Last updated: $(date +%Y-%m-%d)/" <REPO_PATH>/README.md && rm <REPO_PATH>/README.md.bak
```

---

## Step 6: Commit and push

Count the total number of new items added across all sections. Then:

```bash
cd <REPO_PATH>
git add README.md
git commit -m "Add N Claude Code hacks — $(date -u +%Y-%m-%d)"
git push
```

If `git push` fails because no remote is configured, print:

```
No remote configured. To publish this repo:
  gh repo create claude-code-hacks --public --push --source=<REPO_PATH>
or:
  git remote add origin https://github.com/USERNAME/claude-code-hacks.git
  git push -u origin main
```

---

## Step 7: Confirm

Print a single confirmation line:

```
README updated → <REPO_PATH>/README.md (N new items across M sections, pushed)
```

If nothing new was found (all candidates were duplicates or failed quality filter):

```
README unchanged — no new items found this run.
```
