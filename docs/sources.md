# Source Catalogue

Full annotated list of sources used by the skill, grouped by category. This is the human-readable reference version. The machine-readable version Claude uses lives at `.claude/skills/newsletter-ai/sources.md`.

---

## 1. Community & Discussion

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

## 2. Research & Papers

### arXiv
The primary pre-print server for AI/ML research. Most significant work appears here before journal publication.

- **cs.AI** — Artificial intelligence, reasoning, planning
- **cs.CL** — Computational linguistics, NLP, LLMs
- **cs.LG** — Machine learning, training methods, architectures
- **cs.CR** — Cryptography and security (covers AI security, adversarial ML)

Key search terms: `agentic`, `agent`, `RAG`, `retrieval augmented`, `tool use`, `RLHF`, `alignment`, `jailbreak`, `prompt injection`, `multi-agent`, `function calling`

### Hugging Face Daily Papers
Curates the top arXiv papers each day based on community engagement. A reliable signal filter. URL: https://huggingface.co/papers

### Papers with Code
Links papers to their implementations. Useful for finding papers with reproducible experiments.
URL: https://paperswithcode.com/latest

### Semantic Scholar
Good for finding papers by recency with citation context.
URL: https://www.semanticscholar.org

### Google DeepMind Publications
Primary source for DeepMind research that may not appear on arXiv immediately.
URL: https://deepmind.google/research/publications/

### Alignment & Safety Research Labs

These labs are essential for tracking agentic AI. They publish work that contextualises frontier risk — often months before it surfaces in mainstream coverage or policy documents.

| Lab | URL | What they publish |
|---|---|---|
| Alignment Research Center (ARC) | https://alignment.org/blog | Alignment research, eval methodology, red-teaming |
| Center for AI Safety (CAIUS) | https://www.safe.ai/research | Policy briefs, evals, frontier risk framing — Dan Hendrycks leads this |
| Apollo Research | https://www.apolloresearch.ai/research | Deception, scheming, agentic model evaluations |
| METR | https://metr.org | Frontier model capability benchmarking; produces METR Evals used by major labs |

**Why these matter for agentic coverage**: Agentic systems with tool use and long-horizon planning create novel failure modes (scheming, deception, goal misgeneralisation). These labs study exactly that.

### Academic Labs

These labs contextualise and operationalise arXiv research — more practical interpretation than raw papers.

| Lab | URL | Focus |
|---|---|---|
| Stanford HAI | https://hai.stanford.edu/news | AI policy, economics of AI, societal impact |
| Berkeley AI Research (BAIR) | https://bair.berkeley.edu/blog/ | Robotics, RL, LLM research with code |
| Allen Institute for AI (AI2) | https://allenai.org/blog | Open research, NLP, reasoning, open-source models |
| EleutherAI | https://blog.eleuther.ai/ | Open-source model training, interpretability, evals |

---

## 3. Technical Blogs & Engineering Posts

### Major lab blogs

| Organisation | URL | What to expect |
|---|---|---|
| Anthropic | https://www.anthropic.com/news | Model releases, safety research, policy |
| Anthropic Research | https://www.anthropic.com/research | Technical papers and interpretability work |
| OpenAI | https://openai.com/news/ | Model releases, API updates, safety announcements |
| Google DeepMind | https://deepmind.google/discover/blog/ | Research results, model releases |
| Meta AI | https://ai.meta.com/blog/ | Open-source model releases, research |
| Hugging Face | https://huggingface.co/blog | Open-source tooling, model releases, tutorials |

### Infrastructure company blogs

These companies often publish technical deep-dives before mainstream press picks them up. Particularly valuable for understanding the compute economics and serving layer that underpins agentic deployments.

| Company | URL | What they write about |
|---|---|---|
| Cerebras | https://cerebras.ai/blog/ | Wafer-scale compute, speed records, architecture |
| Groq | https://groq.com/blog/ | LPU architecture, inference speed, throughput benchmarks |
| Lambda Labs | https://lambdalabs.com/blog/ | GPU cloud, training infrastructure, cost comparisons |
| CoreWeave | https://www.coreweave.com/blog | GPU cloud, HPC, enterprise AI infrastructure |
| Fireworks AI | https://fireworks.ai/blog | Inference optimisation, model serving, speculative decoding |
| Anyscale | https://www.anyscale.com/blog | Ray framework, distributed ML, production agent systems |

### AI-only media

Higher signal-to-noise than general tech press because they have dedicated AI editorial teams.

| Outlet | URL | Strength |
|---|---|---|
| The Decoder | https://the-decoder.com | Fast, accurate model release and research coverage |
| VentureBeat AI | https://venturebeat.com/category/ai/ | Enterprise AI adoption, startup and funding coverage |
| ML News | https://mlnews.org | Curated weekly ML developments across sources |

### Individual researchers & practitioners

Publish infrequently but with depth. These individuals often surface shifts before companies formalise them.

