# Source Catalogue

Full annotated list of sources used by the skill, grouped by category. This is the human-readable reference version. The machine-readable version used by Claude lives at `.claude/skills/newsletter-ai/sources.md`.

---

## Community & Discussion

### Reddit

Reddit is the primary source for real-time community signal — what practitioners are actually building, debating, and finding surprising. Prefer posts with 100+ upvotes to filter for content the community has already validated.

| Subreddit | Audience & focus |
|---|---|
| r/MachineLearning | Researchers, academics. Papers, training tricks, benchmarks |
| r/LocalLLaMA | Practitioners running local models. Fine-tuning, quantisation, inference optimisation |
| r/artificial | General public. News, capability announcements, broader discourse |
| r/AIAssistants | Builders. Agent frameworks, workflow automation, chatbot integrations |
| r/LanguageModelAPI | Developers. API usage, prompting techniques, provider comparisons |
| r/singularity | Futurists. Capability milestones, long-term implications |
| r/AIdev | Engineers. Developer tools, SDKs, open-source projects |

---

## Research & Papers

### arXiv
The primary pre-print server for AI/ML research. Most significant work appears here before journal publication.

- **cs.AI** — Artificial intelligence, reasoning, planning
- **cs.CL** — Computational linguistics, NLP, LLMs
- **cs.LG** — Machine learning, training methods, architectures
- **cs.CR** — Cryptography and security (covers AI security, adversarial ML)

Key search terms: `agentic`, `agent`, `RAG`, `retrieval augmented`, `tool use`, `RLHF`, `alignment`, `jailbreak`, `prompt injection`, `multi-agent`, `function calling`

### Hugging Face Daily Papers
Hugging Face curates the top arXiv papers each day based on community engagement. A reliable signal filter for the highest-impact recent work. URL: https://huggingface.co/papers

### Papers with Code
Links papers to their implementations. Useful for finding papers with reproducible experiments and real code.
URL: https://paperswithcode.com/latest

### Semantic Scholar
Good for finding papers by recency with citation context. Useful for tracking which new papers are already being cited.
URL: https://www.semanticscholar.org

### Google DeepMind Publications
Primary source for DeepMind research that may not appear on arXiv immediately.
URL: https://deepmind.google/research/publications/

---

## Technical Blogs & Engineering Posts

### Major lab blogs
These are official sources for announcements, model cards, and technical writeups.

| Organisation | URL | What to expect |
|---|---|---|
| Anthropic | https://www.anthropic.com/news | Model releases, safety research, policy |
| Anthropic Research | https://www.anthropic.com/research | Technical papers and interpretability work |
| OpenAI | https://openai.com/news/ | Model releases, API updates, safety announcements |
| Google DeepMind | https://deepmind.google/discover/blog/ | Research results, model releases |
| Meta AI | https://ai.meta.com/blog/ | Open-source model releases, research |
| Hugging Face | https://huggingface.co/blog | Open-source tooling, model releases, tutorials |

### Engineering & framework blogs
Practitioner-focused content on building with LLMs.

| Organisation | URL |
|---|---|
| LangChain | https://blog.langchain.dev |
| LlamaIndex | https://www.llamaindex.ai/blog |
| Cohere | https://cohere.com/blog |
| Mistral AI | https://mistral.ai/news/ |
| Together AI | https://www.together.ai/blog |

### Individual researchers & practitioners
High signal-to-noise ratio; these writers publish infrequently but with depth.

| Author | URL | Focus |
|---|---|---|
| Sebastian Raschka | https://magazine.sebastianraschka.com | Training, architectures, paper reviews |
| Lilian Weng (OpenAI) | https://lilianweng.github.io | Deep technical surveys, agent architectures |
| Simon Willison | https://simonwillison.net | LLM tooling, prompt injection, practical use |
| Andrej Karpathy | https://karpathy.ai | Fundamentals, model internals |
| Nathan Lambert | https://www.interconnects.ai | RLHF, alignment, open-source models |
| Chip Huyen | https://huyenchip.com/blog | MLOps, deployment, real-world LLM systems |

---

## Analyst & Industry Reports

### Tier-1 management consulting & analyst firms
These sources cover enterprise adoption, market sizing, and strategic framing.

