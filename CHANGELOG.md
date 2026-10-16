# Changelog

What changed, by day, drawn from the commit history. The repo has no releases or tags, so each
section is a date; where the plugin's version changed, the section says so. Within a day, changes
are grouped by kind, and published issues are listed under **Issues**.

## 2026-10-16

Plugin version 1.0.1.

### Changed

- Source catalogue refreshed after a check of all 333 links. Four pages had moved and are repointed:
  KAI Scheduler (now the `kai-scheduler` GitHub org), CoreWeave's blog, Irregular's research page,
  and the US Department of Energy's AI topic, renamed `super-intelligence` like NIST's. Meta AI is
  marked quiet since 27 July 2026.
- HPCwire and the Arena leaderboard page refuse the skill's fetcher as well as curl, so they join
  the search-only list. EE Times loads with WebFetch and is listed with the sites that do.

### Added

- Sources: Palisade Research (section 2); 404 Media and Platformer (3); Google Developers Blog,
  Cloudflare and Vercel (8); SWE-bench (11), with a note to cite a dated announcement rather than
  its undated leaderboard. Each was live and posting in October.

### Fixed

- Cognition was listed twice, under `cognition.ai` and `cognition.com`; the first redirects to the
  second, so the two rows are one.

## 2026-10-15

A review of the repo, three pull requests (#15, #16, #17) and two direct commits. Plugin version
1.0.0, the first published one.

### Added

- **Install as a plugin.** `.claude-plugin/marketplace.json` makes this repo a marketplace, so
  `/plugin marketplace add ChrisAdkin8/newsletter-ai-skill` then
  `/plugin install newsletter@newsletter-ai-skill` gives `/newsletter:newsletter-ai` in any project.
  The plugin is the skill alone; the scheduler, checker and site stay in the repo. `make lint`
  validates both manifests when the CLI is installed.
- **Section 15, AI Coding Practitioners** (#15): practitioner writers and practice data on how
  engineers use coding agents, a template section and a `[Practice]` tag.
- **The checker holds thin issues.** A post with fewer than 15 sourced items, or with no Editor's
  Picks, is held as a run that stopped early. `--min-items` overrides the floor for a hand publish.
- **The checker holds raw HTML** (`markup` rule): any HTML tag or comment, or Hugo shortcode, in a
  post. The model reads the open web, so a page could otherwise put markup on the live site.
- **Search** at `/search/` on the site, which the docs had promised but no page existed for.
- `site/scripts/bootstrap.sh --theme-only` re-vendors PaperMod at a tag, branch or commit SHA.
- An editor's note on the four issues that predate the current rules (2026-05-14,
  05-15, 09-13 and 09-18). They stay as published.
- A Development section in the README.

### Changed

- The scheduled run pins its model (`CLAUDE_MODEL`, `claude-sonnet-5-5`) instead of the floating
  `sonnet` alias, so writing and cost change only when the pin is bumped.
- The wrapper dates issues by the UTC date, so the post's `T00:00:00Z` stamp is never ahead of the
  clock the checker and Cloudflare build against, wherever the Mac is.
- `docs/sources.md` is a one-page map of the catalogue, not a second copy of it; the two had drifted
  by more than a thousand lines.
- A named writer, newsletter or lab is cited at most once per issue, whichever sections list them.
  Three writers listed in both section 3 and section 15 now live in 15 only.
- The skill's description is 779 characters, within the Agent Skills limit of 1,024; `allowed-tools`
  lists the tools it uses (`Glob`, `Write`, `Edit` added).
- README rewritten: requirements before quick start, an example from a passing issue, the fork
  steps cover the notes feed, and the safety section says exactly what the model can reach.
- The checker's `repeat` rule ignores tracking parameters (`utm_*`, `fbclid` and the like), and its
  `label` rule no longer reads "X-Ray Research" as a claim to be X.

### Fixed

- A push that failed was retried forever once anything else landed on `origin/main`, while
  notifying "the next slot retries it". The retry now rebases the issue commit first, and stops
  with a clear message if that conflicts.
- Triage dedup no longer treats a URL as already in your notes because a longer URL that starts
  with it is.
- The documented PaperMod update recipe never worked, because bootstrap exits on seeing
  `hugo.toml`; `--theme-only` replaces it.

### Removed

- The `claude-hacks` skill, which moved to
  [ChrisAdkin8/claude-code-hacks](https://github.com/ChrisAdkin8/claude-code-hacks).

### Security

- The site renders with Goldmark's `unsafe = false`, so raw HTML in a post is dropped even if the
  checker were bypassed.

## 2026-10-12

### Changed

- Source catalogues refreshed: renames (Euractiv to Rapporteur, NIST CAISI to CAISSI, NIST's and
  CISA's renamed AI pages), dormant sources marked, and a "loads with WebFetch" list for sites that
  refuse curl only.

### Added

- Sources including Lobsters, Google Research, Menlo Ventures, Ramp's AI Index, Pew, Fortune AI,
  Cisco Talos, Irregular, Straiker, LMCache, Modular, SK hynix, Samsung, TheElec, EE Times, Data
  Center Knowledge, HPCwire and cloud vendors' Kubernetes blogs.

## 2026-10-09

### Issues

- 2026-W41 published.

## 2026-10-02

### Issues

- 2026-W40 published, then regenerated with the AI Coding Practitioners section.

## 2026-09-26

### Changed

- README: steps for running your own fork, and the full list of rules the checker can't see.

### Fixed

- `tests/weekly_test.sh` failed between local midnight and 09:00 UTC, because its fake posts were
  stamped `T09:00:00Z` and held as future-dated.

## 2026-09-25

### Changed

- Source catalogues refreshed: broken links fixed (the Claude Code changelog moved to
  `code.claude.com`), moved sites repointed, AlpacaEval and the retired Open LLM Leaderboard dropped,
  and anonymous aggregators added to "Don't cite".

### Added

- Sources for the sections that ran thin, among them the EU AI Office, NIST CAISI, the Frontier
  Model Forum, Transluce, Goodfire, the Anthropic and OpenAI alignment blogs, and AI security
  researchers such as Wiz, XBOW, AISLE and Zenity.

### Issues

- 2026-W39 published, then regenerated against the refreshed catalogue.

## 2026-09-18

### Added

- The checker enforces the source rules: `never` holds a banned outlet, `rolling` holds a living
  index such as a changelog or releases page, and `secondary` warns, without holding, on outlets
  that habitually rewrite a primary source. Warnings are counted in the publish notification.
- A missing triage file holds the issue, since a run that skipped that step may have skipped others.
- Primary sources for Chinese open-weight labs (DeepSeek, Qwen, Moonshot, Z.ai, MiniMax, ByteDance
  Seed, Baidu), and the sources issues had been citing without the catalogue listing them.
- At most one item per publisher per section, counting editorial voices rather than venues such as
  arXiv and GitHub.

### Changed

- `CLAUDE.md` holds agent instructions only; the publishing runbook lives in `docs/customising.md`.

### Fixed

- The 2026-W38 issue published but 404'd: posts were stamped `T09:00:00Z` and Hugo drops future
  posts. Posts are stamped at midnight, and a `future` rule holds a future-dated post.

### Issues

- 2026-W38 published, then recurated under the new source rules.

## 2026-09-13

Publishing moved from GitHub Actions to the Mac.

### Added

- `scripts/weekly.sh`, run twice a day by a launchd agent, publishes at most one issue a week. It
  runs a pinned Claude Code CLI with `--restricted`, no Bash and no MCP, and commits and pushes only
  if the post is the only change and passes the checker.
- `scripts/check_issue.py`, a deterministic checker for repeated, stale and homepage links, press
  wires, mislabelled sources and date or week mismatches.
- `scripts/install-agent.sh` and the plist template; the CLI token lives in the Keychain.
- Notes triage: up to five items matching `scripts/interests.txt` go to your notes inbox after
  each publish.
- An offline test of the wrapper against a fake CLI, and `make check`.
- Section 13, Cloud Native & CNCF, and section 14, Trending Open Source AI, each with a template
  section.
- A "Don't cite" list and a "Search only" list in the catalogue.
- An MIT licence.

### Changed

- The skill only writes the post; it no longer commits or pushes. Titles carry the ISO week, and
  `date:` and `week:` arguments set them.
- Source catalogues checked in full (222 URLs): broken and moved sources fixed, dead and dormant
  ones removed.
- README restructured around what the project does.

### Removed

- The GitHub Actions workflow and Dependabot config. Every scheduled run since May had failed on
  API credit.
- The Obsidian vault output and its Canvas files.

### Issues

- 2026-W37 published, then regenerated with the new sections.

## 2026-06-22 and 2026-07-20

- Maintenance: Dependabot bumped `actions/checkout` and `actions/setup-node` to 7 (also bumped to 6
  on 2026-05-14). The workflow they served was removed on 2026-09-13.

## 2026-05-15

### Issues

- Second issue published.

## 2026-05-14

### Added

- The Hugo site with the PaperMod theme, vendored at a pinned commit, deployed on Cloudflare Pages,
  and a weekly GitHub Actions workflow to publish into it.
- Threat-intel labs, cyber trade press and EU Council and Parliament sources.

### Fixed

- `baseURL` pointed at an unrelated Cloudflare Worker, so every internal link on the site opened a
  placeholder page.

### Issues

- First issue published.

## 2026-03-02

### Added

- The `claude-hacks` companion skill (moved out on 2026-10-15).

## 2026-02-27 and 2026-02-28

### Added

- Section 12, Newsletters & Podcasts, as leads to primary sources, and 16 new sources.
- Documentation for running the skill from a scheduled GitHub Actions workflow.

## 2026-02-20

### Added

- Four new categories: Regulatory & Policy, Agent Era & Technical Workflows, Open Source &
  Specialised Infrastructure, and Macro & Hardware Watch; then section 11, Model Evaluations &
  Transparency, with `[Eval]` and `[Safety]` tags.
- About 60 sources across the categories: alignment labs, academic labs, infrastructure companies,
  AI media, individual writers, government agencies, Hacker News, X accounts and 12 LinkedIn
  profiles.
- Obsidian vault output with Canvas mindmaps and a four-level graph (removed on 2026-09-13).
- `CLAUDE.md` with run rules for the skill.

## 2026-02-19

### Added

- The `/newsletter-ai` skill: a weekly agentic AI and LLM newsletter from Reddit, arXiv, technical
  blogs, analyst reports, OWASP, MITRE, NIST and product news, with docs on how it works, the
  source catalogue and customising it.
