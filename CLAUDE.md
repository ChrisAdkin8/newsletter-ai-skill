# newsletter-ai — Project Guidelines

This repo contains the `/newsletter-ai` Claude Code skill.

## Running /newsletter-ai

The run rules live in the skill itself (`.claude/skills/newsletter-ai/SKILL.md`, "Run rules"), and override global Subagent Strategy and Task Management when running `/newsletter-ai`.

---

## Publishing a new issue

A launchd agent publishes one issue a week; see [`docs/customising.md` → Scheduled publishing (launchd)](docs/customising.md#scheduled-publishing-launchd). To publish by hand, run the same wrapper from a terminal in this repo:

```bash
scripts/weekly.sh
```

End to end this:

1. Runs the pinned CLI headless: `/newsletter:newsletter-ai web:<repo>/site date:<date> week:<week> triage:<repo>/.newsletter`, with `--restricted`, no Bash and no MCP.
2. The skill writes `site/content/posts/YYYY-MM-DD.md` and `.newsletter/triage.md`, and nothing else.
3. Holds the issue unless the post is the only change and `scripts/check_issue.py` passes it.
4. Commits `Newsletter YYYY-MM-DD` and pushes. Cloudflare Pages auto-deploys → https://newsletter-ai-skill.pages.dev/ (~30s).
5. Filters the triage file into `~/notes/inbox/YYYY-MM-DD-newsletter-triage.md`.

Uses your Claude Code subscription quota — no Anthropic API credits consumed. `/newsletter-ai web:./site` in a Claude Code session only writes the post, for a preview; the skill never commits or pushes.

### Pre-flight

- On `main`, working tree clean.
- `baseURL` in `site/hugo.toml` matches the live Pages URL.
- The `claude-newsletter` Keychain item exists, and `scripts/install-agent.sh` has been re-run since `scripts/weekly.sh` last changed.

### Recovery

- **Held issue**: the post stays uncommitted and blocks later runs. The checker's findings are in `~/Library/Logs/newsletter/<week>.check`; delete or fix the post as described in `docs/customising.md` → "When an issue is held".
- **Push failed**: the commit stays local, and the next run pushes it without calling the model.

### Checks

Run `make check` after changing the skill, the checker or the scripts: unit tests for the checker, an offline test of `weekly.sh` against a fake `claude`, and lint.

---

## Token cost reference

| Operation | Approximate token cost |
|---|---|
| `WebSearch` (1 query, ~10 results) | ~500–1,000 tokens |
| `WebFetch` (full article) | 5,000–30,000 tokens |
| Reading `sources.md` | ~3,000 tokens (loaded once via SKILL.md reference) |
| Final newsletter output | ~3,000–5,000 tokens |

Target for a full 13-category run: **~26 WebSearch + 5–10 selective WebFetch** = well within a session's budget.
