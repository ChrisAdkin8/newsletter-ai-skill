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
│   ├── community.md  (→ sources)
│   ├── research.md   (→ sources)
│   └── ...
├── sources/                           ← one note per publication/org (created on first run)
│   ├── owasp.md      (→ articles via Dataview)
│   ├── anthropic.md
│   └── ...
├── articles/                          ← one note per story (created each run)
│   └── YYYY-MM-DD-topic-slug.md
└── canvas/
    ├── newsletter-structure.canvas   ← newsletter sections mindmap
    └── sources.canvas                ← source catalogue mindmap (11 categories)
```

**Graph hierarchy**: `issue → topic → source ← article`

- Issue notes link to topic notes (section subtitles)
- Issue notes also link to article notes (story headlines)
- Topic notes link to source notes (Sources line)
- Article notes link back to source and topic (footer wikilinks)
- Source notes aggregate articles via Dataview (no manual links needed)

Obsidian's Graph View renders the full four-level hierarchy. Topics with frequent coverage and sources with many articles form denser clusters over time.

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

The full newsletter body follows immediately after the closing `---` of the frontmatter, with two modifications for the vault version:

1. **Section subtitles** include a wikilink to the topic index note (see SKILL.md Step 5b for the exact strings)
2. **Story headlines** are wikilinks to their article notes: `### [[articles/slug|Headline]]`

These two changes create the full four-level graph in Obsidian's Graph View.

---

## Article note format

Each story gets its own note in `articles/`. The `source` and `topic` frontmatter fields drive the Dataview queries in source and topic notes.

```markdown
---
date: YYYY-MM-DD
source: source-slug
topic: topic-slug
tag: Security
url: https://...
---

# [Rewritten headline]

[2-4 sentence summary identical to the newsletter body.]

[[sources/source-slug|Source Name]] · [[topics/topic-slug|Topic Name]] · [Read more](url)
```

Slug format: `YYYY-MM-DD-{topic}-{2-3-word-title}` (lowercase, hyphens only).
Example: `2026-02-20-security-owasp-agentic-top-10`

---

## Source note format

Each source note lives in `sources/` and uses a Dataview query to auto-aggregate all article notes from that source.

```markdown
# Source Name

One-line description of what this source covers.

**URL**: https://...
**Category**: [Standards|Lab|Media|Government|Analyst|Community|Infrastructure|Evaluation|Engineering]

---

## Articles

​```dataview
TABLE date, file.link AS Title, tag
FROM "articles"
WHERE source = "source-slug"
SORT date DESC
​```
```

---

## Source slug catalogue

Use these slugs consistently in article frontmatter so Dataview queries aggregate correctly.

| Slug | Source | Category |
|---|---|---|
| `hacker-news` | Hacker News | Community |
| `reddit` | Reddit | Community |
| `x-twitter` | X / Twitter | Community |
| `arxiv` | arXiv | Research |
| `huggingface` | HuggingFace | Lab / Open Source |
| `anthropic` | Anthropic | Lab |
| `openai` | OpenAI | Lab |
| `google-deepmind` | Google DeepMind | Lab |
| `meta-ai` | Meta AI | Lab |
| `nvidia` | NVIDIA | Infrastructure |
| `microsoft-research` | Microsoft Research | Lab |
| `aws` | Amazon Web Services | Infrastructure |
| `owasp` | OWASP | Standards |
| `mitre-atlas` | MITRE ATLAS | Standards |
| `nist` | NIST | Government |
| `cisa` | CISA | Government |
| `enisa` | ENISA | Government |
| `ncsc` | NCSC | Government |
| `trail-of-bits` | Trail of Bits | Security Research |
| `lakera` | Lakera | AI Security |
| `hiddenlayer` | HiddenLayer | AI Security Research |
| `embrace-the-red` | Embrace the Red (Johann Rehberger) | AI Security Research |
| `snyk-labs` | Snyk Labs (ex-Invariant Labs) | AI Security Research |
| `uk-aisi` | UK AI Safety Institute | Government |
| `eu-commission` | EU Commission | Government |
| `ftc` | FTC | Government |
| `iapp` | IAPP | Legal |
| `future-of-life` | Future of Life Institute | Policy |
| `covington` | Covington | Legal |
| `a16z-ai` | a16z AI | Analyst / VC |
| `sequoia-ai` | Sequoia AI | Analyst / VC |
| `mckinsey` | McKinsey | Analyst |
| `brookings` | Brookings | Research |
| `epoch-ai` | Epoch AI | Research |
| `chatbot-arena` | LMSYS / Chatbot Arena | Evaluation |
| `artificial-analysis` | Artificial Analysis | Evaluation |
| `scale-seal` | Scale AI SEAL | Evaluation |
| `helm` | HELM (Stanford CRFM) | Evaluation |
| `hf-leaderboard` | HuggingFace Open LLM Leaderboard | Evaluation |
| `whatllm` | WhatLLM.org | Evaluation |
| `mit-tech-review` | MIT Technology Review | Media |
| `ars-technica` | Ars Technica | Media |
| `venturebeat-ai` | VentureBeat AI | Media |
| `techcrunch-ai` | TechCrunch AI | Media |
| `next-platform` | The Next Platform | Media |
| `semianalysis` | SemiAnalysis | Analyst |
| `bytebytego` | ByteByteGo | Engineering |
| `vellum-ai` | Vellum AI | Engineering |
| `pydantic-ai` | Pydantic AI | Engineering |
| `langchain` | LangChain / LangGraph Blog | Engineering |
| `redwood-research` | Redwood Research | Alignment Research |
| `alignment-forum` | Alignment Forum | Alignment Research |
| `lesswrong` | LessWrong | Alignment Research |
| `modal` | Modal | Infrastructure |
| `ms-semantic-kernel` | Microsoft Semantic Kernel / AutoGen | Engineering |
| `ada-lovelace` | Ada Lovelace Institute | Policy |
| `cdt` | Center for Democracy & Technology | Policy |
| `eff` | Electronic Frontier Foundation | Policy |
| `composio` | Composio | Engineering |
| `amd-ai` | AMD AI / ROCm | Infrastructure |
| `chips-and-cheese` | Chips and Cheese | Media |
| `fabricated-knowledge` | Fabricated Knowledge | Analyst |
| `the-batch` | The Batch (deeplearning.ai) | Media |
| `latent-space` | Latent Space | Media |
| `twiml` | TWIML AI Podcast | Media |

