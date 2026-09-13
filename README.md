# newsletter-ai

> A Claude Code skill that curates a weekly newsletter on agentic AI and LLM developments. Outputs a clean Markdown digest to chat and writes it as a post for a public website built with Hugo + PaperMod on Cloudflare Pages — zero npm dependencies in the build. A launchd agent on your Mac can publish it every week, behind a checker that holds any issue that breaks the rules.

Invoke `/newsletter-ai` and Claude searches thirteen source categories — community discussion, research papers, engineering blogs, analyst reports, AI security, product news, regulation, agent frameworks, open source, hardware, model evaluations, cloud native and CNCF projects, and newsletters and podcasts as leads to primary sources — then produces a digest with rewritten headlines, two-to-four sentence summaries, a connecting "Editor's Picks" theme, and a tag on every item.

The full annotated source list lives in [`docs/sources.md`](docs/sources.md).

---

## What you get

| Output | Where it lands | When |
|---|---|---|
| Markdown newsletter | Chat | Every run |
| Hugo post | `site/content/posts/YYYY-MM-DD.md` | When you pass `web:./site` (or any Hugo + PaperMod repo path) |
| Public website | Cloudflare Pages | When `scripts/weekly.sh` pushes a post that passes the checker |
| Triage note | `~/notes/inbox/YYYY-MM-DD-newsletter-triage.md` | After each scheduled publish: up to five items matching your interests |

### Output preview

````markdown
# Agentic AI & LLM Weekly
**2026-W20 — 7–14 May 2026**

> The week AI agents became both the attacker and the defender — from the
> first AI-built zero-day exploit to Microsoft's 100-agent vulnerability hunter.

## Editor's Picks

Three stories this week crystallise a single uncomfortable truth: AI agents
are now powerful enough to find and exploit zero-day vulnerabilities, defend
against them at scale, and operate with enough autonomy that governments are
writing joint security frameworks to contain them.

## AI Security & Safety

### Google Discloses First Confirmed AI-Generated Zero-Day Exploit Used in the Wild
`[Security]`

Google's Threat Intelligence Group disclosed on May 11 the first confirmed
case of attackers using an AI model to discover a vulnerability and build a
working exploit — a 2FA bypass in a popular open-source admin tool…
````

The full workflow — gather, filter, write, editor's picks, triage, post — is documented in [`docs/how-it-works.md`](docs/how-it-works.md).

> **Changed in September 2026.** The skill now writes only the Hugo post: it keeps no local archive copy and no longer commits or pushes. `scripts/weekly.sh` publishes the post once `scripts/check_issue.py` passes it, or you can do that yourself. Titles carry the ISO week, such as `2026-W37`, rather than a running number.

---

## Quick start

The skill is a project skill in this repo. Open Claude Code here and run it:

```
/newsletter-ai
```

To use it in another project, copy `.claude/skills/newsletter-ai/` into that project's `.claude/skills/`.

**Invocation patterns:**

```
/newsletter-ai                                          # Last 7 days, all 13 categories
/newsletter-ai security focus                           # Topic-scoped
/newsletter-ai agentic frameworks only                  # Topic-scoped
/newsletter-ai web:./site                               # Write the post into the bundled site/
/newsletter-ai web:~/my-hugo-site                       # Write it into a separate Hugo repo
/newsletter-ai web:./site date:2026-09-18 week:2026-W37 # Set the issue date and week
```

---

## Publishing to the web

