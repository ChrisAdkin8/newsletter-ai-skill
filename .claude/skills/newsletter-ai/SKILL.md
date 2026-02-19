---
name: newsletter-ai
description: Curate a newsletter covering agentic AI and LLM news from Reddit, research papers, blogs, LinkedIn, analyst reports, and security sources (OWASP, MITRE). Use when the user asks for AI news, an LLM digest, an agentic AI roundup, or a newsletter.
argument-hint: "[topic-focus or date-range, optional]"
disable-model-invocation: true
allowed-tools: WebSearch, WebFetch
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

1. **Community & Discussion** (Reddit)
2. **Research & Papers** (arXiv, Papers with Code, Semantic Scholar)
3. **Technical Blogs & Engineering Posts**
4. **Analyst & Industry Reports** (Gartner, Forrester, McKinsey, etc.)
5. **AI Security** (OWASP, MITRE ATLAS, NIST, CVEs)
6. **Product & Company News** (model releases, funding, partnerships)

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
- A **tag** from: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]`

---

## Step 4: Add the editor's picks

After all sections, select your **top 3 items** across all categories and write a short "Editor's Picks" intro paragraph (2–3 sentences) explaining why you chose them and what theme ties them together.

---

## Output format

Output the complete newsletter as clean markdown. Do not include your search process or intermediate steps in the output — only the finished newsletter. The newsletter should be ready to paste into an email or publish directly.
