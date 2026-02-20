# Obsidian Vault Template

Defines the note format for issue files and the vault structure.

---

## Vault directory structure

```
AI-Newsletter-Vault/
├── _index.md                          ← vault dashboard (created on first run)
├── issues/
│   └── YYYY-MM-DD.md                 ← one file per weekly issue
└── canvas/
    ├── newsletter-structure.canvas   ← newsletter sections mindmap
    └── sources.canvas                ← source catalogue mindmap (11 categories)
```

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

The full newsletter body follows immediately after the closing `---` of the frontmatter. It is identical to the chat output from Steps 3 and 4 — same markdown, same headlines, same summaries, same links. No reformatting required.

---

## Vault index (_index.md)

Create this file on the first run. Do not overwrite it on subsequent runs.

```markdown
# AI Newsletter Vault

Weekly digest of agentic AI and LLM developments, curated by the `newsletter-ai` Claude Code skill.

## Mindmaps

- [[canvas/newsletter-structure|Newsletter Structure]] — 13 output sections and their tags
- [[canvas/sources|Source Catalogue]] — 11 source categories and 100+ sources

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