| Source | URL | Strength |
|---|---|---|
| Gartner | https://www.gartner.com/en/information-technology/insights/artificial-intelligence | Hype Cycle, Magic Quadrant, CIO surveys |
| Forrester | https://www.forrester.com/research/artificial-intelligence/ | Enterprise buyer research, vendor evaluations |
| IDC | https://www.idc.com/research/AI | Market sizing, spending forecasts |
| McKinsey Global Institute | https://www.mckinsey.com/capabilities/quantumblack/our-insights | Economic impact, transformation surveys |
| BCG Henderson Institute | https://www.bcg.com/capabilities/artificial-intelligence | Strategic framing, sector analysis |
| Deloitte Insights | https://www2.deloitte.com/us/en/insights/topics/ai-and-machine-learning.html | Enterprise readiness, risk |

### AI-focused research organisations
Independent, technically credible analysis without commercial bias.

| Source | URL | Strength |
|---|---|---|
| Stanford HAI AI Index | https://aiindex.stanford.edu | Annual benchmark report, policy, education |
| RAND AI | https://www.rand.org/topics/artificial-intelligence.html | National security, policy implications |
| Epoch AI | https://epochai.org/blog | Compute trends, scaling, empirical forecasts |
| AI Snake Oil | https://www.aisnakeoil.com | Sceptical, evidence-based critique |
| Import AI (Jack Clark) | https://jack-clark.net | Weekly digest, safety, capabilities |
| The Gradient | https://thegradient.pub | Academic-adjacent, deep technical coverage |
| Stratechery (Ben Thompson) | https://stratechery.com | Business strategy, platform dynamics |

---

## AI Security

### OWASP
The Open Worldwide Application Security Project maintains the authoritative LLM application security guidance.

| Resource | URL | What it covers |
|---|---|---|
| OWASP Top 10 for LLM Applications | https://owasp.org/www-project-top-10-for-large-language-model-applications/ | The 10 most critical LLM security risks |
| OWASP AI Exchange | https://owaspai.org | Broader AI risk catalogue, community-maintained |
| GitHub (latest updates) | https://github.com/OWASP/www-project-top-10-for-large-language-model-applications | Tracks revisions and new entries |

### MITRE
MITRE maintains threat taxonomies widely used by security teams and governments.

| Resource | URL | What it covers |
|---|---|---|
| MITRE ATLAS | https://atlas.mitre.org | Adversarial ML threat matrix — tactics, techniques, procedures |
| MITRE CVE (AI/LLM) | https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=LLM | Published CVEs mentioning LLM or AI systems |
| MITRE ATT&CK | https://attack.mitre.org | Enterprise threat framework (increasingly includes AI-assisted attacks) |

### NIST
US National Institute of Standards and Technology — framework-level guidance.

| Resource | URL | What it covers |
|---|---|---|
| NIST AI Risk Management Framework | https://www.nist.gov/artificial-intelligence | AI RMF 1.0, Playbook, profiles |
| NIST AI publications | https://csrc.nist.gov/publications | Formal publications, drafts open for comment |

### Security research outlets
Independent researchers and specialist vendors covering AI-specific threats.

| Source | URL | Focus |
|---|---|---|
| AI Village | https://aivillage.org | DEF CON AI track, red-teaming, community |
| Lakera | https://www.lakera.ai/blog | Prompt injection, guardrails, production security |
| Protect AI | https://protectai.com/blog | MLOps security, model supply chain |
| Adversa AI | https://adversa.ai/blog | Adversarial attacks, evasion techniques |
| Simon Willison (prompt injection) | https://simonwillison.net/tags/prompt-injection/ | Tracks real-world prompt injection incidents |
| Wired AI & Security | https://www.wired.com/tag/artificial-intelligence/ | Mainstream coverage of AI security incidents |
| Dark Reading | https://www.darkreading.com/keyword/artificial-intelligence | Enterprise security practitioner audience |
| Krebs on Security | https://krebsonsecurity.com | High-quality incident coverage when AI is involved |

---

## Product & Company News

### Model releases & benchmarks
| Source | URL | What to look for |
|---|---|---|
| OpenRouter models | https://openrouter.ai/models | Sorted by date; shows all available models across providers |
| LMSYS Chatbot Arena | https://chat.lmsys.org | Leaderboard shifts indicate meaningful capability changes |
| HuggingFace model hub | https://huggingface.co/models | Open-source model releases sorted by recent activity |

### Funding & M&A
| Source | URL |
|---|---|
| Crunchbase AI | https://www.crunchbase.com/hub/artificial-intelligence-companies |
| TechCrunch AI | https://techcrunch.com/category/artificial-intelligence/ |

### LinkedIn
LinkedIn posts from researchers and executives often contain opinions and context not published elsewhere.
- Search: `site:linkedin.com/posts "agentic AI" OR "LLM" 2025`
- Tags: `#LLM`, `#AgenticAI`, `#GenerativeAI`, `#AIAgents`
