---
name: newsletter-ai
description: Curate a newsletter covering agentic AI and LLM news across 12 categories: community (Reddit incl. r/MLOps, Hacker News, X/Twitter), research and alignment safety labs (ARC, CAIUS, Apollo, METR, Redwood, FAR AI, BAIR, AI2, Alignment Forum, LessWrong), technical blogs and infra companies (NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI, Modal, Microsoft Semantic Kernel), AI-only media (MIT Tech Review, Ars Technica, IEEE Spectrum), individual writers (Chollet, Marcus, Wolfe), analyst and VC reports (Gartner, a16z, Sequoia, Brookings), AI security (OWASP, MITRE, NIST, CISA, ENISA, NCSC, Trail of Bits, Lakera, HiddenLayer, Embrace the Red, Snyk Labs), regulatory/policy (EU Commission, UK AISI, FTC, ICO, OSTP, Future of Life Institute, Ada Lovelace Institute, CDT, EFF), agent era (LangChain, Pydantic AI, Composio, HF Agents), open-source infra, macro/hardware (NVIDIA, AMD, Next Platform, Datacenter Dynamics, Chips and Cheese, Fabricated Knowledge), model evaluations (LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval), and newsletters/podcasts as secondary sources (The Batch, Latent Space, TWIML). Use when the user asks for AI news, an LLM digest, an agentic AI roundup, or a newsletter.
argument-hint: "[topic-focus or date-range or vault:~/path or web:~/path/to/astro-site, optional]"
disable-model-invocation: true
allowed-tools: WebSearch, WebFetch, Bash, Write
model: claude-opus-4-6
---

# Agentic AI & LLM Newsletter Curator

You are curating a high-quality weekly newsletter covering agentic AI and large language model developments. Your audience is technical practitioners, researchers, and security professionals.

## Optional focus
$ARGUMENTS

If no arguments are provided, cover the latest developments across all categories below.

---

## Step 1: Gather content from all source categories

Work through each category systematically. For each source, search for content published in the **last 7 days** unless the user specified a different range. Collect at minimum 2–3 items per category.

Refer to [sources.md](sources.md) for the full list of URLs and search queries per category.

### Categories to cover

1. **Community & Discussion** (Reddit incl. r/MLOps, Hacker News, X/Twitter, LinkedIn — named profiles)
2. **Research & Papers** (arXiv, Alignment Forum, LessWrong AI; alignment labs — ARC, CAIUS, Apollo, METR, Redwood, FAR AI; academic labs — BAIR, AI2, EleutherAI; Microsoft Research, Apple ML, Amazon Science)
3. **Technical Blogs & Engineering Posts** (major labs, NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI, Modal, Microsoft Semantic Kernel; MIT Tech Review, Ars Technica, IEEE Spectrum, The Information; Chollet, Marcus, Wolfe + existing writers)
4. **Analyst & Industry Reports** (Gartner, McKinsey, a16z, Sequoia, Brookings, AI Now Institute, OECD AI)
5. **AI Security** (OWASP, MITRE ATLAS, NIST, CISA, ENISA, NCSC, Trail of Bits, Lakera, HiddenLayer, Embrace the Red, Snyk Labs, Microsoft Security)
6. **Product & Company News** (model releases, funding, partnerships)
7. **Regulatory & Policy** (EU Commission, UK AISI, White House OSTP, FTC, UK ICO, Canada AIDA, Future of Life Institute, IAPP, Covington, HSF Kramer, Ada Lovelace Institute, CDT, EFF)
8. **Agent Era & Technical Workflows** (Vellum AI, ByteByteGo, LangChain, Pydantic AI, Composio, HF Agents tag)
9. **Open Source & Specialised Infrastructure** (HuggingFace, vLLM, Ollama, Anyscale, SemiAnalysis)
10. **Macro & Hardware Watch** (NVIDIA primary, AMD AI/ROCm, Next Platform, Datacenter Dynamics, Computing.co.uk, SemiAnalysis, Chips and Cheese, Fabricated Knowledge)
11. **Model Evaluations & Transparency** (LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval, HF Leaderboard, WhatLLM.org)
12. **Newsletters & Podcasts** (secondary sources only — The Batch, Latent Space, TWIML; use to identify stories then cite the primary source)

---

## Step 2: Evaluate and filter each item

For every item you find, assess:

- **Relevance**: Does it relate to agentic AI, LLMs, or AI safety/security?
- **Recency**: Is it from the target period?
- **Signal vs noise**: Is it a meaningful development or just hype?
- **Audience fit**: Would a technical practitioner care about this?

