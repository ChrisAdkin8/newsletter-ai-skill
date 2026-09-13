# How It Works

The `newsletter-ai` skill runs a 6-step curation workflow when you invoke `/newsletter-ai`. It uses `WebSearch` and `WebFetch` to gather content and `Read` for its own supporting files. With `web:` it writes the issue as a post in a Hugo site; publishing that post is left to whoever ran it, which for scheduled runs is `scripts/weekly.sh`.

---

## Workflow overview

```
/newsletter-ai [optional arguments]
        │
        ▼
┌─────────────────────────────────┐
│  Step 1: Gather                 │
│  Search all 14 source categories│
│  Target: 2–3 items each         │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│  Step 2: Filter                 │
│  Relevance, recency, signal,    │
│  audience fit + hard rules      │
│  Keep: up to 4 per category     │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│  Step 3: Write                  │
│  Rewrite headlines as insights  │
│  2–4 sentence summaries         │
│  Tag each item                  │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│  Step 4: Editor's Picks         │
│  Select top 3 cross-category    │
│  Write connecting theme intro   │
└────────────────┬────────────────┘
                 │
                 ▼
        Markdown newsletter
        (output to chat)
                 │
                 ▼  (if triage: argument given)
┌─────────────────────────────────┐
│  Step 5: Triage                 │
│  Up to 5 items matching         │
│  interests.txt → triage.md      │
└────────────────┬────────────────┘
                 │
                 ▼  (if web: argument given)
┌─────────────────────────────────┐
│  Step 6: Write the post         │
│  Hugo-compatible .md, named     │
│  for the issue date             │
└────────────────┬────────────────┘
                 │
                 ▼
   site/content/posts/YYYY-MM-DD.md
```

