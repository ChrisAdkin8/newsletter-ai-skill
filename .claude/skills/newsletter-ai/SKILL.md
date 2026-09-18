---
name: newsletter-ai
description: Curate a newsletter covering agentic AI and LLM news across 14 categories: community (Reddit incl. r/MLOps, Hacker News, X/Twitter), research and alignment safety labs (ARC, CAIS, Apollo, METR, Redwood, FAR AI, BAIR, AI2, Alignment Forum, LessWrong), technical blogs and infra companies (NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI, Modal, Microsoft Semantic Kernel), AI-only media (MIT Tech Review, Ars Technica, IEEE Spectrum), individual writers (Chollet, Marcus, Wolfe), analyst and VC reports (Gartner, a16z, Sequoia, Brookings), AI security (OWASP, MITRE, NIST, CISA, ENISA, NCSC, Trail of Bits, Lakera, HiddenLayer, Embrace the Red, Snyk Labs), regulatory/policy (EU Commission, UK AISI, FTC, ICO, OSTP, Future of Life Institute, Ada Lovelace Institute, CDT, EFF), agent era (LangChain, Pydantic AI, Composio, HF Agents), open-source infra, macro/hardware (NVIDIA, AMD, Next Platform, Datacenter Dynamics, Chips and Cheese, Fabricated Knowledge), model evaluations (LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval), newsletters/podcasts as secondary sources (The Batch, Latent Space, TWIML), cloud native AI (CNCF, Kubernetes, Kubeflow, KServe, llm-d, kagent, OpenTelemetry), and open-source AI projects gaining traction (GitHub Trending, OSS Insight, Hugging Face trending, OpenRouter rankings). Use when the user asks for AI news, an LLM digest, an agentic AI roundup, or a newsletter.
argument-hint: "[topic-focus, optional] [web:<hugo-site>] [date:YYYY-MM-DD] [week:YYYY-Www] [triage:<dir>]"
disable-model-invocation: true
allowed-tools: WebSearch, WebFetch, Read
---

# Agentic AI & LLM Newsletter Curator

You are curating a high-quality weekly newsletter covering agentic AI and large language model developments. Your audience is technical practitioners, researchers, and security professionals.

## Arguments
$ARGUMENTS

- `web:<path>`: the Hugo site to write the post into (Step 6). Without it, the newsletter is only printed.
- `date:<YYYY-MM-DD>` and `week:<YYYY-Www>`: the issue date and week (Step 6a).
- `triage:<dir>`: read `<dir>/interests.txt` and write `<dir>/triage.md` (Step 5). Without it, skip Step 5.
- Anything else is a topic focus. If there is none, cover the latest developments across all categories below.

## Run rules

