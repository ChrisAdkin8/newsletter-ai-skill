# How It Works

The `newsletter-ai` skill runs a 6-step curation workflow when you invoke `/newsletter-ai`. It uses `WebSearch` and `WebFetch` to gather content, and `Bash` and `Write` to persist output to an Obsidian vault and (optionally) a public website.

---

## Workflow overview

```
/newsletter-ai [optional arguments]
        │
        ▼
┌─────────────────────────────────┐
│  Step 1: Gather                 │
│  Search all 11 source categories│
│  Target: 2–3 items each         │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│  Step 2: Filter                 │
│  Evaluate relevance, recency,   │
│  signal quality, audience fit   │
│  Keep: 3–5 strongest per cat.   │
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
                 ▼
┌─────────────────────────────────┐
│  Step 5: Obsidian Vault         │
│  Write issue note (+ wikilinks) │
│  Write article notes (per story)│
│  Write source notes (once)      │
│  Write topic notes (once)       │
│  Write canvas + index (once)    │
└────────────────┬────────────────┘
                 │
                 ▼
   ~/Documents/AI-Newsletter-Vault/
                 │
                 ▼  (if web: argument given)
┌─────────────────────────────────┐
│  Step 6: Web Publish (optional) │
│  Write Astro-compatible .md     │
│  git commit + push              │
│  Vercel/Netlify auto-deploys    │
└────────────────┬────────────────┘
                 │
                 ▼
   https://your-site.vercel.app/
```

---

## Step 1: Gather

Claude searches each of the 11 source categories defined in `sources.md`:

1. **Community & Discussion** — Reddit (10 subreddits), Hacker News, X/Twitter (11 key accounts)
2. **Research & Papers** — arXiv, HuggingFace daily papers, Papers with Code, Semantic Scholar; alignment labs (ARC, CAIUS, Apollo, METR, Redwood, FAR AI); academic labs (Stanford HAI, BAIR, AI2, EleutherAI); industry research (Google DeepMind, Microsoft Research, Apple ML, Amazon Science)
3. **Technical Blogs** — Lab blogs, infra companies (NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI), AI-only media (MIT Tech Review, Ars Technica, IEEE Spectrum, The Information), individual writers (Chollet, Marcus, Wolfe + 10 more)
4. **Analyst & Industry** — Gartner, McKinsey, Forrester, a16z, Sequoia, Brookings, Stanford HAI AI Index, Epoch AI, OECD AI, etc.
5. **AI Security** — OWASP, MITRE ATLAS, NIST AI RMF, CISA, ENISA, NCSC, Lakera (blog + research + news), HiddenLayer, Embrace the Red, Snyk Labs (ex-Invariant Labs), Trail of Bits, Microsoft Security
6. **Product & Company News** — Model releases, funding rounds, TechCrunch AI, Axios AI
7. **Regulatory & Policy** — EU Commission, UK AISI, White House OSTP, FTC, UK ICO, Canada AIDA, Future of Life Institute, IAPP, Covington, HSF Kramer
8. **Agent Era & Technical Workflows** — Vellum AI, ByteByteGo, LangChain / LangGraph Blog, Pydantic AI
9. **Open Source & Infrastructure** — HuggingFace, vLLM, Ollama, Anyscale, SemiAnalysis
10. **Macro & Hardware Watch** — NVIDIA (primary), Next Platform, Datacenter Dynamics, Computing.co.uk, SemiAnalysis
11. **Model Evaluations & Transparency** — LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval, HF Open LLM Leaderboard, WhatLLM.org

Default time window: **last 7 days**. Override with arguments, e.g. `/newsletter-ai last 30 days`.

---

## Step 2: Filter

Each candidate item is evaluated against four criteria:

| Criterion | Question asked |
|---|---|
| **Relevance** | Does it relate to agentic AI, LLMs, or AI safety/security? |
| **Recency** | Is it within the target date window? |
| **Signal vs noise** | Is this a meaningful development, or marketing/hype? |
| **Audience fit** | Would a technical practitioner find this useful? |

PR fluff, duplicate coverage (same story from 3 outlets), and content lacking substance are discarded. The goal is **3–5 high-quality items per category**, not exhaustive coverage.

---

## Step 3: Write

For each kept item Claude produces:

- **Rewritten headline** — not the source title; a punchy, insight-first phrase that conveys what matters
- **2–4 sentence summary** — what happened + why it matters to the reader
- **Primary source link** — always links to the original, not an aggregator
- **Tag** — one of: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]` `[Eval]` `[Safety]`

The output follows the structure in `template.md` exactly.

---

## Step 4: Editor's Picks

After all sections are written, Claude selects the **top 3 items** from across all categories and writes a 2–3 sentence paragraph at the top of the newsletter identifying:

- The three picks
- The theme or thread connecting them this week

This runs last so the picks are chosen with full visibility of everything gathered.

---

## Step 5: Obsidian vault

After outputting the newsletter to chat, Claude writes a permanent copy to the Obsidian vault at `~/Documents/AI-Newsletter-Vault/` (configurable — see [customising.md](customising.md)).

### Issue note

Each issue is saved as `issues/YYYY-MM-DD.md` with YAML frontmatter:

```yaml
---
date: 2026-02-20
week: 2026-W08
tags:
  - newsletter
  - agentic-ai
  - weekly