When `scripts/weekly.sh` runs the skill, it then checks the post, commits and pushes it, and Cloudflare Pages deploys it (see [Publishing](#publishing)).

---

## Step 1: Gather

Claude searches each of the 14 source categories defined in `sources.md`:

1. **Community & Discussion** — Reddit (10 subreddits), Hacker News, X/Twitter (11 key accounts)
2. **Research & Papers** — arXiv, HuggingFace daily and trending papers, Semantic Scholar; alignment labs (ARC, CAIS, Apollo, METR, Redwood, FAR AI); academic labs (Stanford HAI, BAIR, AI2, EleutherAI); industry research (Google DeepMind, Microsoft Research, Apple ML, Amazon Science)
3. **Technical Blogs** — Lab blogs, infra companies (NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI), AI-only media (MIT Tech Review, Ars Technica, IEEE Spectrum, The Information), individual writers (Chollet, Marcus, Wolfe + 10 more)
4. **Analyst & Industry** — Gartner, McKinsey, Forrester, a16z, Sequoia, Brookings, Stanford HAI AI Index, Epoch AI, OECD AI, etc.
5. **AI Security** — OWASP, MITRE ATLAS, NIST AI RMF, CISA, ENISA, NCSC, Lakera (blog + research + news), HiddenLayer, Embrace the Red, Snyk Labs (ex-Invariant Labs), Trail of Bits, Microsoft Security
6. **Product & Company News** — Model releases, funding rounds, TechCrunch AI, Axios AI
7. **Regulatory & Policy** — EU Commission, UK AISI, White House OSTP, FTC, UK ICO, Canada, Future of Life Institute, IAPP, Covington, HSF Kramer
8. **Agent Era & Technical Workflows** — Vellum AI, ByteByteGo, LangChain / LangGraph Blog, Pydantic AI
9. **Open Source & Infrastructure** — HuggingFace, vLLM, Ollama, Anyscale, SemiAnalysis
10. **Macro & Hardware Watch** — NVIDIA (primary), Next Platform, Datacenter Dynamics, Computing.co.uk, SemiAnalysis
11. **Model Evaluations & Transparency** — LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval, HF Open LLM Leaderboard, WhatLLM.org
12. **Newsletters & Podcasts** — The Batch, Latent Space, TWIML; secondary sources only, used to find stories whose primary source is then cited
13. **Cloud Native & CNCF** — CNCF blog and announcements, Kubernetes blog, LWKD; AI-on-Kubernetes projects (Kubeflow, KServe, llm-d, kagent, KAITO, Volcano, HAMi, Dapr, OpenTelemetry); The New Stack
14. **Trending Open Source AI** — projects gaining traction this week, from GitHub Trending, OSS Insight, Trendshift, Hugging Face trending, Show HN and OpenRouter rankings; each item states its evidence and cites the project itself

The window is the **7 days up to the issue date**. The issue date is today unless `date:` sets it.

---

## Step 2: Filter

Each candidate item is evaluated against four criteria:

| Criterion | Question asked |
|---|---|
| **Relevance** | Does it relate to agentic AI, LLMs, or AI safety/security? |
| **Recency** | Is it within the target date window? |
| **Signal vs noise** | Is this a meaningful development, or marketing/hype? |
| **Audience fit** | Would a technical practitioner find this useful? |

PR fluff, duplicate coverage (same story from 3 outlets), and content lacking substance are discarded. The goal is **up to 4 high-quality items per category**, not exhaustive coverage.

Then come hard rules. `scripts/check_issue.py` enforces most of them on the finished post; it compares URLs only, so a story repeated under a different URL is caught by the model's rule alone:

| Rule | Checker rule |
|---|---|
| No URL, or story, from the last four posts | `repeat` (same URL only) |
| No story or URL twice in the issue | `repeat` (same URL only) |
| The item's own date is inside the window; URL dates and arXiv IDs count | `stale` |
| Article URLs, never homepages | `homepage` |
| The label names the publisher of the linked page | `label` |
| No press-release wires | `wire` |
| Primary or specialist outlets; nothing from the "Don't cite" list in `sources.md` | none: the model's rule |

---

## Step 3: Write

For each kept item Claude produces:

- **Rewritten headline** — not the source title; a punchy, insight-first phrase that conveys what matters
- **2–4 sentence summary** — what happened + why it matters to the reader
- **Primary source link** — always links to the original, not an aggregator, labelled with its publisher
- **Tag** — one of: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]` `[Eval]` `[Safety]`

The output follows the structure in `template.md` exactly.

---

## Step 4: Editor's Picks

After all sections are written, Claude selects the **top 3 items** from across all categories and writes a 2–3 sentence paragraph at the top of the newsletter identifying:

- The three picks
- The theme or thread connecting them this week

This runs last so the picks are chosen with full visibility of everything gathered.

---

## Step 5: Triage (optional)

Only runs with a `triage:<dir>` argument, which `scripts/weekly.sh` passes. Claude reads `<dir>/interests.txt` and writes `<dir>/triage.md`: up to five items, from the issue or cut from it for space, that match those interests. Each is one line, `- [title](url): why it matches`, with no commands.

After a successful publish, `weekly.sh` keeps only lines in that exact form, drops any whose URL is already somewhere in `~/notes`, appends a `/research quick <url>` command to each, and writes the result to `~/notes/inbox/<date>-newsletter-triage.md`. The model itself never reads or writes `~/notes`.

---

## Step 6: Write the post (optional)

Only runs when you pass a `web:` argument:

- `/newsletter-ai web:./site` — this repo's bundled Hugo + PaperMod site (auto-deploys to Cloudflare Pages)
- `/newsletter-ai web:~/my-hugo-site` — your own separate Hugo repo

Claude writes the issue as a [Hugo](https://gohugo.io) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod)-compatible markdown file to `{WEB_REPO}/content/posts/YYYY-MM-DD.md`, named for the issue date, and prints its path. It doesn't commit or push.

The issue date is the `date:` argument, or today. The week in the title is the `week:` argument, or the ISO week of the date four days before the issue date, so issues from Friday to Thursday share a week.

**Frontmatter written for Hugo + PaperMod:**

```yaml
---
title: "Agentic AI & LLM Weekly — YYYY-Www"
date: YYYY-MM-DDT09:00:00Z
draft: false
summary: "[one-sentence theme]"
description: "[same as summary]"
tags:
  - newsletter
  - agentic-ai
  - weekly
ShowToc: true
TocOpen: false
ShowReadingTime: true
ShowBreadCrumbs: true
---
```

The body is the clean newsletter from Step 3, identical to the chat output.

**One-time setup** (outside the skill):
1. Install Hugo Extended locally (`brew install hugo` on macOS, see [Hugo releases](https://github.com/gohugoio/hugo/releases) for other platforms)
2. Run `./site/scripts/bootstrap.sh` to scaffold the bundled Hugo + PaperMod site (or follow [Customising → Option B](customising.md#option-b--separate-hugo-repo-manual-local-publishing) for a separate repo)
3. Push to GitHub
4. Connect the repo to [Cloudflare Pages](https://dash.cloudflare.com/) — set `HUGO_VERSION` in the build environment

See [Customising → Web publishing](customising.md#web-publishing-hugo--papermod-on-cloudflare-pages) for full details.

---

## Publishing

`scripts/weekly.sh` turns a run into a published issue. launchd runs it twice a day (see [Customising → Scheduled publishing (launchd)](customising.md#scheduled-publishing-launchd)), and you can run it by hand. It publishes at most one issue per week:

1. It runs a pinned copy of the Claude Code CLI with `--restricted`, the skill loaded from `.claude/` as a plugin, no shell, no MCP servers, and file writes allowed only under `site/content/posts/` and `.newsletter/`.
2. It holds the issue unless the only change in the tree is the new post and `scripts/check_issue.py` passes it.
3. It commits `Newsletter <date>` and pushes. Cloudflare Pages deploys within about 30 seconds.
4. It moves the triage note into `~/notes/inbox/` and sends a notification with the run's cost.

A held issue stays uncommitted, and you get a notification. It blocks later runs until you deal with it.

---

## File roles

| File | Role |
|---|---|
| `SKILL.md` | Main entry point. Defines the workflow, run rules and hard rules, and tells Claude which supporting files exist. |
| `sources.md` | Reference catalogue of URLs and search strategies per category. Claude reads this during Step 1. |
| `template.md` | Exact output format for the newsletter. Claude follows this during Steps 3–4. |
| `scripts/check_issue.py` | Checks a post against the hard rules; `weekly.sh` runs it before publishing. |
| `scripts/weekly.sh` | Runs the skill headless, checks the post, owns git, and moves triage. |
| `scripts/interests.txt` | The interests Step 5 matches triage items against. |

---

## Invocation behaviour

The skill has `disable-model-invocation: true`, meaning Claude will **not** trigger it automatically during a conversation. It only runs when you explicitly type `/newsletter-ai`. This prevents it from firing unintentionally during normal chat about AI topics. Headless runs load the same skill as `/newsletter:newsletter-ai`, through `--plugin-dir .claude`.

Argument passing:

```
/newsletter-ai                                          # Full newsletter, last 7 days
/newsletter-ai security only                            # Filters to security category
/newsletter-ai open-source models only                  # Topic-scoped
/newsletter-ai web:./site                               # Write the post into this repo's bundled site
/newsletter-ai web:~/my-hugo-site                       # Write it into a separate Hugo + PaperMod repo
/newsletter-ai web:./site date:2026-09-18 week:2026-W37 # Set the issue date and week
```
