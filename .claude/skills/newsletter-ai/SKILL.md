---
name: newsletter-ai
description: Curate a newsletter covering agentic AI and LLM news across 12 categories: community (Reddit incl. r/MLOps, Hacker News, X/Twitter), research and alignment safety labs (ARC, CAIUS, Apollo, METR, Redwood, FAR AI, BAIR, AI2, Alignment Forum, LessWrong), technical blogs and infra companies (NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI, Modal, Microsoft Semantic Kernel), AI-only media (MIT Tech Review, Ars Technica, IEEE Spectrum), individual writers (Chollet, Marcus, Wolfe), analyst and VC reports (Gartner, a16z, Sequoia, Brookings), AI security (OWASP, MITRE, NIST, CISA, ENISA, NCSC, Trail of Bits, Lakera, HiddenLayer, Embrace the Red, Snyk Labs), regulatory/policy (EU Commission, UK AISI, FTC, ICO, OSTP, Future of Life Institute, Ada Lovelace Institute, CDT, EFF), agent era (LangChain, Pydantic AI, Composio, HF Agents), open-source infra, macro/hardware (NVIDIA, AMD, Next Platform, Datacenter Dynamics, Chips and Cheese, Fabricated Knowledge), model evaluations (LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval), and newsletters/podcasts as secondary sources (The Batch, Latent Space, TWIML). Use when the user asks for AI news, an LLM digest, an agentic AI roundup, or a newsletter.
argument-hint: "[topic-focus, optional] [web:<hugo-site>] [date:YYYY-MM-DD] [week:YYYY-Www]"
disable-model-invocation: true
allowed-tools: WebSearch, WebFetch, Read
---

# Agentic AI & LLM Newsletter Curator

You are curating a high-quality weekly newsletter covering agentic AI and large language model developments. Your audience is technical practitioners, researchers, and security professionals.

## Arguments
$ARGUMENTS

- `web:<path>`: the Hugo site to write the post into (Step 6). Without it, the newsletter is only printed.
- `date:<YYYY-MM-DD>` and `week:<YYYY-Www>`: the issue date and week (Step 6a).
- Anything else is a topic focus. If there is none, cover the latest developments across all categories below.

## Run rules

- **No parallel subagents for gathering** — search all 12 categories sequentially in the main session.
- **WebSearch before WebFetch** — use snippets to identify stories; only fetch when snippet lacks enough detail. One fetch per story maximum.
- **One query per category** — if first query returns 3+ usable results, move on. Skip sections with nothing newsworthy.
- **No intermediate output** — output only the finished newsletter, then the line from Step 6c.
- **Cap at 4 items per category.**

---

## Step 1: Gather content from all source categories

Work through each category systematically. For each source, search for content published in the window: the **7 days up to the issue date** (Step 6a). Collect at minimum 2–3 items per category.

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

Discard PR fluff, duplicate coverage, and content without substance. Keep only the strongest items, up to the cap in the run rules.

### Hard rules

An item that breaks any of these is out, however strong it is. With `web:`, the post is checked against them after the run by `scripts/check_issue.py`, and a post that fails isn't published.

1. **Nothing from the last four posts.** With `web:`, list `<web>/content/posts/*.md` and read the last four posts before the issue date, by filename. Drop any item whose URL appears in them, or whose story they already covered under another URL.
2. **No story twice.** Each story appears once in the issue, and each URL once, Quick Links included. When several outlets cover one story, pick one.
3. **Dated inside the window.** The item's own publication date must be on or after the window start, 7 days before the issue date. The date of an event it reports doesn't count. A URL that carries an earlier date is out even if the page was updated since: a day (`/2026/04/24/`, `2025-08-26-…`), or a month with no day (`/2025/12/`) when that whole month is before the start. So is an arXiv paper whose ID month is wholly before the start (`2604.xxxxx` for a May window), even if a new version appeared this week.
4. **Article URLs only.** Link to the page that carries the story, never a homepage, blog index or docs root such as `https://blog.example.com/`.
5. **Label the publisher of the linked page.** In `[Source: [Label](URL)]`, the label names whoever publishes the page at that URL. A dev.to post about a Reddit thread is "DEV Community", not "Reddit"; The Register's story about a Microsoft Research paper is "The Register". Only use Reddit, Hacker News, arXiv, GitHub, X or Microsoft Research for links on their own domains.
6. **No press-release wires.** Skip GlobeNewswire, PR Newswire, Business Wire, EIN Presswire and ACCESSWIRE. Cite the company's own announcement or independent coverage instead.

---

## Step 3: Write the newsletter

Follow the template in [template.md](template.md) exactly. For each item write:

- A **punchy headline** (not the original title — rewrite it to convey the insight)
- A **2–4 sentence summary** explaining what happened and *why it matters*
- A **direct link** to the primary source, labelled with its publisher (Step 2, rule 5)
- A **tag** from: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]` `[Eval]` `[Safety]`

---

## Step 4: Add the editor's picks

After all sections, select your **top 3 items** across all categories and write a short "Editor's Picks" intro paragraph (2–3 sentences) explaining why you chose them and what theme ties them together.

---

## Output format

Output the complete newsletter as clean markdown. Do not include your search process or intermediate steps in the output — only the finished newsletter. The newsletter should be ready to paste into an email or publish directly.

---

## Step 6: Write the post

### 6a. Issue date and week

These apply to every run, with or without `web:`.

- **Issue date**: the `date:` argument if given, otherwise today, as `YYYY-MM-DD`.
- **Week**: the `week:` argument if given, otherwise the ISO week of the date four days before the issue date, as `YYYY-Www` (e.g. `2026-W08`). Issues from Friday to Thursday share a week.

### 6b. Write the issue to the Hugo content directory

Only with a `web:` argument (e.g. `web:~/my-hugo-site`, or `web:./site` for this repo's built-in site); without one, skip 6b and 6c. Expand `~` to the user's home directory.

Write `<web>/content/posts/<issue date>.md` with Hugo + PaperMod-compatible frontmatter and the clean newsletter body.

**Frontmatter** (Hugo + PaperMod conventions):

```yaml
---
title: "Agentic AI & LLM Weekly — YYYY-Www"
date: YYYY-MM-DDT09:00:00Z
draft: false
summary: "[one-sentence theme from the newsletter's opening framing line]"
description: "[same as summary — used in <meta> tags]"
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

`YYYY-Www` is the week and `YYYY-MM-DD` the issue date, both from 6a.

**Body**: Use the clean newsletter markdown from Step 3 verbatim — the same text output to chat.

Write only this file. Don't commit or publish it: whoever ran the skill checks the post and publishes it (`scripts/weekly.sh` does both for scheduled runs).

### 6c. Confirm

Print the path you wrote:

```
Post written → <web>/content/posts/YYYY-MM-DD.md
```
