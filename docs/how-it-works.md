# How It Works

The `newsletter-ai` skill runs a 4-step curation workflow when you invoke `/newsletter-ai`. It uses only `WebSearch` and `WebFetch` — no external APIs or subscriptions required.

---

## Workflow overview

```
/newsletter-ai [optional arguments]
        │
        ▼
┌─────────────────────────────────┐
│  Step 1: Gather                 │
│  Search all 6 source categories │
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
        (ready to publish)
```

---

## Step 1: Gather

Claude searches each of the 6 source categories defined in `sources.md`:

1. **Community & Discussion** — Reddit subreddits, filtered by engagement (100+ upvotes preferred)
2. **Research & Papers** — arXiv, HuggingFace daily papers, Papers with Code, Semantic Scholar
3. **Technical Blogs** — Lab blogs (Anthropic, OpenAI, DeepMind, Meta AI) and individual researchers
4. **Analyst & Industry** — Gartner, McKinsey, Forrester, Stanford HAI, Epoch AI, etc.
5. **AI Security** — OWASP, MITRE ATLAS, NIST, Lakera, Protect AI, CVE feeds
6. **Product & Company News** — Model releases, funding rounds, LinkedIn posts

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
- **Tag** — one of: `[Research]` `[Tool]` `[Security]` `[Industry]` `[Community]` `[Policy]`

The output follows the structure in `template.md` exactly.

---

## Step 4: Editor's Picks

After all sections are written, Claude selects the **top 3 items** from across all categories and writes a 2–3 sentence paragraph at the top of the newsletter identifying:

- The three picks
- The theme or thread connecting them this week

This runs last so the picks are chosen with full visibility of everything gathered.

---

## File roles

| File | Role |
|---|---|
| `SKILL.md` | Main entry point. Defines the workflow and tells Claude which supporting files exist. |
| `sources.md` | Reference catalogue of URLs and search strategies per category. Claude reads this during Step 1. |
| `template.md` | Exact output format. Claude follows this during Step 3. |

---

## Invocation behaviour

The skill has `disable-model-invocation: true`, meaning Claude will **not** trigger it automatically during a conversation. It only runs when you explicitly type `/newsletter-ai`. This prevents it from firing unintentionally during normal chat about AI topics.

Argument passing:

```
/newsletter-ai                          # Full newsletter, last 7 days
/newsletter-ai security only            # Filters to security category
/newsletter-ai last 14 days             # Extends the time window
/newsletter-ai open-source models only  # Topic-scoped
```
