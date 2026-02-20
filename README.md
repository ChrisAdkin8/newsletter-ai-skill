# newsletter-ai — Claude Code Skill

A Claude Code skill that curates a ready-to-publish weekly newsletter covering **agentic AI and LLM developments** across 11 source categories. Sources span Reddit, Hacker News, X/Twitter, alignment safety labs, major lab research publications, academic research groups, technical blogs, infra company engineering posts, AI-only media, analyst reports and VC firms, AI security frameworks (OWASP, MITRE, NIST, CISA, ENISA, NCSC), government regulatory feeds, agent-era workflow content, open-source infrastructure, hardware/compute news (NVIDIA, Next Platform, Datacenter Dynamics), and a dedicated model evaluations track (LMSYS, Artificial Analysis, Scale SEAL, HELM, LiveBench, AlpacaEval). Produces a structured, opinionated digest for technical practitioners.

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

With an optional focus, date range, or vault path:

```
/newsletter-ai security focus — last 14 days
/newsletter-ai agentic frameworks only
/newsletter-ai vault:~/Obsidian/AI-News/
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
            ├── template.md                 # Newsletter output template
            ├── obsidian-template.md        # Obsidian vault note format + vault structure
            ├── newsletter-structure.canvas # Mindmap: 13 newsletter sections (Obsidian Canvas)
            └── sources.canvas              # Mindmap: 11 source categories (Obsidian Canvas)
```

---

## What it produces

A markdown newsletter with these sections:

| Section | Content |
|---|---|
| **Editor's Picks** | Top 3 stories of the week with a connecting theme |
| **Community Pulse** | Reddit, Hacker News, X/Twitter, LinkedIn (12 named profiles) — real-time practitioner signal |
| **Research Highlights** | arXiv, alignment labs (ARC, CAIUS, Apollo, METR, Redwood, FAR AI), academic labs, Microsoft/Apple/Amazon research |
| **Engineering & Technical Blogs** | Labs, NVIDIA, W&B, vLLM, Databricks, Ollama, CrewAI, MIT Tech Review, Ars Technica, IEEE Spectrum, Chollet, Marcus, Wolfe |
| **Industry & Analyst Watch** | Gartner, McKinsey, a16z, Sequoia, Brookings, AI Now Institute, OECD AI |
| **AI Security & Safety** | OWASP, MITRE ATLAS, NIST, CISA, ENISA, NCSC, Trail of Bits, Microsoft Security |
| **Product & Company News** | Model releases, funding, partnerships |
| **Regulatory & Policy** | EU Commission, UK AISI, FTC, UK ICO, White House OSTP, Canada AIDA, Future of Life Institute, IAPP, Covington |
| **Agent Era & Technical Workflows** | Vellum AI, ByteByteGo, production agent patterns |
| **Open Source & Infrastructure** | HuggingFace, Anyscale, SemiAnalysis |
| **Hardware & Macro Watch** | Computing.co.uk, Cerebras, Groq, chip/data centre news |
| **Model Evaluations & Transparency** | LMSYS, Artificial Analysis, Scale SEAL, HELM, HF Leaderboard, WhatLLM |
| **Quick Links** | Bookmarks without summaries |

Output is clean markdown, ready to paste into an email tool or publish directly.

The skill also writes every issue to an **Obsidian vault** at `~/Documents/AI-Newsletter-Vault/` (configurable). The vault implements a four-level graph hierarchy:

```
Issue note → Topic note → Source note ← Article note
```

On first run it creates:

| Asset | What it does |
|---|---|
| `topics/*.md` (11 notes) | Topic index notes — link to their catalogue sources via wikilinks |
| `sources/*.md` (~45 notes) | Source notes — one per publication; auto-aggregate articles via Dataview |
| `canvas/newsletter-structure.canvas` | Canvas mindmap: 13 output sections and their tags |
| `canvas/sources.canvas` | Canvas mindmap: 11 source categories and all 100+ sources |

Each run also creates:

| Asset | What it does |
|---|---|
| `articles/*.md` (~25 per issue) | One note per story — links back to source and topic |

Open **Graph View** (`Cmd+G`) in Obsidian: issue at the centre, topics one hop out, sources two hops out, individual article titles at the leaves. Sources with many articles and topics covered every week form denser clusters over time — a live map of the newsletter's coverage history.

---

## Sources covered

### Community
- Reddit: r/MachineLearning, r/LocalLLaMA, r/artificial, r/AIAssistants, r/LanguageModelAPI, r/singularity, r/AIdev, r/ChatGPT, r/ClaudeAI, r/OpenAI
- **Hacker News** (news.ycombinator.com) — highest-signal technical AI discussion
- **X/Twitter** — @AnthropicAI, @OpenAI, @karpathy, @ylecun, @fchollet, @GaryMarcus, @emollick, @danhendrycks
- **LinkedIn** (named profiles, WebSearch only) — Andrew Ng, Yann LeCun, Ethan Mollick, Mustafa Suleyman, Cassie Kozyrkov, Sebastian Raschka, Jay Alammar, Chip Huyen, Harrison Chase, Jerry Liu, Gary Marcus, Jeff Dean