| Author | URL | Focus |
|---|---|---|
| Sebastian Raschka | https://magazine.sebastianraschka.com | Training, architectures, paper reviews |
| Lilian Weng (OpenAI) | https://lilianweng.github.io | Deep technical surveys, agent architectures |
| Simon Willison | https://simonwillison.net | LLM tooling, prompt injection, practical use |
| Andrej Karpathy | https://karpathy.ai | Fundamentals, model internals |
| Nathan Lambert | https://www.interconnects.ai | RLHF, alignment, open-source models |
| Chip Huyen | https://huyenchip.com/blog | MLOps, deployment, real-world LLM systems |
| Dwarkesh Patel | https://www.dwarkeshpatel.com | Long-form interviews with frontier lab leaders; surfaces strategic thinking early |
| Ethan Mollick | https://www.oneusefulthing.org | Practical enterprise AI adoption signal; research-backed, accessible |
| Dan Hendrycks | https://www.danhendrycks.com | Evaluation commentary, frontier safety risk; leads CAIUS |
| Percy Liang | https://crfm.stanford.edu | HELM benchmark, AI transparency, evaluation methodology; Stanford CRFM |

### Engineering & framework blogs

- LangChain: https://blog.langchain.dev
- LlamaIndex: https://www.llamaindex.ai/blog
- Cohere: https://cohere.com/blog
- Mistral AI: https://mistral.ai/news/
- Together AI: https://www.together.ai/blog

---

## 4. Analyst & Industry Reports

### Tier-1 management consulting & analyst firms

| Source | URL | Strength |
|---|---|---|
| Gartner | https://www.gartner.com/en/information-technology/insights/artificial-intelligence | Hype Cycle, Magic Quadrant, CIO surveys |
| Forrester | https://www.forrester.com/research/artificial-intelligence/ | Enterprise buyer research, vendor evaluations |
| IDC | https://www.idc.com/research/AI | Market sizing, spending forecasts |
| McKinsey Global Institute | https://www.mckinsey.com/capabilities/quantumblack/our-insights | Economic impact, transformation surveys |
| BCG Henderson Institute | https://www.bcg.com/capabilities/artificial-intelligence | Strategic framing, sector analysis |
| Deloitte Insights | https://www2.deloitte.com/us/en/insights/topics/ai-and-machine-learning.html | Enterprise readiness, risk |

### AI-focused research organisations

| Source | URL | Strength |
|---|---|---|
| Stanford HAI AI Index | https://aiindex.stanford.edu | Annual benchmark report, policy, education |
| RAND AI | https://www.rand.org/topics/artificial-intelligence.html | National security, policy implications |
| Epoch AI | https://epochai.org/blog | Compute trends, scaling, empirical forecasts |
| AI Now Institute | https://ainowinstitute.org | Labour impact, power, accountability; critical AI research |
| OECD AI | https://oecd.ai/en/ | Policy adoption data, international comparative statistics |
| AI Snake Oil | https://www.aisnakeoil.com | Sceptical, evidence-based critique |
| Import AI (Jack Clark) | https://jack-clark.net | Weekly digest, safety, capabilities |
| The Gradient | https://thegradient.pub | Academic-adjacent, deep technical coverage |
| Stratechery (Ben Thompson) | https://stratechery.com | Business strategy, platform dynamics |

---

## 5. AI Security

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

## 6. Product & Company News

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
- Search: `site:linkedin.com/posts "agentic AI" OR "LLM" 2026`
- Tags: `#LLM`, `#AgenticAI`, `#GenerativeAI`, `#AIAgents`

---

## 7. Regulatory & Policy

Government, legal, and compliance developments that affect how AI systems can be built and deployed. **Primary government sources beat secondary commentary** — always go to the source first.

### Government primary sources

| Source | URL | What it covers |
|---|---|---|
| European Commission — AI Act | https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai | EU AI Act implementation, delegated acts, sandboxes, enforcement timelines |
| UK AI Safety Institute | https://www.gov.uk/government/organisations/ai-safety-institute | UK frontier AI safety evaluations, international coordination on standards |
| White House OSTP | https://www.whitehouse.gov/ostp/ | US AI executive policy, national AI strategy, Federal agency guidance |

**Why primary sources matter**: Secondary commentary (even from law firms) lags by days and adds interpretation that may not reflect the actual text. Go primary when the story involves new guidance or enforcement actions.

### Legal & compliance commentary

| Source | URL | What it covers |
|---|---|---|
| IAPP News & Analysis | https://iapp.org/news/ | Daily news on privacy law, AI regulation globally |
| IAPP AI Governance | https://iapp.org/resources/article-archive/ai-governance/ | In-depth practitioner guides and frameworks |
| Covington — Inside Privacy | https://www.insideprivacy.com | Data protection, AI Act, privacy enforcement (US & EU) |
| Covington — Inside Global Tech | https://www.insideglobaltech.com | Cross-border tech regulation, AI policy |
| HSF Kramer — Behind the Prompt | search `"Behind the Prompt" HSF Kramer site:linkedin.com` | Monthly AI insights, legal and enterprise AI governance trends |