If a story comes from a source not in this table, create a new source note using the source note format above, and add its slug to article frontmatter consistently.

---

## Topic → source wikilink mapping

Use these source wikilinks in the **Sources** line of each topic note:

| Topic | Sources line |
|---|---|
| community | `[[sources/hacker-news\|Hacker News]] · [[sources/reddit\|Reddit]] · [[sources/x-twitter\|X / Twitter]]` |
| research | `[[sources/arxiv\|arXiv]] · [[sources/huggingface\|HuggingFace]] · [[sources/alignment-forum\|Alignment Forum]] · [[sources/lesswrong\|LessWrong]] · [[sources/microsoft-research\|Microsoft Research]] · [[sources/google-deepmind\|Google DeepMind]] · [[sources/redwood-research\|Redwood Research]] · [[sources/uk-aisi\|UK AI Safety Institute]]` |
| engineering | `[[sources/anthropic\|Anthropic]] · [[sources/openai\|OpenAI]] · [[sources/google-deepmind\|Google DeepMind]] · [[sources/meta-ai\|Meta AI]] · [[sources/nvidia\|NVIDIA]] · [[sources/microsoft-research\|Microsoft Research]] · [[sources/ms-semantic-kernel\|Microsoft Semantic Kernel]] · [[sources/modal\|Modal]] · [[sources/huggingface\|HuggingFace]] · [[sources/mit-tech-review\|MIT Tech Review]] · [[sources/ars-technica\|Ars Technica]] · [[sources/venturebeat-ai\|VentureBeat AI]]` |
| industry | `[[sources/a16z-ai\|a16z AI]] · [[sources/sequoia-ai\|Sequoia AI]] · [[sources/mckinsey\|McKinsey]] · [[sources/brookings\|Brookings]] · [[sources/epoch-ai\|Epoch AI]] · [[sources/venturebeat-ai\|VentureBeat AI]] · [[sources/techcrunch-ai\|TechCrunch AI]]` |
| security | `[[sources/owasp\|OWASP]] · [[sources/mitre-atlas\|MITRE ATLAS]] · [[sources/nist\|NIST]] · [[sources/cisa\|CISA]] · [[sources/enisa\|ENISA]] · [[sources/ncsc\|NCSC]] · [[sources/trail-of-bits\|Trail of Bits]] · [[sources/lakera\|Lakera]] · [[sources/hiddenlayer\|HiddenLayer]] · [[sources/embrace-the-red\|Embrace the Red]] · [[sources/snyk-labs\|Snyk Labs]] · [[sources/microsoft-research\|Microsoft Research]]` |
| product | `[[sources/anthropic\|Anthropic]] · [[sources/openai\|OpenAI]] · [[sources/google-deepmind\|Google DeepMind]] · [[sources/meta-ai\|Meta AI]] · [[sources/techcrunch-ai\|TechCrunch AI]] · [[sources/venturebeat-ai\|VentureBeat AI]]` |
| policy | `[[sources/eu-commission\|EU Commission]] · [[sources/uk-aisi\|UK AI Safety Institute]] · [[sources/ftc\|FTC]] · [[sources/iapp\|IAPP]] · [[sources/future-of-life\|Future of Life Institute]] · [[sources/covington\|Covington]] · [[sources/ada-lovelace\|Ada Lovelace Institute]] · [[sources/cdt\|CDT]] · [[sources/eff\|EFF]]` |
| agent-era | `[[sources/vellum-ai\|Vellum AI]] · [[sources/bytebytego\|ByteByteGo]] · [[sources/langchain\|LangChain]] · [[sources/pydantic-ai\|Pydantic AI]] · [[sources/composio\|Composio]] · [[sources/aws\|Amazon Web Services]]` |
| open-source | `[[sources/huggingface\|HuggingFace]] · [[sources/semianalysis\|SemiAnalysis]] · [[sources/whatllm\|WhatLLM.org]]` |
| hardware | `[[sources/nvidia\|NVIDIA]] · [[sources/amd-ai\|AMD AI]] · [[sources/next-platform\|The Next Platform]] · [[sources/semianalysis\|SemiAnalysis]] · [[sources/chips-and-cheese\|Chips and Cheese]] · [[sources/fabricated-knowledge\|Fabricated Knowledge]]` |
| evaluations | `[[sources/chatbot-arena\|LMSYS / Chatbot Arena]] · [[sources/artificial-analysis\|Artificial Analysis]] · [[sources/scale-seal\|Scale AI SEAL]] · [[sources/helm\|HELM]] · [[sources/hf-leaderboard\|HF Open LLM Leaderboard]] · [[sources/whatllm\|WhatLLM.org]]` |

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

## Topics → Sources → Articles

Open Graph View (`Cmd+G`) to see the full hierarchy: issue → topic → source → article.

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
| Graph View | Four-level hierarchy: issue → topic → source ← article; wikilinks drive all edges |
