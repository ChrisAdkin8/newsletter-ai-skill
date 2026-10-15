# newsletter-ai

A Claude Code skill, `/newsletter-ai`, that curates *Agentic AI & LLM Weekly*, and the scripts that publish it for you every week.

**Read it:** [newsletter-ai-skill.pages.dev](https://newsletter-ai-skill.pages.dev/) · **Subscribe:** [RSS](https://newsletter-ai-skill.pages.dev/index.xml)

## What it does

- **Curates.** `/newsletter-ai` searches [15 source categories](#source-categories) and writes a digest: rewritten headlines, two-to-four sentence summaries, a tag on every item, and an "Editor's Picks" theme that ties the week together.
- **Writes a web post.** Each issue becomes a Hugo post, published on Cloudflare Pages with no npm dependencies in the build.
- **Publishes every week without you.** A launchd agent on your Mac runs the skill headless on your Claude Code subscription, at most once per issue week.
- **Holds bad issues back.** A checker re-reads every finished post against nine rules — reused or stale links, homepages and rolling indexes, press-release wires, banned outlets, mislabelled sources, raw HTML, a half-finished issue — and anything that fails stays unpublished, with a notification to you. The rules are [listed below](#how-quality-is-enforced).
- **Feeds your notes.** After each publish, up to five items that match the interests you list in `scripts/interests.txt` are written to a markdown note, one link per line with the reason it matched, for whatever you use to read notes.

## Requirements

- **Claude Code** with a subscription, installed with the native installer. The scheduler copies a pinned version (`CLAUDE_PIN` in `scripts/install-agent.sh`) from `~/.local/share/claude/versions/`, and `install-agent.sh` stops if that version isn't there. To move to one you have, follow "Bump the CLI" in [Day to day](docs/customising.md#day-to-day).
- **macOS** for scheduled publishing, which needs launchd, the Keychain and notifications. The skill itself runs anywhere Claude Code does.
- **Room in your quota.** A run searches 15 categories, so it takes a while — scheduled runs are capped at an hour — and spends real quota: a pinned Sonnet model (`CLAUDE_MODEL` in `scripts/weekly.sh`) with a `--max-budget-usd 10` cap. Issues up to October 2026, with 14 categories, reported $6–8 of equivalent usage, drawn from your subscription rather than billed as API credits; the fifteenth category adds to that, and each publish notification carries the run's cost.
- **Hugo Extended** to preview the site locally (`brew install hugo`). Cloudflare Pages builds it on every push.
- **Python 3, jq, git and curl**, which the wrapper and the checker use. Recent macOS includes them; Python 3 comes with the Xcode command line tools.

## Quick start

### Try it in Claude Code

The skill is a project skill in this repo. Open Claude Code here and run:

```
/newsletter-ai                                          # Last 7 days, all 15 categories
/newsletter-ai security focus                           # Narrow to one topic
/newsletter-ai web:./site                               # Also write the post into the bundled site/
/newsletter-ai web:~/my-hugo-site                       # Write it into a separate Hugo repo
/newsletter-ai web:./site date:2026-09-18 week:2026-W38 # Set the issue date and week
```

The skill writes the post but never commits or pushes it.

### Install it as a plugin

To have `/newsletter-ai` in every project, install it from this repo's marketplace. Inside a Claude Code session:

```
/plugin marketplace add ChrisAdkin8/newsletter-ai-skill
/plugin install newsletter@newsletter-ai-skill
```

Then run `/newsletter:newsletter-ai` — plugin skills carry the plugin's name as a prefix. The plugin is the skill alone: the scheduler, the checker and the site stay in this repo, since they need a clone to work in. Copying `.claude/skills/newsletter-ai/` into another project's `.claude/skills/` still works if you'd rather not install anything.

**Previewing into `site/` collides with the scheduler.** `web:./site` writes `site/content/posts/<today>.md`, the same file a scheduled run creates, and the wrapper refuses to run while the tree is dirty. Delete the preview when you're done, or write it somewhere else with `web:~/preview-site`.

### Publish every week automatically (macOS)

In a fork, do the steps in [Use it for your own newsletter](#use-it-for-your-own-newsletter) first. Run these in an ordinary Terminal window, since two of them prompt you:

```bash
claude setup-token                                                 # sign in; copy the one-year token
security add-generic-password -s claude-newsletter -a "$USER" -w   # paste it at both prompts
PROBE=1 scripts/install-agent.sh                                   # install in probe mode
launchctl kickstart -k gui/$(id -u)/local.newsletter-ai.weekly     # expect a "probe ok" notification
scripts/install-agent.sh                                           # switch to real runs
```

From then on the agent runs daily at 09:07 and 18:07 and publishes at most one issue per week (Friday to Thursday). If the Mac is asleep at a run time, the run happens when it wakes. [Scheduled publishing](docs/customising.md#scheduled-publishing-launchd) covers held issues, logs, changing the schedule and uninstalling.

To publish by hand instead, run `NEWSLETTER_REPO=$PWD scripts/weekly.sh` from the repo — the same checks, then commit and push. The wrapper works on `$NEWSLETTER_REPO`, which the launchd agent sets for you.

## Example output

From the issue of 9 October 2026 — [browse them all](https://newsletter-ai-skill.pages.dev/posts/):

````markdown
# Agentic AI & LLM Weekly
**2026-W41 — 2 October – 9 October 2026**

> The infrastructure for trusting agents got tested this week — one prompt
> took over a cloud account, and a new index started scoring how often
> agents lie.

## Editor's Picks

Three stories this week are really about the same question: how do you know
an agent is behaving? Zenity Labs showed that a single prompt to one
public-facing AWS Bedrock agent could compromise every agent in the same
account and region…

## AI Security & Safety

### One Prompt to a Public Chatbot Could Take Over Every Agent in an AWS Account
`[Security]`

Zenity Labs disclosed AgentCorruption, a chain of flaws in Amazon Bedrock
AgentCore where a single prompt to one public-facing agent let researchers
pivot to every other agent in the same AWS account and region…

[Source: [Zenity Labs](https://zenity.io/press-release/zenity-labs-discloses-agentcorruption-a-chain-of-aws-agentcore-flaws)]
````

## How quality is enforced

The skill follows hard rules when it picks stories, and [`scripts/check_issue.py`](scripts/check_issue.py) re-checks the finished post against these:

- **No reused links** — nothing linked twice in one issue, or already linked in any of the last four issues.
- **Nothing stale** — a link whose URL carries a date before the seven-day window fails.
- **Articles, not homepages** — every source link needs a path, not just a domain, and never a rolling index such as a blog root, changelog or releases page.
- **Honest labels** — a source labelled Reddit, Hacker News, arXiv, X, GitHub or Microsoft Research has to link there.
- **No press-release wires** — a link to PR Newswire, Business Wire or the like fails; cite the coverage instead.
- **No banned outlets** — a link to an investment, syndicated-finance or fan site named in the "Don't cite" list fails.
- **A whole issue** — fewer than 15 items with a source, or no Editor's Picks, fails: that's a run that stopped early, not a quiet week.
- **Markdown only** — a raw HTML tag or comment, or a Hugo shortcode, fails. The model reads the open web, so anything a page smuggled into the post stops here, and the site is built with Goldmark's `unsafe = false` in case it doesn't.
- **Sound metadata** — filename, frontmatter date and the issue week in the title, all agreeing, none in the future, and no week an earlier issue already used.

The checker also warns, without holding anything, when a link goes to an outlet that often rewrites a primary source; the publish notification says how many warnings there were.

Every issue from 25 September 2026 on passes all of these. The four earlier issues went out before the rules took their current form; they stay on the site as published, each with an editor's note saying so.

Some rules rest on the skill alone, because the checker reads URLs and labels and can't see what a page says:

- the same story under two different URLs;
- a page that rewrites a primary source it links to;
- more than one item from the same publisher in a section, the same named writer twice in an issue, or more than four items in a category;
- crypto outlets for stories that aren't about crypto, and anonymous aggregators.

`scripts/weekly.sh` publishes only if the post is the only change in the tree and the checker passes it. Otherwise the issue is held, uncommitted, and you're notified. See [How it works](docs/how-it-works.md) for the full workflow.

## Why it's safe to leave running

- **The model's reach is this repo and the web.** Scheduled runs pass `--restricted` with no Bash and no MCP servers. `--allowedTools` lets the model read the repo (which is public), fetch web pages, and write only under `site/content/posts/` and its triage file. Your notes, your Keychain and the rest of the machine are never in scope.
- **The scripts own git.** The model never runs git. `scripts/weekly.sh` stages the post only after the checker passes, and only if it is the only change in the tree.
- **What the model reads can't reach the page.** The model fetches arbitrary web pages, so a post is treated as untrusted on the way out: the checker holds any post carrying raw HTML or a Hugo shortcode, and Hugo renders raw HTML off (`unsafe = false`) regardless.
- **Nothing auto-updates.** Hugo is one Go binary at the version `HUGO_VERSION` pins in the Cloudflare build, and its release checksums let you verify the copy you install locally. PaperMod is vendored at a pinned commit (`site/themes/PaperMod/.papermod-sha`). Scheduled runs use a pinned copy of the Claude Code CLI and a pinned model ID rather than a floating alias. No `npm install` runs in this repo.

## Hosting the site

The bundled `site/` is a [Hugo](https://gohugo.io) site with the [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme, deployed free on [Cloudflare Pages](https://pages.cloudflare.com/). It's already scaffolded, so `site/scripts/bootstrap.sh` exits straight away here; it's for starting a site from nothing, and `--theme-only` re-vendors the theme.

### Use it for your own newsletter

A fork carries this newsletter's issues, address and interests. Before its first publish:

1. **Point the site at your address.** Set `baseURL` in `site/hugo.toml` to your Cloudflare Pages URL, and change the "Read it" and RSS links at the top of this README.
2. **Remove this newsletter's issues.** Delete the files in `site/content/posts/`, or your site republishes them. The checker also compares each new issue with the last four in that folder, so old issues would block stories you haven't run.
3. **Make the notes feed yours.** Put your own interests in `scripts/interests.txt`, one per line. The note lands in `~/notes/inbox/` and each line ends with a `/research quick <url>` command for a Claude Code skill the author uses; change the folder with `NOTES_DIR` in the plist template's environment, and change or drop the command in `move_triage` in `scripts/weekly.sh`. Both are one-line edits you carry in your fork.
4. **Connect the repo to Cloudflare Pages.** [`site/README.md`](site/README.md) has the exact dashboard settings. Vercel and Netlify also support Hugo if you prefer them.

Then follow [Quick start](#quick-start).

## Source categories

| # | Category | # | Category |
|---|---|---|---|
| 1 | Community & Discussion | 9 | Open Source & Specialised Infrastructure |
| 2 | Research & Papers | 10 | Macro & Hardware Watch |
| 3 | Technical Blogs & Engineering Posts | 11 | Model Evaluations & Transparency |
| 4 | Analyst & Industry Reports | 12 | Newsletters & Podcasts (leads to primary sources only) |
| 5 | AI Security | 13 | Cloud Native & CNCF |
| 6 | Product & Company News | 14 | Trending Open Source AI |
| 7 | Regulatory & Policy | 15 | AI Coding Practitioners |
| 8 | Agent Era & Technical Workflows |   |   |

Every source, with what it's for and how to search it, is in [`.claude/skills/newsletter-ai/sources.md`](.claude/skills/newsletter-ai/sources.md), the one catalogue the model reads; [`docs/sources.md`](docs/sources.md) is a map of it.

## Repository layout

```
newsletter-ai-skill/
├── .claude-plugin/marketplace.json          # Lists the plugin, so /plugin marketplace add finds it
├── .claude/                                 # The plugin root: --plugin-dir and the marketplace both load it
│   ├── .claude-plugin/plugin.json           # Plugin manifest (name "newsletter", version)
│   └── skills/
│       └── newsletter-ai/                   # The skill: SKILL.md, sources.md, template.md
├── docs/                                    # See Documentation below; specs/ holds the designs
├── scripts/
│   ├── weekly.sh                            # Runs the skill headless, checks, commits, pushes
│   ├── check_issue.py                       # Checks a post against the hard rules
│   ├── install-agent.sh                     # Installs the launchd agent and the pinned CLI
│   ├── local.newsletter-ai.weekly.plist.in  # launchd agent template
│   └── interests.txt                        # What the triage note looks for
├── .newsletter/                             # Scratch dir a scheduled run hands the model; gitignored
├── site/                                    # Hugo + PaperMod site (see site/README.md)
└── tests/                                   # Checker unit tests, offline test of weekly.sh
```

Runs use the skill files in `.claude/skills/newsletter-ai/` directly, so there's no second copy to keep in sync.

## Development

```bash
make check                    # checker unit tests, an offline run of weekly.sh against a fake claude, lint
python3 -m unittest discover tests
bash tests/weekly_test.sh
cd site && hugo server        # preview the site at http://localhost:1313
```

Run `make check` after changing the skill, the checker or the scripts. Lint runs shellcheck only if it's installed (`brew install shellcheck`) and skips it otherwise, so install it if you touch a script. The wrapper test and the plist lint are macOS-only (`date -v`, `plutil`); the checker tests run anywhere.

## Documentation

| Doc | Covers |
|---|---|
| [`docs/how-it-works.md`](docs/how-it-works.md) | The six-step workflow, the hard rules and checker, publishing |
| [`docs/sources.md`](docs/sources.md) | How the source catalogue is organised and where it lives |
| [`docs/customising.md`](docs/customising.md) | Adding sources, changing the format, web publishing, scheduled publishing, held issues and recovery |
| [`site/README.md`](site/README.md) | Hugo + PaperMod bootstrap, Cloudflare Pages settings, theme updates |
| [`CLAUDE.md`](CLAUDE.md) | The rules Claude Code follows in this repo |

## Formerly here: `claude-hacks`

The `claude-hacks` skill, which curates Claude Code productivity tips into an awesome-list README, used to live in this repo. It now lives with the list it writes, at [ChrisAdkin8/claude-code-hacks](https://github.com/ChrisAdkin8/claude-code-hacks); this repo's history up to October 2026 has the old copy.

## Licence

MIT — see [`LICENSE`](LICENSE).
