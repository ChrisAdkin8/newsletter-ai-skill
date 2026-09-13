# newsletter-ai

A Claude Code skill that curates a weekly newsletter on agentic AI and LLMs, and publishes it for you.

**Read it:** [newsletter-ai-skill.pages.dev](https://newsletter-ai-skill.pages.dev/) · **Subscribe:** [RSS](https://newsletter-ai-skill.pages.dev/index.xml)

---

## What it does

- **Curates.** `/newsletter-ai` searches [14 source categories](#source-categories) and writes a digest: rewritten headlines, two-to-four sentence summaries, a tag on every item, and an "Editor's Picks" theme that ties the week together.
- **Writes a web post.** Each issue becomes a Hugo post, published on Cloudflare Pages with no npm dependencies in the build.
- **Publishes every week without you.** A launchd agent on your Mac runs the skill headless on your Claude Code subscription, at most once per issue week.
- **Holds bad issues back.** A checker blocks any issue that reuses links, cites stale or homepage sources, or mislabels them. A held issue stays unpublished and you get a notification.
- **Feeds your notes.** After each publish, up to five items that match your interests land in your notes inbox, each with a `/research quick` command ready to run.

> **What's new (September 2026).** The skill now only writes the post; publishing is the wrapper's job, and only after the checker passes. Titles carry the ISO week (`2026-W37`) rather than an issue number. The local archive copy is gone.

---

## Quick start

### Try it in Claude Code

The skill is a project skill in this repo. Open Claude Code here and run:

```
/newsletter-ai                                          # Last 7 days, all 14 categories
/newsletter-ai security focus                           # Narrow to one topic
/newsletter-ai web:./site                               # Also write the post into the bundled site/
/newsletter-ai web:~/my-hugo-site                       # Write it into a separate Hugo repo
/newsletter-ai web:./site date:2026-09-18 week:2026-W38 # Set the issue date and week
```

The skill writes the post but never commits or pushes it. To use it in another project, copy `.claude/skills/newsletter-ai/` into that project's `.claude/skills/`.

### Publish every week automatically

Run these in an ordinary Terminal window, since two of them prompt you:

```bash
claude setup-token                                                 # sign in; copy the one-year token
security add-generic-password -s claude-newsletter -a "$USER" -w   # paste it at both prompts
PROBE=1 scripts/install-agent.sh                                   # install in probe mode
launchctl kickstart -k gui/$(id -u)/local.newsletter-ai.weekly     # expect a "probe ok" notification
scripts/install-agent.sh                                           # switch to real runs
```

From then on the agent runs daily at 09:07 and 18:07 and publishes at most one issue per week (Friday to Thursday). [Scheduled publishing](docs/customising.md#scheduled-publishing-launchd) covers held issues, logs, changing the schedule and uninstalling.

To publish by hand instead, run `scripts/weekly.sh`: it does the same checks, commits and pushes.

---

## Requirements

- **Claude Code** with a subscription, installed with the native installer. The scheduler copies a pinned version (`CLAUDE_PIN` in `scripts/install-agent.sh`) from `~/.local/share/claude/versions/`.
- **macOS** for scheduled publishing (launchd, Keychain, notifications). Running the skill interactively works anywhere Claude Code does.
- **Hugo Extended** to scaffold and preview the site (`brew install hugo`). Cloudflare Pages builds it on every push.
- **Python 3, jq, git and curl**, which the wrapper and the checker use. Recent macOS includes them; Python 3 comes with the Xcode command line tools.

The triage note goes to `~/notes/inbox/`. To use another folder, set `NOTES_DIR` in the plist template's environment and re-run `scripts/install-agent.sh`.

---

## Example output

From the [2026-W37 issue](https://newsletter-ai-skill.pages.dev/posts/2026-09-13/):

````markdown
# Agentic AI & LLM Weekly
**2026-W37 — 6 September – 13 September 2026**

> AI's own leaders and the US government both signalled this week that the
> race itself is the risk, not just any single model.

## Editor's Picks

Three stories capture a week where the brakes got more attention than the
accelerator. Dario Amodei's "We Must Pace the Frontier" essay proposed the
industry's first concrete plan to deliberately slow capability gains…

## Community Pulse

### Amodei's Call to Slow Down AI Splits Hacker News Between Relief and Suspicion
`[Community]`

Within hours of Dario Amodei publishing "We Must Pace the Frontier," Sam Altman
wrote that he agreed OpenAI should do the same…

[Source: [Hacker News](https://news.ycombinator.com/item?id=49672510)]
````

---

## How quality is enforced

The skill follows hard rules when it picks stories: nothing from the last four issues, no story twice, every item dated inside the week, article links rather than homepages, a label that names the linked page's publisher, no press-release wires, and no investment, fan or off-topic crypto sites.

[`scripts/check_issue.py`](scripts/check_issue.py) then checks the finished post against most of those rules, plus the filename, date and week. `scripts/weekly.sh` publishes only if the post is the only change in the tree and the checker passes it. Otherwise the issue is held, uncommitted, and you're notified.

The model runs with no shell, no MCP servers and no access to your notes, and can write only the post and its triage file. See [How it works](docs/how-it-works.md) for the full workflow.

---

## Hosting the site

The bundled `site/` is a [Hugo](https://gohugo.io) site with the [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme, deployed free on [Cloudflare Pages](https://pages.cloudflare.com/). One-time setup:

```bash
./site/scripts/bootstrap.sh                      # Scaffold Hugo + PaperMod into site/
git add site/ && git commit -m "Scaffold site" && git push
```

Then connect the repo to Cloudflare Pages; [`site/README.md`](site/README.md) has the exact dashboard settings. Vercel and Netlify also support Hugo if you prefer them.

**Supply chain:** Hugo is a single Go binary published with SHA256SUMS, and PaperMod is vendored at a pinned commit (`site/themes/PaperMod/.papermod-sha`). No `npm install` runs in this repo, and scheduled runs use a pinned copy of the Claude Code CLI that doesn't auto-update.

---

## Source categories

| # | Category | # | Category |
|---|---|---|---|
| 1 | Community & Discussion | 8 | Agent Era & Technical Workflows |
| 2 | Research & Papers | 9 | Open Source & Specialised Infrastructure |
| 3 | Technical Blogs & Engineering Posts | 10 | Macro & Hardware Watch |
| 4 | Analyst & Industry Reports | 11 | Model Evaluations & Transparency |
| 5 | AI Security | 12 | Newsletters & Podcasts (leads to primary sources only) |
| 6 | Product & Company News | 13 | Cloud Native & CNCF |
| 7 | Regulatory & Policy | 14 | Trending Open Source AI |

Every source, with why it's there and how to search it, is in [`docs/sources.md`](docs/sources.md).

---

## Repository layout

```
newsletter-ai-skill/
├── .claude/
│   ├── .claude-plugin/plugin.json           # Lets headless runs load the skills with --plugin-dir
│   └── skills/
│       ├── newsletter-ai/                   # The skill: SKILL.md, sources.md, template.md
│       └── claude-hacks/                    # Companion skill (see below)
├── docs/
│   ├── how-it-works.md                      # The workflow, the checker, publishing
│   ├── sources.md                           # Annotated source catalogue
│   ├── customising.md                       # Sources, format, web publishing, scheduling
│   └── specs/                               # Implementation specs
├── scripts/
│   ├── weekly.sh                            # Runs the skill headless, checks, commits, pushes
│   ├── check_issue.py                       # Checks a post against the hard rules
│   ├── install-agent.sh                     # Installs the launchd agent and the pinned CLI
│   ├── local.newsletter-ai.weekly.plist.in  # launchd agent template
│   └── interests.txt                        # What the triage note looks for
├── tests/                                   # Checker unit tests, offline test of weekly.sh
├── site/                                    # Hugo + PaperMod site (see site/README.md)
├── Makefile                                 # make check
├── CLAUDE.md                                # Project rules for Claude Code
└── LICENSE                                  # MIT
```

Runs use the skill files in `.claude/skills/newsletter-ai/` directly, so there's no second copy to keep in sync. Run `make check` after changing the skill, the checker or the scripts.

---

## Documentation

| Doc | Covers |
|---|---|
| [`docs/how-it-works.md`](docs/how-it-works.md) | The six-step workflow, the hard rules and checker, publishing |
| [`docs/sources.md`](docs/sources.md) | Every source in all 14 categories, with search strategies |
| [`docs/customising.md`](docs/customising.md) | Adding sources, changing the format, web publishing, scheduled publishing |
| [`site/README.md`](site/README.md) | Hugo + PaperMod bootstrap, Cloudflare Pages settings, theme updates |
| [`CLAUDE.md`](CLAUDE.md) | Publishing checklist and recovery, and the rules Claude Code follows in this repo |

---

## Companion skill: `claude-hacks`

The repo also contains `claude-hacks`, which curates Claude Code productivity hacks into an [awesome-list](https://github.com/ChrisAdkin8/claude-code-hacks)-style README. It needs a target GitHub repo (`gh repo create claude-code-hacks --public --source=. --push`).

```bash
cp -r .claude/skills/claude-hacks/ ~/.claude/skills/claude-hacks/
```

```
/claude-hacks                                  # Writes to ~/claude-code-hacks/
/claude-hacks repo:~/my-lists/claude-code-hacks
```

Each run appends only new items. It searches Reddit, Hacker News, X, GitHub, Anthropic's docs and blog, YouTube, personal blogs and the MCP ecosystem, and sorts what it finds into nine sections, from Setup & Configuration to Video Tutorials.

---

## Licence

MIT — see [`LICENSE`](LICENSE).
