# newsletter-ai — Project Guidelines

This repo contains the `/newsletter-ai` Claude Code skill.

## Running /newsletter-ai

These rules override global Subagent Strategy and Task Management when running `/newsletter-ai`.

- **No parallel subagents for gathering** — search all 11 categories sequentially in the main session.
- **WebSearch before WebFetch** — use snippets to identify stories; only fetch when snippet lacks enough detail. One fetch per story maximum.
- **One query per category** — if first query returns 3+ usable results, move on. Skip sections with nothing newsworthy.
- **No intermediate output** — output only the finished newsletter, then the vault confirmation line.
- **Cap at 4 items per category.**
- **Check canvas existence before writing** — run `test -f <vault>/canvas/newsletter-structure.canvas` before reading canvas files.

---

## Publishing a new issue

Single command, from a Claude Code session in this repo:

```text
/newsletter-ai web:./site
```

End to end this:

1. Gathers and writes the issue.
2. Writes `site/content/posts/YYYY-MM-DD.md` with Hugo + PaperMod frontmatter.
3. Writes the Obsidian vault copies (issue note, article notes, etc.).
4. `git add` + `git commit -m "Newsletter YYYY-MM-DD"` + `git push`.
5. Cloudflare Pages auto-deploys → https://newsletter-ai-skill.pages.dev/ (~30s).

The commit/push is **Step 6c** in `.claude/skills/newsletter-ai/SKILL.md`. Uses your Claude Code subscription quota — no Anthropic API credits consumed.

### Pre-flight

- On `main`, working tree otherwise clean.
- `baseURL` in `site/hugo.toml` matches the live Pages URL.
- The skill is synced (`~/.claude/skills/newsletter-ai/` up to date — see *Updating the skill* below).

### Recovery

If `git push` fails (remote diverged), the local commit still exists:

```bash
git pull --rebase && git push
```

---

## Updating the skill

Files live in two places that must stay in sync:

| Location | Purpose |
|---|---|
| `.claude/skills/newsletter-ai/` | Repo source of truth — version-controlled |
| `~/.claude/skills/newsletter-ai/` | Live global install — what Claude Code uses |

After editing any skill file, sync it to the global location:

```bash
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

Target for a full 11-category run: **~22 WebSearch + 5–10 selective WebFetch** = well within a session's budget.