Discard PR fluff, duplicate coverage, and content without substance. Keep only the strongest 3–5 items per category.

---

## Step 3: Write the newsletter

Follow the template in [template.md](template.md) exactly. For each item write:

- A **punchy headline** (not the original title — rewrite it to convey the insight)
- A **2–4 sentence summary** explaining what happened and *why it matters*
- A **direct link** to the primary source
- A **tag** from: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]` `[Eval]` `[Safety]`

---

## Step 4: Add the editor's picks

After all sections, select your **top 3 items** across all categories and write a short "Editor's Picks" intro paragraph (2–3 sentences) explaining why you chose them and what theme ties them together.

---

## Output format

Output the complete newsletter as clean markdown. Do not include your search process or intermediate steps in the output — only the finished newsletter. The newsletter should be ready to paste into an email or publish directly.

---

## Step 5: Write to Obsidian vault

After outputting the newsletter to chat, write a permanent copy to the Obsidian vault.

**Default vault path**: `~/Documents/AI-Newsletter-Vault/`

If the user passed a vault path in their arguments (e.g. `/newsletter-ai vault:~/Obsidian/AI/`), use that path instead.

### 5a. Create directories

```bash
mkdir -p ~/Documents/AI-Newsletter-Vault/issues
mkdir -p ~/Documents/AI-Newsletter-Vault/canvas
mkdir -p ~/Documents/AI-Newsletter-Vault/topics
mkdir -p ~/Documents/AI-Newsletter-Vault/sources
mkdir -p ~/Documents/AI-Newsletter-Vault/articles
```

### 5b. Write the issue note

- Determine the **issue date**: end date of the coverage window in `YYYY-MM-DD` format
- Determine the **ISO week**: `YYYY-Www` format (e.g. `2026-W08`)
- Write `~/Documents/AI-Newsletter-Vault/issues/YYYY-MM-DD.md` following the format in [obsidian-template.md](obsidian-template.md):
  - YAML frontmatter: `date`, `week`, `tags`, `theme` (the one-sentence opening framing), `categories` (list of categories with content this issue), `editor_picks` (the 3 headline titles), `source`
  - Full newsletter body after the frontmatter closing `---`, with **one modification**: replace each section's italic subtitle line with a wikilinked version so Obsidian's Graph View connects the issue to its topic index notes:

| Section | Subtitle line in vault note |
|---|---|
| Community Pulse | `*[[topics/community\|Community]] — What the AI community is talking about this week*` |
| Research Highlights | `*[[topics/research\|Research]] — Papers and findings worth your time*` |
| Engineering & Technical Blogs | `*[[topics/engineering\|Engineering]] — What builders are shipping and writing*` |
| Industry & Analyst Watch | `*[[topics/industry\|Industry]] — Enterprise adoption, market signals, and strategic moves*` |
| AI Security & Safety | `*[[topics/security\|Security]] — Threats, vulnerabilities, frameworks, and defences*` |
| Product & Company News | `*[[topics/product\|Product]] — Model releases, funding, and notable moves*` |
| Regulatory & Policy | `*[[topics/policy\|Policy]] — Laws, frameworks, and compliance moves shaping AI deployment*` |
| Agent Era & Technical Workflows | `*[[topics/agent-era\|Agent Era]] — Patterns, tools, and architectures for building production agents*` |
| Open Source & Infrastructure | `*[[topics/open-source\|Open Source]] — Model rankings, benchmarks, and the stack underneath*` |
| Hardware & Macro Watch | `*[[topics/hardware\|Hardware]] — Chips, compute, and the infrastructure layer*` |
| Model Evaluations & Transparency | `*[[topics/evaluations\|Evaluations]] — How models are being measured, compared, and held accountable*` |

These wikilinks power Obsidian's Graph View: the issue note appears at the centre with edges radiating to each topic node it covered.

In addition, each story **headline** in the vault note should be a wikilink to its article note:
`### [[articles/YYYY-MM-DD-topic-slug|Original Headline]]`

Slug format: `YYYY-MM-DD-{topic}-{2-3-word-title}` (lowercase, hyphens). Example:
`### [[articles/2026-02-20-security-owasp-agentic-top-10|OWASP Publishes the Agentic AI Top 10]]`

This links the issue note directly to individual article notes, completing the four-level graph: issue → topic → source → article.

### 5c. Write canvas mindmaps (first run only)

