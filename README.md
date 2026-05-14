# newsletter-ai

> A Claude Code skill that curates a weekly newsletter on agentic AI and LLM developments. Outputs a clean Markdown digest to chat, writes a permanent copy to an Obsidian vault, and (optionally) publishes a public website using Hugo + PaperMod on Cloudflare Pages — zero npm dependencies in the build.

Invoke `/newsletter-ai` and Claude searches eleven source categories — community discussion, research papers, engineering blogs, analyst reports, AI security, product news, regulation, agent frameworks, open source, hardware, and model evaluations — then produces a digest with rewritten headlines, two-to-four sentence summaries, a connecting "Editor's Picks" theme, and a tag on every item.

The full annotated source list lives in [`docs/sources.md`](docs/sources.md).

---

## What you get

| Output | Where it lands | When |
|---|---|---|
| Markdown newsletter | Chat | Every run |
| Obsidian vault | `~/Documents/AI-Newsletter-Vault/` | Every local run (configurable) |
| Public website | Cloudflare Pages | When you pass `web:./site` (or any Hugo + PaperMod repo path) |

### Output preview

````markdown
# Agentic AI & LLM Weekly
**Issue #20 — 7–14 May 2026**

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

The full workflow — gather, filter, write, editor's picks, vault, web — is documented in [`docs/how-it-works.md`](docs/how-it-works.md).

---

## Quick start

**1. Install the skill globally:**

```bash
cp -r .claude/skills/newsletter-ai/ ~/.claude/skills/newsletter-ai/
```

**2. Run it:**

```
/newsletter-ai
```

**Invocation patterns:**

```
/newsletter-ai                                          # Last 7 days, all 11 categories
/newsletter-ai security focus — last 14 days            # Topic + extended window
/newsletter-ai agentic frameworks only                  # Topic-scoped
/newsletter-ai vault:~/Obsidian/AI-News/                # Custom vault path
/newsletter-ai web:./site                               # Publish via the bundled site/
/newsletter-ai web:~/my-hugo-site                       # Publish to a separate Hugo repo
/newsletter-ai vault:~/Obsidian/AI-News/ web:./site     # Vault + web in one run
```

---

## Obsidian vault

Every local run writes the issue to an Obsidian vault that implements a four-level graph hierarchy:

```
Issue note → Topic note → Source note ← Article note
```

On first run the skill creates eleven topic index notes, ~65 source notes, two Canvas mindmaps, and a vault dashboard. Each subsequent run adds one issue note plus one article note per story. Open Graph View (`Cmd+G`) to see the live coverage map — sources with many articles form denser clusters; topics covered every week pull more connections.

Format details: [`docs/how-it-works.md#step-5-obsidian-vault`](docs/how-it-works.md#step-5-obsidian-vault).

---

## Publishing to the web

This repo includes everything needed to host the newsletter as a static site on [Cloudflare Pages](https://pages.cloudflare.com/) — free tier, unlimited bandwidth. The site uses **[Hugo](https://gohugo.io) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod)**: one signed Go binary plus one vendored theme. No npm tree, no transitive dependencies, ~5 MB to audit instead of ~700 packages.

**Prerequisites:** install Hugo Extended locally (`brew install hugo` on macOS).

**One-time setup:**

```bash
./site/scripts/bootstrap.sh                      # Scaffold Hugo + PaperMod into site/
git add site/ && git commit -m "Scaffold site" && git push
```

Then connect this repo to Cloudflare Pages (see [`site/README.md`](site/README.md) for the exact dashboard settings — Hugo framework preset, `HUGO_VERSION` env var) and add `ANTHROPIC_API_KEY` to **Settings → Secrets and variables → Actions**.

After that, the scheduled workflow at [`.github/workflows/newsletter.yml`](.github/workflows/newsletter.yml) runs every Friday at 09:00 UTC. It generates the newsletter, commits to `site/content/posts/`, and pushes — Cloudflare Pages deploys within ~30 seconds. Manual runs are available any time from the **Actions** tab.

**Supply-chain story**: Hugo is a single Go binary distributed with SHA256SUMS. PaperMod is vendored as a frozen copy pinned to a known commit SHA (recorded in `site/themes/PaperMod/.papermod-sha`). No `npm install` ever runs in this repo for the website build. The only npm exposure is the Claude Code CLI installed in CI, pinned to a specific version with `--ignore-scripts`. Dependabot scans GitHub Actions versions weekly.

Vercel and Netlify both support Hugo natively if you prefer them over Cloudflare Pages.

---

## Repository structure

```
newsletter-ai-skill/
├── .claude/skills/newsletter-ai/        # Skill source — SKILL.md + sources + templates + canvas
├── .claude/skills/claude-hacks/         # Companion skill (see below)
├── docs/
│   ├── how-it-works.md                  # 6-step workflow, vault structure, web publish
│   ├── sources.md                       # Annotated source catalogue (human-readable)
│   └── customising.md                   # Adding sources, format changes, scheduling
├── site/                                # Hugo + PaperMod static site
│   ├── README.md                        # Bootstrap + Cloudflare Pages dashboard setup
│   └── scripts/bootstrap.sh             # Scaffold Hugo site, vendor PaperMod at pinned ref
├── .github/
│   ├── workflows/newsletter.yml         # Weekly cron — generate, commit, deploy
│   └── dependabot.yml                   # Weekly npm + GitHub Actions CVE scans
├── CLAUDE.md                            # Project-local Claude Code rules
└── README.md                            # This file
```

The skill files in `.claude/skills/newsletter-ai/` are the source of truth — they are copied to `~/.claude/skills/newsletter-ai/` for global use. See [`CLAUDE.md`](CLAUDE.md#updating-the-skill) for the sync command.

---

## Documentation

| Doc | Covers |
|---|---|
| [`docs/how-it-works.md`](docs/how-it-works.md) | The 6-step workflow, Obsidian vault format, web publish step |
| [`docs/sources.md`](docs/sources.md) | Annotated source catalogue across all 11 categories, with search strategies |
| [`docs/customising.md`](docs/customising.md) | Adding sources, output format, vault path, web publishing, scheduled automation |
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
