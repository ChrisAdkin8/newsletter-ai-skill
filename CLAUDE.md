# newsletter-ai — Project Guidelines

This repo contains the `/newsletter-ai` Claude Code skill. Token efficiency rules for running it live in `~/.claude/CLAUDE.md` under **Newsletter Skill** and apply globally.

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