If `~/Documents/AI-Newsletter-Vault/canvas/newsletter-structure.canvas` does not yet exist:
- Read the content of [newsletter-structure.canvas](newsletter-structure.canvas)
- Write it to `~/Documents/AI-Newsletter-Vault/canvas/newsletter-structure.canvas`

If `~/Documents/AI-Newsletter-Vault/canvas/sources.canvas` does not yet exist:
- Read the content of [sources.canvas](sources.canvas)
- Write it to `~/Documents/AI-Newsletter-Vault/canvas/sources.canvas`

These canvas files are static — they map the newsletter's 13 output sections and the 11 source categories respectively. They are created once and do not change issue to issue.

### 5d. Write vault index (first run only)

If `~/Documents/AI-Newsletter-Vault/_index.md` does not yet exist, write the vault dashboard note as defined in [obsidian-template.md](obsidian-template.md).

### 5f. Write topic index notes (first run only)

If `~/Documents/AI-Newsletter-Vault/topics/community.md` does not yet exist, create all 11 topic index notes as defined in [obsidian-template.md](obsidian-template.md). Each topic note includes wikilinks to its catalogue sources. These are static — created once, not updated per issue.

### 5g. Create article notes

For every story included in the newsletter, write one article note to `~/Documents/AI-Newsletter-Vault/articles/SLUG.md` using the article note format defined in [obsidian-template.md](obsidian-template.md):
- Slug: `YYYY-MM-DD-{topic}-{2-3-word-title}` (lowercase, hyphens)
- YAML frontmatter: `date`, `source` (slug from the source catalogue), `topic` (category slug), `tag`, `url`
- Body: the headline, the 2-4 sentence summary, then `[[sources/slug|Name]] · [[topics/slug|Name]] · [Read more](url)`

### 5h. Create source notes (first run only)

If `~/Documents/AI-Newsletter-Vault/sources/hacker-news.md` does not yet exist, create all source notes as defined in [obsidian-template.md](obsidian-template.md). Each source note has a Dataview query that auto-aggregates all article notes where `source = "slug"`. If a story uses a source not in the catalogue, create a new source note for it.

### 5e. Confirm

After all writes, print:

```
Vault note written → ~/Documents/AI-Newsletter-Vault/issues/YYYY-MM-DD.md
Article notes     → ~/Documents/AI-Newsletter-Vault/articles/ (N notes this issue)
Canvas mindmaps   → ~/Documents/AI-Newsletter-Vault/canvas/ (created on first run)
Topic index notes → ~/Documents/AI-Newsletter-Vault/topics/ (created on first run)
Source notes      → ~/Documents/AI-Newsletter-Vault/sources/ (created on first run)
```

---

## Step 6: Publish to web (optional)

Only run this step if the user passed a `web:` argument (e.g. `/newsletter-ai web:~/my-astro-site`). If no `web:` argument was given, skip this step entirely.

This step publishes the newsletter to an [Astro Paper](https://github.com/satnaing/astro-paper) static site that auto-deploys to Vercel or Netlify on push. One-time setup: create the Astro project, connect it to a GitHub repo, and link that repo to Vercel or Netlify free tier — thereafter every push deploys automatically.

### 6a. Extract the web repo path

Parse the `web:` value from `$ARGUMENTS`, expanding `~` to the user's home directory.

### 6b. Write the issue to the Astro content directory

Write `{WEB_REPO}/src/data/blog/YYYY-MM-DD.md` with Astro Paper-compatible frontmatter and the clean newsletter body.

**Frontmatter** (Astro Paper conventions):

```yaml
---
title: "Agentic AI & LLM Weekly — YYYY-Www"
pubDatetime: YYYY-MM-DDT09:00:00Z
description: "[one-sentence theme from the newsletter's opening framing line]"
tags:
  - newsletter
  - agentic-ai
  - weekly
featured: false
draft: false
---
```

**Body**: Use the clean newsletter markdown from Step 3 verbatim — the same text output to chat. Do **not** include Obsidian wikilinks (`[[...]]`). All section subtitles should be plain italic text (not wikilinked).

### 6c. Push to trigger deployment

```bash
cd {WEB_REPO} && \
  git add src/data/blog/YYYY-MM-DD.md && \
  git commit -m "Newsletter YYYY-MM-DD" && \
  git push
```

Vercel and Netlify pick up the push and deploy within ~30 seconds.

### 6d. Confirm

Append to the confirmation block from Step 5e:

```
Web publish       → {WEB_REPO}/src/data/blog/YYYY-MM-DD.md (pushed)
```