### Research & Papers
- arXiv (cs.AI, cs.CL, cs.LG, cs.CR), HuggingFace daily papers, Papers with Code, Semantic Scholar, Nature Machine Intelligence
- **Major lab research**: Google DeepMind, Microsoft Research, Apple ML Research, Amazon Science
- **Alignment & safety labs**: ARC, Center for AI Safety (CAIUS), Apollo Research, METR, Redwood Research, FAR AI
- **Academic labs**: Stanford HAI, BAIR, Allen Institute for AI (AI2), EleutherAI

### Technical Blogs
- Major labs: Anthropic, OpenAI, Google DeepMind, Meta AI, Hugging Face, Microsoft Research, Microsoft Azure AI, Apple ML Research, Amazon Science
- **Infra companies**: NVIDIA (Developer + News), Cerebras, Groq, Lambda Labs, CoreWeave, Fireworks AI, Anyscale, Weights & Biases, vLLM, Scale AI, Databricks, Ollama, CrewAI
- **AI-only media**: The Decoder, VentureBeat AI, MIT Technology Review, Ars Technica AI, IEEE Spectrum, The Information, ML News
- Framework blogs: LangChain, LlamaIndex, Cohere, Mistral, Together AI
- **Individual researchers**: Lilian Weng, Simon Willison, Sebastian Raschka, Andrej Karpathy, Chip Huyen, Nathan Lambert, Dwarkesh Patel, Ethan Mollick, Dan Hendrycks, Percy Liang, **François Chollet**, **Gary Marcus**, **Cameron Wolfe**

### Analyst & Industry
- Tier-1: Gartner, Forrester, IDC, McKinsey, BCG, Deloitte
- Research: Stanford HAI AI Index, RAND, Epoch AI, AI Now Institute, OECD AI, Brookings
- **VC firms**: a16z AI, Sequoia Capital AI
- Independent: AI Snake Oil, Import AI (Jack Clark), The Gradient, Stratechery

### AI Security
- Standards: OWASP LLM Top 10, OWASP AI Exchange, MITRE ATLAS, MITRE CVE, NIST AI RMF
- **Government agencies**: CISA (US), ENISA (EU), NCSC (UK)
- Research: AI Village, Lakera, Protect AI, Adversa AI, Trail of Bits, Microsoft Security
- News: Dark Reading, Wired, Krebs on Security

### Regulatory & Policy
- **Government primary**: EU Commission AI Act, UK AI Safety Institute, White House OSTP, FTC (US), UK ICO, Canada AIDA, Future of Life Institute
- Legal commentary: IAPP, Covington (Inside Privacy + Inside Global Tech), HSF Kramer *Behind the Prompt*

### Agent Era & Technical Workflows
- Vellum AI Blog, ByteByteGo

### Open Source & Infrastructure
- HuggingFace blog and model hub, vLLM, Ollama, Anyscale, SemiAnalysis

### Macro & Hardware Watch
- **Primary**: NVIDIA News, NVIDIA Developer Blog
- **Infrastructure press**: The Next Platform, Datacenter Dynamics, Computing.co.uk
- Analysis: SemiAnalysis, Cerebras, Groq, Tom's Hardware

### Model Evaluations & Transparency
- LMSYS blog and Chatbot Arena, Artificial Analysis, Scale AI SEAL leaderboard, HELM (Stanford CRFM), **LiveBench**, **AlpacaEval**, HuggingFace Open LLM Leaderboard, WhatLLM.org

### Product & Company News
- OpenRouter, LMSYS Chatbot Arena, Crunchbase, TechCrunch AI, Axios AI, LinkedIn

---

## Skill configuration

Defined in `.claude/skills/newsletter-ai/SKILL.md`:

| Frontmatter field | Value | Effect |
|---|---|---|
| `name` | `newsletter-ai` | Invoked as `/newsletter-ai` |
| `disable-model-invocation` | `true` | Only runs when you explicitly call `/newsletter-ai` |
| `allowed-tools` | `WebSearch, WebFetch, Bash, Write` | Granted without per-use approval (`Bash`/`Write` used for vault output) |
| `argument-hint` | `[topic-focus or date-range, optional]` | Shown in autocomplete |

---

## Docs

- [How it works](docs/how-it-works.md) — the 5-step workflow including Obsidian vault output
- [Sources](docs/sources.md) — full annotated source list
- [Customising](docs/customising.md) — adding sources, changing format, configuring vault path, updating canvas mindmaps

---

## Global CLAUDE.md

The skill's token efficiency rules live in `~/.claude/CLAUDE.md` under a `## Newsletter Skill` section so they apply regardless of working directory. The section was added alongside this skill.

A review of the full global `~/.claude/CLAUDE.md` identified three improvements:

### 1. ~~Subagent Strategy rule is too broad~~ ✓ applied

Added an exception for `WebSearch`-heavy tasks: parallel subagents each consume independent search quota and can exhaust it simultaneously while producing nothing. Sequential execution is required for `/newsletter-ai` and similar tasks.

### 2. Hardcoded project paths in a global file — left as-is

`tasks/todo.md` and `tasks/lessons.md` are a deliberate personal convention. Generalising to vague language would weaken the instructions. Treat these paths as the standard for any project.

### 3. ~~Self-Improvement Loop should point to auto-memory~~ ✓ applied

Rule now distinguishes:
- **Per-project lessons** → `tasks/lessons.md` (regression guards specific to the codebase)
- **Cross-project lessons** → `~/.claude/projects/.../memory/MEMORY.md` (patterns that should persist across all sessions)
