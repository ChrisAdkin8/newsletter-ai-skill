# newsletter-ai — Claude Code Skill

A Claude Code skill that curates a ready-to-publish weekly newsletter covering **agentic AI and LLM developments** across 11 source categories. Sources span Reddit, alignment safety labs, academic research groups, technical blogs, infra company engineering posts, analyst reports, AI security frameworks, government regulatory feeds, agent-era workflow content, open-source infrastructure, hardware/compute news, and a dedicated model evaluations track. Produces a structured, opinionated digest for technical practitioners.

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
| **Research Highlights** | arXiv, alignment labs (ARC, CAIUS, Apollo, METR), academic labs (BAIR, AI2, EleutherAI) |
| **Engineering & Technical Blogs** | Labs, infra companies, AI media, individual researchers |
| **Industry & Analyst Watch** | Gartner, McKinsey, AI Now Institute, OECD AI |
| **AI Security & Safety** | OWASP, MITRE ATLAS, NIST, CVEs, prompt injection |
| **Product & Company News** | Model releases, funding, partnerships |
| **Regulatory & Policy** | EU Commission, UK AISI, White House OSTP, IAPP, Covington, HSF Kramer |
| **Agent Era & Technical Workflows** | Vellum AI, ByteByteGo, production agent patterns |
| **Open Source & Infrastructure** | HuggingFace, Anyscale, SemiAnalysis |
| **Hardware & Macro Watch** | Computing.co.uk, Cerebras, Groq, chip/data centre news |
| **Model Evaluations & Transparency** | LMSYS, Artificial Analysis, Scale SEAL, HELM, HF Leaderboard, WhatLLM |
| **Quick Links** | Bookmarks without summaries |

Output is clean markdown, ready to paste into an email tool or publish directly.

---

## Sources covered

### Community
- r/MachineLearning, r/LocalLLaMA, r/artificial, r/AIAssistants, r/LanguageModelAPI, r/singularity, r/AIdev

### Research & Papers
- arXiv (cs.AI, cs.CL, cs.LG, cs.CR), HuggingFace daily papers, Papers with Code, Semantic Scholar
- **Alignment & safety labs**: Alignment Research Center, Center for AI Safety (CAIUS), Apollo Research, METR
- **Academic labs**: Stanford HAI, Berkeley AI Research (BAIR), Allen Institute for AI (AI2), EleutherAI

### Technical Blogs
- Major labs: Anthropic, OpenAI, Google DeepMind, Meta AI, Hugging Face
- **Infra companies**: Cerebras, Groq, Lambda Labs, CoreWeave, Fireworks AI, Anyscale
- **AI-only media**: The Decoder, VentureBeat AI, ML News
- Framework blogs: LangChain, LlamaIndex, Cohere, Mistral, Together AI
- **Individual researchers**: Lilian Weng, Simon Willison, Sebastian Raschka, Andrej Karpathy, Chip Huyen, Nathan Lambert, Dwarkesh Patel, Ethan Mollick, Dan Hendrycks, Percy Liang

### Analyst & Industry
- Gartner, Forrester, IDC, McKinsey, BCG, Deloitte
- Stanford HAI AI Index, RAND, Epoch AI, **AI Now Institute**, **OECD AI**
- The Gradient, Import AI (Jack Clark), Stratechery

### AI Security
- OWASP Top 10 for LLM Applications, OWASP AI Exchange
- MITRE ATLAS, MITRE CVE, NIST AI RMF
- AI Village, Lakera, Protect AI, Adversa AI, Dark Reading, Wired, Krebs on Security

### Regulatory & Policy
- **Government primary**: EU Commission AI Act, UK AI Safety Institute, White House OSTP
- Legal commentary: IAPP, Covington (Inside Privacy + Inside Global Tech), HSF Kramer *Behind the Prompt*

### Agent Era & Technical Workflows
- Vellum AI Blog, ByteByteGo

### Open Source & Infrastructure
- HuggingFace blog and model hub, Anyscale, SemiAnalysis

### Macro & Hardware Watch
- Computing.co.uk, SemiAnalysis, Cerebras, Groq, Tom's Hardware

### Model Evaluations & Transparency *(new category)*
- LMSYS blog and Chatbot Arena, Artificial Analysis, Scale AI SEAL leaderboard, HELM (Stanford CRFM), HuggingFace Open LLM Leaderboard, WhatLLM.org

### Product & Company News
- OpenRouter, LMSYS Chatbot Arena, Crunchbase, TechCrunch AI, LinkedIn

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
