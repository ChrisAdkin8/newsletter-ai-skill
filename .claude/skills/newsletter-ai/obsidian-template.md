# Obsidian Vault Template

Defines the note format for issue files and the vault structure.

---

## Vault directory structure

```
AI-Newsletter-Vault/
├── _index.md                          ← vault dashboard (created on first run)
├── issues/
│   └── YYYY-MM-DD.md                 ← one file per weekly issue
├── topics/                            ← 11 topic index notes (created on first run)
│   ├── community.md
│   ├── research.md
│   ├── engineering.md
│   ├── industry.md
│   ├── security.md
│   ├── product.md
│   ├── policy.md
│   ├── agent-era.md
│   ├── open-source.md
│   ├── hardware.md
│   └── evaluations.md
└── canvas/
    ├── newsletter-structure.canvas   ← newsletter sections mindmap
    └── sources.canvas                ← source catalogue mindmap (11 categories)
```

The `topics/` notes are the graph nodes. Each issue note links to them via wikilinks, so Obsidian's Graph View renders the newsletter at the centre with edges to each topic it covered. Over time, topics with more coverage form denser clusters.

---

## Issue note format

Each issue note is the full newsletter body with YAML frontmatter prepended.

### Frontmatter

```yaml
---
date: YYYY-MM-DD
week: YYYY-Www
tags:
  - newsletter
  - agentic-ai
  - weekly
theme: "[one-sentence theme from the newsletter's opening framing line]"
categories:
  - community
  - research
  - engineering
  - industry
  - security
  - product
  - policy
  - agent-era
  - open-source
  - hardware
  - evaluations
editor_picks:
  - "[headline of Editor's Pick 1]"
  - "[headline of Editor's Pick 2]"
  - "[headline of Editor's Pick 3]"
source: claude-code-newsletter-ai-skill
---
```

### Body

The full newsletter body follows immediately after the closing `---` of the frontmatter, with one modification: each section's italic subtitle includes a wikilink to its topic index note. This powers the Obsidian Graph View — see the wikilink table in SKILL.md Step 5b for the exact strings to use.

---

## Topic index note format

Each topic note follows this template. The `categories` value in the Dataview query must match the string used in the issue frontmatter.

```markdown
# [Topic Name]

[One-sentence description of what this topic covers.]

**Sources**: [comma-separated source list for this category]

---

## Issues covering this topic

​```dataview
TABLE date, theme
FROM "issues"
WHERE contains(categories, "[category-slug]")
SORT date DESC
​```
```

The 11 topic slugs and their display names:

| File | Frontmatter slug | Display name |
|---|---|---|
| `topics/community.md` | `community` | Community & Discussion |
| `topics/research.md` | `research` | Research & Papers |
| `topics/engineering.md` | `engineering` | Engineering & Technical Blogs |
| `topics/industry.md` | `industry` | Industry & Analyst Watch |
| `topics/security.md` | `security` | AI Security & Safety |
| `topics/product.md` | `product` | Product & Company News |
| `topics/policy.md` | `policy` | Regulatory & Policy |
| `topics/agent-era.md` | `agent-era` | Agent Era & Technical Workflows |
| `topics/open-source.md` | `open-source` | Open Source & Infrastructure |
| `topics/hardware.md` | `hardware` | Hardware & Macro Watch |
| `topics/evaluations.md` | `evaluations` | Model Evaluations & Transparency |

---

## Vault index (_index.md)

Create this file on the first run. Do not overwrite it on subsequent runs.

```markdown
# AI Newsletter Vault

Weekly digest of agentic AI and LLM developments, curated by the `newsletter-ai` Claude Code skill.

## Mindmaps

- [[canvas/newsletter-structure|Newsletter Structure]] — 13 output sections and their tags
- [[canvas/sources|Source Catalogue]] — 11 source categories and 100+ sources

## Topics

Each issue links to its covered topics. Open Graph View (`Ctrl+G`) to see the newsletter graph: issue notes at the centre, topic nodes radiating outward.

- [[topics/community|Community & Discussion]]
- [[topics/research|Research & Papers]]
- [[topics/engineering|Engineering & Technical Blogs]]
- [[topics/industry|Industry & Analyst Watch]]
- [[topics/security|AI Security & Safety]]
- [[topics/product|Product & Company News]]
- [[topics/policy|Regulatory & Policy]]
- [[topics/agent-era|Agent Era & Technical Workflows]]
- [[topics/open-source|Open Source & Infrastructure]]
- [[topics/hardware|Hardware & Macro Watch]]
- [[topics/evaluations|Model Evaluations & Transparency]]

## All Issues

```dataview
TABLE date, theme
FROM "issues"
SORT date DESC
` ``

## Issues by category

```dataview
TABLE date, theme
FROM "issues"
WHERE contains(categories, "security")
SORT date DESC
` ``
```

---

## Obsidian features enabled

| Feature | Field used |
|---|---|
| Calendar plugin | `date` |
| Tag search and graph clustering | `tags` |
| Dataview queries | All frontmatter fields |
| Full-text search | Entire body |
| Canvas cross-links | Issue notes can be linked as file nodes in canvas |
| Graph View | Wikilinks in issue notes → topic nodes; newsletter at centre radiating to topics |
