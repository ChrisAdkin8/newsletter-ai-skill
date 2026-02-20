# newsletter-ai — Project Guidelines

This repo contains the `/newsletter-ai` Claude Code skill. The main task when working here is either running the skill or modifying it.

---

## Running /newsletter-ai — token efficiency rules

### 1. Never use parallel subagents for gathering

Run all 11 category searches **sequentially in the main session**. Do not launch background agents or parallel subagents to gather content.

Each subagent runs in isolated context, consumes its own web search quota independently, and cannot share results back efficiently. Parallel subagents burn the daily search quota across all agents simultaneously — the result is every agent hitting the rate limit while producing nothing. One sequential session is far cheaper.

### 2. WebSearch before WebFetch

`WebSearch` returns short snippets (low token cost). `WebFetch` returns a full page (can be 10,000–50,000 tokens).

- Use `WebSearch` to identify candidate stories across all categories
- Only `WebFetch` a URL when the search snippet is insufficient to write the 2–4 sentence summary
- Maximum one `WebFetch` per story — do not fetch multiple coverage pieces for the same event

### 3. One query per category — then move on

Issue one broad search query per category. If it returns 3+ usable results, stop and move on. Do not retry with rephrased queries if the first returns relevant results. If a category genuinely has nothing newsworthy, omit the section rather than exhausting queries on it.

### 4. No intermediate output

Do not narrate search steps, describe what you found, or produce working notes. The only output is:
1. The finished newsletter (Steps 1–4)
2. The vault confirmation line (Step 5)

No task lists, no progress updates, no intermediate summaries.

### 5. Cap collection at 4 items per category

Once you have 3–4 strong candidates for a category, stop searching it. Collecting more than needed wastes tokens in evaluation and writing.

### 6. Check before writing canvas files

The canvas mindmaps (`newsletter-structure.canvas`, `sources.canvas`) are large static JSON files (~5 KB each). On every run after the first, they already exist in the vault and must not be re-read into context.

Before reading and writing either canvas file, check existence first:

```bash
test -f ~/Obsidian/AI-News/canvas/newsletter-structure.canvas && echo "exists"
```

Only read the file from the skill directory if the `test` confirms it is absent from the vault.

---

## Updating the skill

Files live in two places that must stay in sync:

| Location | Purpose |
|---|---|
| `.claude/skills/newsletter-ai/` | Repo source of truth — version-controlled |
| `~/.claude/skills/newsletter-ai/` | Live global install — what Claude Code actually uses |

After editing any skill file, sync it:

```bash
cp .claude/skills/newsletter-ai/SKILL.md ~/.claude/skills/newsletter-ai/SKILL.md
# or for all files at once:
cp -r .claude/skills/newsletter-ai/ ~/.claude/skills/newsletter-ai/
```

Then commit the repo change.

---

## Token cost reference

| Operation | Approximate token cost |
|---|---|
| `WebSearch` (1 query, ~10 results) | ~500–1,000 tokens |
| `WebFetch` (full article) | 5,000–30,000 tokens |
| Reading `sources.md` | ~3,000 tokens (loaded once via SKILL.md reference) |
| Reading a canvas file | ~1,500 tokens |
| Final newsletter output | ~3,000–5,000 tokens |

Target for a full 11-category run: **~22 WebSearch calls + 5–10 selective WebFetch calls** = well within a session's budget.
