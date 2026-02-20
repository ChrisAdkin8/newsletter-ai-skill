# newsletter-ai — Claude Code Skill

A Claude Code skill that curates a ready-to-publish weekly newsletter covering **agentic AI and LLM developments**. It searches across Reddit, research papers, technical blogs, analyst reports, LinkedIn, and AI security sources (OWASP, MITRE, NIST), then writes a structured, opinionated digest for technical practitioners.

---

## Quick start

### Install globally (all projects)

```bash
mkdir -p ~/.claude/skills/newsletter-ai
cp -r .claude/skills/newsletter-ai/ ~/.claude/skills/newsletter-ai/
```

### Run it

```
/newsletter-ai
```

With an optional focus or date range:

```
/newsletter-ai security focus — last 14 days
/newsletter-ai agentic frameworks only
```

---

## Repository structure

```
newsletter-ai-skill/
├── README.md                               # This file
├── docs/
│   ├── how-it-works.md                     # Skill architecture and workflow
│   ├── sources.md                          # Source catalogue (human-readable)
│   └── customising.md                      # How to add sources, change output format
└── .claude/
    └── skills/
        └── newsletter-ai/
            ├── SKILL.md                    # Main skill — Claude reads this
            ├── sources.md                  # Source list referenced by SKILL.md
            └── template.md                 # Newsletter output template
```

---

## What it produces

A markdown newsletter with these sections:

| Section | Content |
|---|---|
| **Editor's Picks** | Top 3 stories of the week with a connecting theme |
| **Community Pulse** | High-signal Reddit discussions |
| **Research Highlights** | Notable arXiv papers and findings |
| **Engineering & Technical Blogs** | What labs and practitioners are shipping |
| **Industry & Analyst Watch** | Gartner, McKinsey, Forrester, Stanford HAI |
| **AI Security & Safety** | OWASP, MITRE ATLAS, NIST, CVEs, prompt injection |
| **Product & Company News** | Model releases, funding, partnerships |
| **Regulatory & Policy** | IAPP, Covington, HSF Kramer, AI Act updates |
| **Agent Era & Technical Workflows** | Vellum AI, ByteByteGo, production agent patterns |
| **Open Source & Infrastructure** | WhatLLM.org rankings, HF leaderboard shifts |
| **Hardware & Macro Watch** | Computing.co.uk, SemiAnalysis, chip/data centre news |
| **Quick Links** | Bookmarks without summaries |

Output is clean markdown, ready to paste into an email tool or publish directly.

---

## Sources covered

### Community
- r/MachineLearning, r/LocalLLaMA, r/artificial, r/AIAssistants, r/LanguageModelAPI, r/singularity, r/AIdev

### Research & Papers
- arXiv (cs.AI, cs.CL, cs.LG, cs.CR)
- Hugging Face daily papers
- Papers with Code
- Semantic Scholar
- Google DeepMind publications

### Technical Blogs
- Anthropic, OpenAI, Google DeepMind, Meta AI, Hugging Face
- LangChain, LlamaIndex, Cohere, Mistral, Together AI
- Individual researchers: Lilian Weng, Simon Willison, Sebastian Raschka, Andrej Karpathy, Chip Huyen, Nathan Lambert

### Analyst & Industry
- Gartner, Forrester, IDC, McKinsey, BCG, Deloitte
- Stanford HAI AI Index, RAND, Epoch AI
- The Gradient, Import AI (Jack Clark), Stratechery

### AI Security
- OWASP Top 10 for LLM Applications
- OWASP AI Exchange
- MITRE ATLAS (adversarial ML threat matrix)
- MITRE CVE (AI/LLM-related)
- NIST AI Risk Management Framework
- AI Village, Lakera, Protect AI, Adversa AI
- Dark Reading, Wired, Krebs on Security

### Regulatory & Policy
- IAPP News & Analysis, AI Governance archive
- Covington & Burling — Inside Privacy, Inside Global Tech
- HSF Kramer — Behind the Prompt (LinkedIn newsletter)

### Agent Era & Technical Workflows
- Vellum AI Blog (evaluation, orchestration, production agents)
- ByteByteGo (system design patterns for AI, Substack)

### Open Source & Specialised Infrastructure
- WhatLLM.org (weekly open-source model rankings)
- Hugging Face Open LLM Leaderboard

### Macro & Hardware Watch
- Computing.co.uk (AI & ML, Infrastructure verticals)
- SemiAnalysis (chip industry, GPU economics)
- Tom's Hardware AI

### Product & Company News
- OpenRouter model releases
- LMSYS Chatbot Arena leaderboard
- Crunchbase, TechCrunch AI
- LinkedIn posts tagged #AgenticAI, #LLM, #AIAgents

---

## Skill configuration

Defined in `.claude/skills/newsletter-ai/SKILL.md`:

| Frontmatter field | Value | Effect |
|---|---|---|
| `name` | `newsletter-ai` | Invoked as `/newsletter-ai` |
| `disable-model-invocation` | `true` | Only runs when you explicitly call `/newsletter-ai` |
| `allowed-tools` | `WebSearch, WebFetch` | Granted without per-use approval |
| `argument-hint` | `[topic-focus or date-range, optional]` | Shown in autocomplete |

---

## Docs

- [How it works](docs/how-it-works.md) — the 4-step curation workflow
- [Sources](docs/sources.md) — full annotated source list
- [Customising](docs/customising.md) — adding sources, changing format, scoping to a topic