theme: "One-sentence framing of the dominant theme"
categories: [community, research, engineering, ...]
editor_picks:
  - "Pick 1 headline"
  - "Pick 2 headline"
  - "Pick 3 headline"
source: claude-code-newsletter-ai-skill
---
```

The full newsletter body follows immediately — identical to the chat output.

### Four-level Graph View: issue → topic → source → article

The vault implements a four-level graph hierarchy navigable in Obsidian's built-in **Graph View** (`Cmd+G`):

```
Issue note ──► Topic note ──► Source note ◄── Article note
```

**Level 1 — Issue note** (`issues/YYYY-MM-DD.md`)
- Section subtitle wikilinks: `[[topics/security|Security]]`
- Story headline wikilinks: `[[articles/2026-02-20-security-owasp-agentic-top-10|...]]`

**Level 2 — Topic notes** (`topics/*.md`, created on first run, 11 total)
- Sources line with wikilinks to every source in that category: `[[sources/owasp|OWASP]] · [[sources/trail-of-bits|Trail of Bits]] · ...`

**Level 3 — Source notes** (`sources/*.md`, created on first run, ~45 total)
- Persistent hub for each publication or organisation
- Dataview query auto-aggregates all articles from that source: `WHERE source = "owasp"`

**Level 4 — Article notes** (`articles/YYYY-MM-DD-slug.md`, created each run, one per story)
- Full headline + summary for each newsletter story
- Footer wikilinks back to source and topic: `[[sources/owasp|OWASP]] · [[topics/security|Security]]`

As issues accumulate, sources with many articles form denser clusters and topics that are covered every week attract more connections — making the graph a live map of coverage patterns over time.

### Canvas mindmaps (created once)

On the first run, two Obsidian Canvas mindmaps are written to `canvas/`:

| File | What it maps |
|---|---|
| `newsletter-structure.canvas` | 13 output sections, their tags, and how they connect |
| `sources.canvas` | 11 source categories and all 100+ sources within each |

Canvas files are static — they describe the system structure and are only written on first run. You can rearrange nodes freely in Obsidian without affecting the skill.

### Vault dashboard

`_index.md` is created on first run with Dataview queries for browsing all issues and links to all topic index notes.

---

## Step 6: Web publish (optional)

Only runs when you pass a `web:` argument: `/newsletter-ai web:~/my-astro-site`.

Claude writes the issue as an [Astro Paper](https://github.com/satnaing/astro-paper)-compatible markdown file to `{WEB_REPO}/src/data/blog/YYYY-MM-DD.md` with the correct frontmatter, then runs `git commit && git push`. Vercel or Netlify picks up the push and deploys the site automatically — typically within 30 seconds.

The web version uses the clean newsletter body from Step 3 (identical to the chat output). Obsidian wikilinks are not included.

**Frontmatter written for Astro Paper:**

```yaml
---
title: "Agentic AI & LLM Weekly — YYYY-Www"
pubDatetime: YYYY-MM-DDT09:00:00Z
description: "[one-sentence theme]"
tags:
  - newsletter
  - agentic-ai
  - weekly
featured: false
draft: false
---
```

**One-time setup** (outside the skill):
1. `npm create astro@latest -- --template satnaing/astro-paper`
2. Push to a GitHub repo
3. Connect the repo to [Vercel](https://vercel.com) or [Netlify](https://netlify.com) free tier

After that, every `/newsletter-ai web:~/my-astro-site` run auto-publishes. See [Customising → Web publishing](customising.md#web-publishing-astro--vercel) for full details.

---

## File roles

| File | Role |
|---|---|
| `SKILL.md` | Main entry point. Defines the workflow and tells Claude which supporting files exist. |
| `sources.md` | Reference catalogue of URLs and search strategies per category. Claude reads this during Step 1. |
| `template.md` | Exact output format for the newsletter. Claude follows this during Steps 3–4. |
| `obsidian-template.md` | Vault note format: YAML frontmatter schema, wikilink table, topic note template, and vault directory structure. Claude follows this during Step 5. |
| `newsletter-structure.canvas` | Pre-built Obsidian Canvas JSON mapping the 13 newsletter sections. Written to vault on first run. |
| `sources.canvas` | Pre-built Obsidian Canvas JSON mapping all 11 source categories. Written to vault on first run. |

---

## Invocation behaviour

The skill has `disable-model-invocation: true`, meaning Claude will **not** trigger it automatically during a conversation. It only runs when you explicitly type `/newsletter-ai`. This prevents it from firing unintentionally during normal chat about AI topics.

Argument passing:

```
/newsletter-ai                                          # Full newsletter, last 7 days
/newsletter-ai security only                            # Filters to security category
/newsletter-ai last 14 days                             # Extends the time window
/newsletter-ai open-source models only                  # Topic-scoped
/newsletter-ai vault:~/Obsidian/AI-News/                # Custom vault path
/newsletter-ai web:~/my-astro-site                      # Auto-publish to website
/newsletter-ai vault:~/Obsidian/ web:~/my-astro-site    # Both vault and web
```
