# newsletter-ai — Project Guidelines

This repo holds two Claude Code skills — `/newsletter-ai` and `/claude-hacks` — the scripts that publish the newsletter, and the Hugo site it publishes to.

Scheduled runs don't load this file. `scripts/weekly.sh` passes `--restricted`, which skips the project `CLAUDE.md` (verified in [`docs/specs/2026-09-13-weekly-local-publishing.md`](docs/specs/2026-09-13-weekly-local-publishing.md)). Anything that has to reach a scheduled run belongs in `.claude/skills/newsletter-ai/SKILL.md`, not here.

## Don't publish

`scripts/weekly.sh` commits to `main`, pushes to a public site and spends about $7 of the user's subscription quota. Never run it on your own initiative, and don't commit or push an issue yourself. If the user asks you to publish, say what the command will do and confirm before running it.

The runbook — scheduling, held issues, logs, publishing by hand — is [`docs/customising.md` → Scheduled publishing](docs/customising.md#scheduled-publishing-launchd).

## Previews jam the scheduler

`/newsletter-ai web:./site` writes `site/content/posts/<today>.md`, the same file a scheduled run creates, and the wrapper refuses to run while the tree is dirty. Delete a preview post once the user has finished with it, or send it outside the repo with `web:~/preview-site`, which gives the markdown without a rendered site.

## When you change something here

- **Never edit `site/themes/PaperMod/`.** It's vendored at the commit pinned in `.papermod-sha`; update it the way `site/README.md` describes.
- **After editing `scripts/weekly.sh`, tell the user to re-run `scripts/install-agent.sh`.** launchd runs an installed copy, so the repo's version has no effect until they do.
- **Run `make check`** after changing the skill, the checker or the scripts: checker unit tests, an offline test of `weekly.sh` against a fake `claude`, and lint.
- **If `check_issue.py` rejects a post, fix the post.** The checker is the only thing standing between a bad issue and the live site; loosening a rule to get an issue out is never the answer.

## Running /newsletter-ai

The run rules live in `.claude/skills/newsletter-ai/SKILL.md` under "Run rules". They govern the run, and take precedence over general guidance about fanning work out to subagents or tracking it as tasks.