---

## 8. Agent Era & Technical Workflows

Practitioner content focused specifically on designing, building, and operating agentic AI systems in production.

### Vellum AI Blog
Vellum is an LLM development platform. Their blog covers evaluation frameworks, orchestration patterns, and production agent architectures with a bias toward practical implementation over theory.

- **URL**: https://www.vellum.ai/blog
- **Strength**: Evaluation methodology, prompt versioning, multi-step agent design

### ByteByteGo
One of the highest-circulation technical newsletters on system design. Increasingly covers AI infrastructure and agent architecture patterns using clear diagrams and worked examples.

- **URL**: https://blog.bytebytego.com
- **Strength**: Diagram-driven explanations, scalable system design for AI, broad technical audience

---

## 9. Open Source & Specialised Infrastructure

Sources covering the open-source model ecosystem and infrastructure required to run models at scale.

### Hugging Face (open-source angle)
- Open-source model releases: https://huggingface.co/models?sort=trending
- Community blog: https://huggingface.co/blog
- (Evaluation leaderboard moved to section 11)

### Infrastructure & scaling
- **Anyscale blog**: https://www.anyscale.com/blog — Ray framework, distributed ML, production agent orchestration
- **SemiAnalysis**: https://www.semianalysis.com — chip economics, GPU supply chain deep dives

---

## 10. Macro & Hardware Watch

The chip supply chain and data centre capacity constrain everything else in the AI stack. These sources cover the infrastructure layer below the model.

### Computing.co.uk
UK-based enterprise IT publication with dedicated AI & Machine Learning and Infrastructure verticals. Strong on European enterprise adoption and infrastructure investment angles that US-centric sources miss.

| Resource | URL |
|---|---|
| AI & Machine Learning | https://www.computing.co.uk/knowledge/artificial-intelligence |
| Infrastructure | https://www.computing.co.uk/knowledge/infrastructure |

### Hardware & semiconductor sources

| Source | URL | Strength |
|---|---|---|
| SemiAnalysis | https://www.semianalysis.com | Deep chip industry analysis, GPU economics, supply chain |
| Cerebras blog | https://cerebras.ai/blog/ | Wafer-scale compute, interconnect architecture |
| Groq blog | https://groq.com/blog/ | LPU inference, throughput, energy efficiency |
| Tom's Hardware AI | https://www.tomshardware.com | GPU benchmarks, hardware release coverage |
| The Information (AI hardware) | search `"AI chips" OR "GPU" site:theinformation.com` | Insider reporting on Nvidia, AMD, custom silicon |

---

## 11. Model Evaluations & Transparency Reports

Evaluation is now a discipline in its own right. This category is large enough to stand alone — distinct from research papers (section 2) and product news (section 6). It tracks how models are being measured, compared, and held accountable, including inference economics and transparency reporting.

### LMSYS

The team behind Chatbot Arena. Their blog provides methodology insights, dataset releases, and analysis of preference data that goes well beyond what the Arena UI shows.

- **Blog**: https://lmsys.org/blog/
- **Arena**: https://chat.lmsys.org
- **Strength**: Human preference data at scale, Elo methodology, head-to-head model comparisons

### Artificial Analysis

Tracks model quality, inference speed, and cost across providers in real time. Essential for understanding the economics of model deployment — not just capability but cost-per-token and latency under load.

- **Analysis blog**: https://artificialanalysis.ai/blog
- **Live data**: https://artificialanalysis.ai
- **Strength**: Provider-agnostic, continuously updated, tracks price and performance together

### Scale AI — SEAL Leaderboards

Expert-annotated safety and capability evaluations. Higher rigour than crowd-sourced alternatives because evaluators are domain specialists. Task-specific leaderboards for coding, instruction following, safety, and more.

- **URL**: https://scale.com/leaderboard
- **Strength**: Expert annotation quality, task-specificity, safety dimension

### HELM (Holistic Evaluation of Language Models)

Standardised, reproducible benchmarks from Stanford CRFM (Percy Liang's group). Covers accuracy, calibration, robustness, fairness, and efficiency — the most comprehensive single framework.

- **URL**: https://crfm.stanford.edu/helm/latest/
- **Strength**: Reproducibility, breadth of metrics, institutional credibility

### Hugging Face Open LLM Leaderboard

Community-maintained benchmark leaderboard comparing open-source models across standard tasks. Leaderboard shifts often indicate meaningful capability improvements in the open-source ecosystem.

- **URL**: https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard
- **Strength**: Open-source focus, community velocity, tracks fine-tunes and base models

### WhatLLM.org

Weekly digest of model ranking changes. Useful for tracking momentum without parsing raw leaderboard diffs yourself.

- **URL**: https://whatllm.org
- **Strength**: Summarised, time-aware view of leaderboard movement