- **No parallel subagents for gathering** — search all 14 categories sequentially in the main session.
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
2. **Research & Papers** (arXiv, Alignment Forum, LessWrong AI; alignment labs — ARC, CAIS, Apollo, METR, Redwood, FAR AI; academic labs — BAIR, AI2, EleutherAI; Microsoft Research, Apple ML, Amazon Science)
3. **Technical Blogs & Engineering Posts** (major labs, NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI, Modal, Microsoft Semantic Kernel; MIT Tech Review, Ars Technica, IEEE Spectrum, The Information; Chollet, Marcus, Wolfe + existing writers)
4. **Analyst & Industry Reports** (Gartner, McKinsey, a16z, Sequoia, Brookings, AI Now Institute, OECD AI)
5. **AI Security** (OWASP, MITRE ATLAS, NIST, CISA, ENISA, NCSC, Trail of Bits, Lakera, HiddenLayer, Embrace the Red, Snyk Labs, Microsoft Security)
6. **Product & Company News** (model releases, funding, partnerships)
7. **Regulatory & Policy** (EU Commission, UK AISI, White House OSTP, FTC, UK ICO, Canada, Future of Life Institute, IAPP, Covington, HSF Kramer, Ada Lovelace Institute, CDT, EFF)
8. **Agent Era & Technical Workflows** (Vellum AI, ByteByteGo, LangChain, Pydantic AI, Composio, HF Agents tag)
9. **Open Source & Specialised Infrastructure** (HuggingFace, vLLM, Ollama, Anyscale, SemiAnalysis)
10. **Macro & Hardware Watch** (NVIDIA primary, AMD AI/ROCm, Next Platform, Datacenter Dynamics, Computing.co.uk, SemiAnalysis, Chips and Cheese, Fabricated Knowledge)
11. **Model Evaluations & Transparency** (LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval, HF Leaderboard, WhatLLM.org)
12. **Newsletters & Podcasts** (secondary sources only — The Batch, Latent Space, TWIML; use to identify stories then cite the primary source)
13. **Cloud Native & CNCF** (CNCF blog and announcements, Kubernetes blog, LWKD; AI-on-Kubernetes projects — Kubeflow, KServe, llm-d, kagent, KAITO, Volcano, HAMi, Dapr, OpenTelemetry; The New Stack)
14. **Trending Open Source AI** (projects gaining stars, downloads or users this week — GitHub Trending, OSS Insight, Trendshift, Hugging Face trending, Show HN, OpenRouter rankings; fetch GitHub Trending and OSS Insight directly, since they're lists, not stories)

---

## Step 2: Evaluate and filter each item

For every item you find, assess:

- **Relevance**: Does it relate to agentic AI, LLMs, or AI safety/security?
- **Recency**: Is it from the target period?
- **Signal vs noise**: Is it a meaningful development or just hype?
- **Audience fit**: Would a technical practitioner care about this?

Discard PR fluff, duplicate coverage, and content without substance. Keep only the strongest items, up to the cap in the run rules.

Then spread the issue out, so two weeks don't read the same:

- **At most one item per publisher per section.** If a section's best two items are both from the same blog, keep the stronger and find the second elsewhere, or run the section short. This counts editorial voices, not hosts: arXiv, GitHub and Hugging Face are venues anyone can publish on, so several papers or repositories in one section are fine. Without that, Research Highlights and Open Source on the Rise would each be capped at one item.
- **No pivot phrase or case-study company from last week's issue.** Read the previous issue before writing. If it turned on "the real story is", "what this means in practice" or the like, or built a point around a named company's deployment, use neither again this week.

### Hard rules

An item that breaks any of these is out, however strong it is. With `web:`, `scripts/check_issue.py` checks the post after the run, and a post that fails isn't published. It reads URLs and labels, so it catches a banned outlet, a rolling index, a repeated URL, a date outside the window, a wire and a mislabelled publisher. It can't see one story under two URLs, whether a page is a rewrite of something it links to, or how many items a section takes from one publisher: those are yours to keep.

1. **Primary or specialist outlets only.** Never cite investment or personal-finance sites, syndicated finance pages, fan sites, crypto outlets for stories that aren't about crypto, or a rewrite of a primary source you could cite directly (see "Don't cite" in [sources.md](sources.md)). If a category has nothing better, skip it. The checker holds the issue for the outlets banned outright, and prints a warning — which doesn't hold anything — for a handful of outlets that habitually rewrite. It can't tell a rewrite from original reporting, so a page that credits and links a primary source is yours to catch: cite what it links.
2. **Nothing from the last four posts.** With `web:`, list `<web>/content/posts/*.md` and read the last four posts before the issue date, by filename. Drop any item whose URL appears in them, or whose story they already covered under another URL.
3. **No story twice.** Each story appears once in the issue, and each URL once, Quick Links included. When several outlets cover one story, pick one.
4. **Dated inside the window.** The item's own publication date must be on or after the window start, 7 days before the issue date. The date of an event it reports doesn't count. A URL that carries an earlier date is out even if the page was updated since: a day (`/2026/04/24/`, `2025-08-26-…`), or a month with no day (`/2025/12/`) when that whole month is before the start. So is an arXiv paper whose ID month is wholly before the start (`2604.xxxxx` for a May window), even if a new version appeared this week. In Trending Open Source AI, the item is the project's growth in the window: link the repository or a release from the window, and state the evidence and its source.
5. **Article URLs only.** Link to the page that carries the story, never a homepage, blog index or docs root such as `https://blog.example.com/`. The checker rejects any URL whose path ends in `/changelog`, `/trending`, `/releases`, `/blog` or `/docs`, or starts with `/data`, because those pages are rewritten in place: cite what sits below the index (`/releases/tag/v2.1.277`, not `/releases`). A page below one is fine — `/blog/2026/09/16/a-story` and `/docs/en/some-page` both pass.
6. **Label the publisher of the linked page.** In `[Source: [Label](URL)]`, the label names whoever publishes the page at that URL. A dev.to post about a Reddit thread is "DEV Community", not "Reddit"; The Register's story about a Microsoft Research paper is "The Register". Only use Reddit, Hacker News, arXiv, GitHub, X or Microsoft Research for links on their own domains.
7. **No press-release wires.** Skip GlobeNewswire, PR Newswire, Business Wire, EIN Presswire and ACCESSWIRE. Cite the company's own announcement or independent coverage instead.

---

## Step 3: Write the newsletter

Follow the template in [template.md](template.md) exactly. For each item write:

- A **punchy headline** (not the original title — rewrite it to convey the insight)
- A **2–4 sentence summary** explaining what happened and *why it matters*
- A **direct link** to the primary source, labelled with its publisher (Step 2, rule 6)
- A **tag** from: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]` `[Eval]` `[Safety]`

---

## Step 4: Add the editor's picks

After all sections, select your **top 3 items** across all categories and write a short "Editor's Picks" intro paragraph (2–3 sentences) explaining why you chose them and what theme ties them together.

---

## Step 5: Triage for the reader's notes

Only with a `triage:<dir>` argument; without one, skip this step.

Read `<dir>/interests.txt`, which lists one interest per line. Then write `<dir>/triage.md` with up to five items that match those interests and are worth a closer look. The items can come from the issue, or be ones Step 2 cut for space. Every line is exactly:

```
- [title](url): why it matches
```

- One item per line, and nothing else in the file: no heading, no blank lines, no backticks.
- Keep each line under 300 characters. Step 2's hard rules apply here as they do to issue items: the URL is the article's own, from an outlet the rules allow, dated inside the window, and never a rolling index.
- Write no commands and no suggestions of what to run; the reader's tooling adds those.
- If nothing matches, write an empty file.

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
date: YYYY-MM-DDT00:00:00Z
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

`YYYY-Www` is the week and `YYYY-MM-DD` the issue date, both from 6a. Keep the time at `00:00:00Z`: Hugo builds with `buildFuture = false`, so a post stamped later than the moment the site is built is dropped from the build and 404s.

**Body**: Use the clean newsletter markdown from Step 3 verbatim — the same text output to chat.

Write only this file. Don't commit or publish it: whoever ran the skill checks the post and publishes it (`scripts/weekly.sh` does both for scheduled runs).

### 6c. Confirm

Print the path you wrote:

```
Post written → <web>/content/posts/YYYY-MM-DD.md
```

---

## Output format

Output the complete newsletter as clean markdown. Do not include your search process or intermediate steps in the output — only the finished newsletter. The newsletter should be ready to paste into an email or publish directly.