This repo includes everything needed to host the newsletter as a static site on [Cloudflare Pages](https://pages.cloudflare.com/) — free tier, unlimited bandwidth. The site uses **[Hugo](https://gohugo.io) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod)**: one signed Go binary plus one vendored theme. No npm tree, no transitive dependencies, ~5 MB to audit instead of ~700 packages.

**Prerequisites:** install Hugo Extended locally (`brew install hugo` on macOS).

**One-time setup:**

```bash
./site/scripts/bootstrap.sh                      # Scaffold Hugo + PaperMod into site/
git add site/ && git commit -m "Scaffold site" && git push
```

Then connect this repo to Cloudflare Pages (see [`site/README.md`](site/README.md) for the exact dashboard settings — Hugo framework preset, `HUGO_VERSION` env var).

### Two ways to publish a new issue

| Path | How | Auth | Cost |
|---|---|---|---|
| **Scheduled (recommended)** | A launchd agent runs `scripts/weekly.sh` twice a day and publishes at most one issue a week — see [`docs/customising.md` → Scheduled publishing (launchd)](docs/customising.md#scheduled-publishing-launchd) | Claude Code subscription, via a `claude setup-token` token in the Keychain | Subscription quota, capped at $10 a run |
| **By hand** | `scripts/weekly.sh` in a terminal; or `/newsletter-ai web:./site` in Claude Code, then check, commit and push yourself | Claude Code subscription | Subscription quota |

Both produce a Hugo-compatible Markdown file under `site/content/posts/YYYY-MM-DD.md`. `scripts/weekly.sh` commits and pushes it only if it's the only change and `scripts/check_issue.py` passes it, and Cloudflare Pages then deploys within ~30 seconds. An issue that fails is held, uncommitted, and you get a notification.

See [`CLAUDE.md` → Publishing a new issue](CLAUDE.md#publishing-a-new-issue) for the pre-flight checklist and recovery steps.

**Supply-chain story**: Hugo is a single Go binary distributed with SHA256SUMS. PaperMod is vendored as a frozen copy pinned to a known commit SHA (recorded in `site/themes/PaperMod/.papermod-sha`). No `npm install` ever runs in this repo for the website build. Scheduled runs use a pinned copy of the Claude Code CLI that doesn't auto-update.

Vercel and Netlify both support Hugo natively if you prefer them over Cloudflare Pages.

---

## Repository structure

```
newsletter-ai-skill/
├── .claude/
│   ├── .claude-plugin/plugin.json       # Lets headless runs load the skills with --plugin-dir
│   └── skills/
│       ├── newsletter-ai/               # Skill source — SKILL.md + sources + template
│       └── claude-hacks/                # Companion skill (see below)
├── docs/
│   ├── how-it-works.md                  # 6-step workflow, the checker, publishing
│   ├── sources.md                       # Annotated source catalogue (human-readable)
│   ├── customising.md                   # Adding sources, format changes, scheduled publishing
│   └── specs/                           # Implementation specs
├── scripts/
│   ├── weekly.sh                        # Runs the skill headless, checks, commits, pushes
│   ├── check_issue.py                   # Checks a post against the hard rules
│   ├── install-agent.sh                 # Installs the launchd agent and the pinned CLI
│   ├── local.newsletter-ai.weekly.plist.in  # launchd agent template
│   └── interests.txt                    # What the triage note looks for
├── tests/                               # Checker unit tests + offline test of weekly.sh
├── site/                                # Hugo + PaperMod static site
│   ├── README.md                        # Bootstrap + Cloudflare Pages dashboard setup
│   └── scripts/bootstrap.sh             # Scaffold Hugo site, vendor PaperMod at pinned ref
├── Makefile                             # make check
├── CLAUDE.md                            # Project-local Claude Code rules
├── LICENSE                              # MIT
└── README.md                            # This file
```

Runs use the skill files in `.claude/skills/newsletter-ai/` directly, so there's no second copy to keep in sync.

---

## Documentation

| Doc | Covers |
|---|---|
| [`docs/how-it-works.md`](docs/how-it-works.md) | The 6-step workflow, the hard rules and checker, publishing |
| [`docs/sources.md`](docs/sources.md) | Annotated source catalogue across all 13 categories, with search strategies |
| [`docs/customising.md`](docs/customising.md) | Adding sources, output format, web publishing, scheduled publishing |
| [`site/README.md`](site/README.md) | Hugo + PaperMod bootstrap, Cloudflare Pages dashboard, theme update process |
| [`CLAUDE.md`](CLAUDE.md) | Project-local rules that override global Claude Code defaults when running the skill |

---

## Companion skill: `claude-hacks`

This repo also contains the `claude-hacks` skill, which curates Claude Code productivity hacks into an [awesome-list](https://github.com/ChrisAdkin8/claude-code-hacks)-style README.

```bash
cp -r .claude/skills/claude-hacks/ ~/.claude/skills/claude-hacks/
```

```
/claude-hacks                                  # Writes to ~/claude-code-hacks/
/claude-hacks repo:~/my-lists/claude-code-hacks
```

Each run appends only new items — no duplicates, no regeneration. On first run it creates the full README structure. A target GitHub repo is required (`gh repo create claude-code-hacks --public --source=. --push`).

The skill searches Reddit (r/ClaudeAI, r/AIdev), Hacker News, X/Twitter (@bcherny, @simonw), GitHub repos and gists, Anthropic docs and blog, YouTube tutorials, personal blogs, and the MCP ecosystem. The output README has nine sections: Setup & Configuration, CLAUDE.md Recipes, Prompt Techniques, MCP Servers & Tools, Custom Skills & Commands, Agentic Workflows, IDE & Editor, CI/CD & Automation, and Video Tutorials.

---

## Licence

MIT — see [`LICENSE`](LICENSE).
