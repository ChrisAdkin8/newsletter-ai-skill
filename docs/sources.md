# Source Catalogue

Full annotated list of sources used by the skill, grouped by category. This is the human-readable reference version with rationale for each source. The machine-readable version Claude uses lives at `.claude/skills/newsletter-ai/sources.md`.

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
| r/ChatGPT | Product-level discussions of ChatGPT; surfaces real-world use cases and failures |
| r/ClaudeAI | Anthropic Claude product community; good for identifying edge cases and workarounds |
| r/OpenAI | OpenAI news and community discussion |

### Hacker News

One of the highest-signal sources for technical AI discussion. Papers, tools, and controversies break here before mainstream press. Comment threads surface practitioner reactions that polished blog posts don't.

- **URL**: https://news.ycombinator.com
- **HN Search**: https://hn.algolia.com (search by date range)
- Focus on posts with 100+ points and active threads
- **Why it matters**: When something interesting happens in AI, HN often has the first substantive community reaction within hours — and the comments frequently contain corrections, nuance, and links that blogs miss

### X / Twitter

Many significant AI announcements, model releases, safety incidents, and research previews happen on X before any blog post exists. Essential for tracking the week's conversation in real time.

**Key accounts**:

| Account | Affiliation | What to watch for |
|---|---|---|
| @AnthropicAI | Anthropic | Official model and product announcements |
| @OpenAI | OpenAI | Official model and product announcements |
| @GoogleDeepMind | Google DeepMind | Research announcements |
| @sama (Sam Altman) | OpenAI CEO | Strategy signals, product intent, funding |
| @karpathy (Andrej Karpathy) | Independent | Technical insights, model intuition, LLM education |
| @ylecun (Yann LeCun) | Meta Chief AI Scientist | Contrarian views on AGI progress; architectures |
| @fchollet (François Chollet) | Google / ARC-AGI | AGI benchmarking, capability scepticism |
| @GaryMarcus | Independent AI critic | AI failures, limitation claims, hype debunking |
| @emollick (Ethan Mollick) | Wharton School | Enterprise adoption evidence, practical use cases |
| @bcherny (Boris Cherny) | Anthropic / Claude Code | Claude Code, agentic tooling |
| @danhendrycks | CAIUS | Safety research, evals, frontier risk |

### LinkedIn

LinkedIn posts from named practitioners surface field notes, opinions, and previews not published elsewhere — particularly from people who post more substantively on LinkedIn than on X. Most LinkedIn content is behind an authentication wall, so `WebFetch` of LinkedIn URLs will fail. Always use `WebSearch` with `site:linkedin.com` to find indexed posts. Search snippets are usually sufficient to assess relevance and write a summary.

**Why named profiles rather than hashtags**: Broad LinkedIn hashtag searches (#LLM, #AgenticAI) return mostly promotional content. Targeting specific individuals by profile slug produces far higher signal.

**Key profiles**:

| Name | Profile slug (linkedin.com/in/...) | Affiliation | What to watch for |
|---|---|---|---|
| Andrew Ng | andrewyng | deeplearning.ai | Applied AI essays, practical use cases, education — the most-followed ML practitioner on LinkedIn; posts weekly |
| Yann LeCun | yannlecun | Meta Chief AI Scientist | Architecture debates, AGI scepticism; notably posts more substantive content on LinkedIn than on X |
| Ethan Mollick | emollick | Wharton School | Enterprise AI adoption evidence, research-backed practical use cases; cross-posts from oneusefulthing.org |
| Mustafa Suleyman | mustafa-suleyman | Microsoft AI CEO | AI product strategy, safety framing, Microsoft AI direction |
| Cassie Kozyrkov | cassiek | ex-Google Chief Decision Scientist | AI decision-making, MLOps foundations, statistical thinking — prolific and genuinely educational |
| Sebastian Raschka | sebastianraschka | Independent researcher | LLM training, architectures, concise paper summaries — high-quality technical content in short-form |
| Jay Alammar | jalammar | Independent / Cohere | ML visualisations, transformer explanations, educational deep-dives |
| Chip Huyen | chiphuyen | Independent | Inference systems, real-world LLM deployment, MLOps; cross-posts from huyenchip.com |
| Harrison Chase | harrison-chase-961287118 | LangChain CEO | Agent frameworks, production LLM tooling, agentic design patterns |
| Jerry Liu | jerry-liu-24a8b040 | LlamaIndex CEO | RAG systems, agentic data pipelines, agent architectures |
| Gary Marcus | gary-marcus-65902 | Independent AI critic | AI failures, limitation claims, hype analysis — high-profile sceptic voice |
| Jeff Dean | jeff-dean-8b212555 | Google Senior Fellow | AI research direction, scale, Google-era ML systems |

**Search strategy**: `site:linkedin.com/posts (andrewyng OR yannlecun OR emollick OR cassiek OR sebastianraschka OR jalammar OR chiphuyen) "LLM" OR "AI agents" 2026`

---

## 2. Research & Papers

### arXiv
The primary pre-print server for AI/ML research. Most significant work appears here before journal publication.

- **cs.AI** — Artificial intelligence, reasoning, planning
- **cs.CL** — Computational linguistics, NLP, LLMs
- **cs.LG** — Machine learning, training methods, architectures
- **cs.CR** — Cryptography and security (AI security, adversarial ML)

Key search terms: `agentic`, `agent`, `RAG`, `retrieval augmented`, `tool use`, `RLHF`, `alignment`, `jailbreak`, `prompt injection`, `multi-agent`, `function calling`

### Hugging Face Daily Papers
Curates the top arXiv papers each day based on community engagement — the most reliable signal filter for highest-impact recent work. URL: https://huggingface.co/papers

### Papers with Code
Links papers to their implementations. Useful for finding papers with reproducible experiments and real code.
URL: https://paperswithcode.com/latest

### Semantic Scholar
Good for finding papers by recency with citation context — tracks which new papers are already being cited.
URL: https://www.semanticscholar.org

### Nature Machine Intelligence
High-impact peer-reviewed journal; slower cadence but authoritative on capability and societal research. URL: https://www.nature.com/natmachintell/

### Major Lab Research Publications

| Lab | URL | Notes |
|---|---|---|
| Google DeepMind | https://deepmind.google/research/publications/ | Primary source for DeepMind research before arXiv |
| Microsoft Research | https://www.microsoft.com/en-us/research/blog/ | One of the largest AI research orgs globally; covers LLMs, agents, reasoning |
| Apple ML Research | https://machinelearning.apple.com/ | On-device inference, privacy-preserving ML, multimodal; often underreported |
| Amazon Science | https://www.amazon.science/blog | AWS and Alexa AI teams; relevant for agent tooling and cloud inference |

### Alignment & Safety Research Labs

These labs are essential for agentic AI coverage. They publish work that contextualises frontier risk — often months before it surfaces in mainstream coverage or policy documents.

| Lab | URL | What they publish |
|---|---|---|
| Alignment Research Center (ARC) | https://alignment.org/blog | Alignment research, eval methodology, red-teaming |
| Center for AI Safety (CAIUS) | https://www.safe.ai/research | Policy briefs, evals, frontier risk framing. Dan Hendrycks leads this |
| Apollo Research | https://www.apolloresearch.ai/research | Deception, scheming, and agentic model evaluations |
| METR | https://metr.org | Frontier model capability benchmarking; produces evaluations used by major labs |
| Redwood Research | https://www.redwoodresearch.org/ | Adversarial training, scalable oversight, alignment techniques |
| FAR AI | https://far.ai/ | Scalable oversight, mechanistic interpretability, alignment |

**Why these matter for agentic coverage**: Agentic systems with tool use and long-horizon planning create novel failure modes (scheming, deception, goal misgeneralisation). These labs study exactly that.

### Academic Labs

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
| Microsoft Research | https://www.microsoft.com/en-us/research/blog/ | AI research with applied angle; Copilot, Azure AI |
| Microsoft Azure AI | https://azure.microsoft.com/en-us/blog/tag/ai/ | Enterprise AI deployment, Azure AI service updates |
| Apple ML Research | https://machinelearning.apple.com/ | On-device ML, private compute, multimodal |
| Amazon Science | https://www.amazon.science/blog | Cloud AI, agent tooling, inference at scale |

### Infrastructure & tooling company blogs

These companies often publish technical deep-dives before mainstream press picks them up. Particularly valuable for understanding the compute economics and serving layer that underpins agentic deployments.

| Company | URL | What they write about |
|---|---|---|
| NVIDIA Developer Blog | https://developer.nvidia.com/blog/ | CUDA, inference libraries, new GPU architecture, TensorRT |
| NVIDIA News | https://nvidianews.nvidia.com/ | Official product and partnership announcements |
| Cerebras | https://cerebras.ai/blog/ | Wafer-scale compute, speed records |
| Groq | https://groq.com/blog/ | LPU inference, throughput benchmarks |
| Lambda Labs | https://lambdalabs.com/blog/ | GPU cloud, training infrastructure |
| CoreWeave | https://www.coreweave.com/blog | GPU cloud, HPC, enterprise AI infrastructure |
| Fireworks AI | https://fireworks.ai/blog | Inference optimisation, model serving |
| Anyscale | https://www.anyscale.com/blog | Ray framework, distributed ML, production agent orchestration |
| Weights & Biases | https://wandb.ai/fully-connected | MLOps, experiment tracking, agent observability — de facto standard |
| vLLM | https://blog.vllm.ai/ | Dominant open-source inference serving; PagedAttention, throughput |
| Scale AI | https://scale.com/blog | Data labelling, fine-tuning, RLHF methodology |
| Databricks | https://www.databricks.com/blog | Enterprise LLM training and deployment; acquired MosaicML |
| Ollama | https://ollama.com/blog | Most popular local model runner |
| CrewAI | https://www.crewai.com/blog | Multi-agent frameworks, role-based agent patterns |

### AI-only and technical media

Higher signal-to-noise than general tech press — dedicated AI editorial teams, faster and more accurate on model releases.

| Outlet | URL | Strength |
|---|---|---|
| The Decoder | https://the-decoder.com | Fast, accurate model release and research coverage |
| VentureBeat AI | https://venturebeat.com/category/ai/ | Enterprise AI adoption, startup and funding coverage |
| MIT Technology Review AI | https://www.technologyreview.com/topic/artificial-intelligence/ | Long-form, credible journalism from an authoritative institution |
| Ars Technica AI | https://arstechnica.com/ai/ | Technically accurate, detailed; good model release and policy coverage |
| IEEE Spectrum AI | https://spectrum.ieee.org/artificial-intelligence | Authoritative on hardware and systems; slower but rigorous |
| The Information (AI) | https://www.theinformation.com | Breaks internal stories on major labs (paywalled; use search for free previews) |
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
| Dwarkesh Patel | https://www.dwarkeshpatel.com | Long-form interviews with frontier lab leaders |
| Ethan Mollick | https://www.oneusefulthing.org | Practical enterprise AI adoption signal; research-backed |
| Dan Hendrycks | https://www.danhendrycks.com | Evaluation commentary, frontier safety risk; leads CAIUS |
| Percy Liang | https://crfm.stanford.edu | HELM benchmark, AI transparency, evaluation methodology |
| François Chollet | https://fchollet.substack.com | Creator of ARC-AGI benchmark; influential on what "real" AI progress means |
| Gary Marcus | https://garymarcus.substack.com | High-profile AI sceptic; covers AI failures and limitation claims |
| Cameron Wolfe | https://cameronrwolfe.substack.com | High-quality deep learning newsletter with detailed paper breakdowns |

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

### AI-focused research organisations & VC firms

| Source | URL | Strength |
|---|---|---|
| Stanford HAI AI Index | https://aiindex.stanford.edu | Annual benchmark report, policy, education |
| RAND AI | https://www.rand.org/topics/artificial-intelligence.html | National security, policy implications |
| Epoch AI | https://epochai.org/blog | Compute trends, scaling, empirical forecasts |
| AI Now Institute | https://ainowinstitute.org | Labour impact, power concentration, accountability |
| OECD AI | https://oecd.ai/en/ | Policy adoption data, international comparative statistics |
| Brookings AI | https://www.brookings.edu/topic/artificial-intelligence/ | Policy analysis, governance, societal impact; credible centrist framing |
| a16z AI | https://a16z.com/ai/ | Most prominent AI-focused VC; State of AI essays, market sizing; shapes enterprise narratives |
| Sequoia Capital AI | https://www.sequoiacap.com/our-perspective/ | Strategic AI market framing, startup ecosystem trends |
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

| Resource | URL | What it covers |
|---|---|---|
| NIST AI Risk Management Framework | https://www.nist.gov/artificial-intelligence | AI RMF 1.0, Playbook, profiles |
| NIST AI publications | https://csrc.nist.gov/publications | Formal publications, drafts open for comment |

### Government cybersecurity agencies

These are the primary government sources for operational AI security guidance — a major gap in many AI security reading lists.

| Agency | URL | What it covers |
|---|---|---|
| CISA (US) | https://www.cisa.gov/artificial-intelligence | Operational AI security for critical infrastructure; joint advisories |
| ENISA (EU) | https://www.enisa.europa.eu/ | EU AI threat landscape reports; security guidance for AI Act compliance |
| NCSC (UK) | https://www.ncsc.gov.uk/section/artificial-intelligence/ | UK AI security guidance; publishes joint advisories with CISA and ENISA |

**Why these matter**: CISA, ENISA, and NCSC publish joint advisories that carry regulatory weight — not just analysis but operational requirements. Any organisation deploying AI in regulated sectors needs to track these.

### Security research outlets

| Source | URL | Focus |
|---|---|---|
| AI Village | https://aivillage.org | DEF CON AI track, red-teaming, community |
| Lakera Blog | https://www.lakera.ai/blog | Prompt injection, guardrails, production LLM security |
| Lakera Research | https://www.lakera.ai/research | Gandalf adversarial attack analysis (279k real attacks), AI Model Risk Index |
| Lakera News | https://www.lakera.ai/news | Threat intelligence bulletins and product announcements |
| HiddenLayer | https://www.hiddenlayer.com/innovation-hub | Adversarial ML research. Discovered **Policy Puppetry** (2025) — zero-day exploiting XML/JSON to bypass all major safety filters — and **EchoGram** (adversarial attack on defensive classifiers) |
| Embrace the Red | https://embracethered.com/blog/ | Johann Rehberger's documented prompt injection CVEs against GitHub Copilot (RCE via CVE-2025-53773), Claude Code, Amazon Q Developer, Windsurf, and others. The most prolific real-world prompt injection researcher |
| Snyk Labs (ex-Invariant) | https://invariantlabs.ai/blog | ETH Zurich spin-off acquired by Snyk (2025). Discovered **Tool Poisoning Attacks** (TPAs) on MCP and built MCP-Scan. Primary source for MCP security research |
| Protect AI | https://protectai.com/blog | MLOps security, model supply chain |
| Adversa AI | https://adversa.ai/blog | Adversarial attacks, evasion techniques; publishes MCP Security Digests |
| Trail of Bits | https://blog.trailofbits.com/ | Hands-on AI red-teaming and model audits; highly respected security firm |
| Microsoft Security | https://www.microsoft.com/en-us/security/blog/ | AI-assisted attacks, enterprise threat intelligence at scale |
| Simon Willison (prompt injection) | https://simonwillison.net/tags/prompt-injection/ | Real-world prompt injection incident tracker |
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
| Axios AI | https://www.axios.com/technology/artificial-intelligence |

### LinkedIn
Posts from researchers and executives often contain opinions and context not published elsewhere.
- Search: `site:linkedin.com/posts "agentic AI" OR "LLM" 2026`
- Tags: `#LLM`, `#AgenticAI`, `#GenerativeAI`, `#AIAgents`

---

## 7. Regulatory & Policy

**Always go to primary government sources first.** Secondary commentary (even from law firms) lags by days and adds interpretation that may not reflect the actual text.

### Government primary sources

| Source | URL | What it covers |
|---|---|---|
| European Commission — AI Act | https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai | EU AI Act implementation, delegated acts, sandboxes, enforcement timelines |
| UK AI Safety Institute | https://www.gov.uk/government/organisations/ai-safety-institute | UK frontier AI safety evaluations, international coordination on standards |
| White House OSTP | https://www.whitehouse.gov/ostp/ | US AI executive policy, national AI strategy, Federal agency guidance |
| FTC (US) | https://www.ftc.gov/policy/advocacy-research/tech-at-ftc | US enforcement on AI deception, unfair practices, and data misuse — enforcement actions here are news |
| UK ICO | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/ | UK data protection regulator with an active AI guidance programme |
| Canada AI (AIDA) | https://www.canada.ca/en/government/system/digital-government/digital-government-innovations/responsible-use-ai.html | First G7 country to legislate AI specifically — often underreported |
| Future of Life Institute | https://futureoflife.org/ | Policy advocacy; published the Pause AI letter; engages with EU AI Act and international governance |

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

Practitioner content focused on designing, building, and operating agentic AI systems in production.

### Vellum AI Blog
LLM development platform. Covers evaluation frameworks, orchestration patterns, and production agent architectures with a bias toward practical implementation.

- **URL**: https://www.vellum.ai/blog
- **Strength**: Evaluation methodology, prompt versioning, multi-step agent design

### ByteByteGo
One of the highest-circulation technical newsletters on system design. Increasingly covers AI infrastructure and agent architecture patterns using clear diagrams and worked examples.

- **URL**: https://blog.bytebytego.com
- **Strength**: Diagram-driven explanations, scalable system design for AI

### LangChain / LangGraph Blog
The primary source for updates to LangGraph (the dominant graph-based agent orchestration framework) and LangChain. Also publishes the periodic **State of Agent Engineering** report — a survey-based snapshot of what agents are being built in production and where the blockers are.

- **URL**: https://blog.langchain.com
- **Strength**: Authoritative on agent framework patterns; release notes for LangGraph Platform, LangGraph Studio, and LangChain 1.0

### Pydantic AI
Production-grade Python agent framework from the Pydantic team, with first-class MCP (Model Context Protocol) support. The docs/blog covers agent design patterns, multi-agent orchestration, and typed agent APIs.

- **URL**: https://ai.pydantic.dev/blog/
- **Strength**: Strong typing, MCP-native, practical production focus; increasingly referenced alongside LangGraph for typed agent patterns

---

## 9. Open Source & Specialised Infrastructure

### Hugging Face
- Open-source model releases: https://huggingface.co/models?sort=trending
- Community blog: https://huggingface.co/blog

### Key open-source tools and their blogs

| Tool | URL | Why it matters |
|---|---|---|
| vLLM | https://blog.vllm.ai/ | Dominant open-source inference serving; architectural decisions affect how agents are deployed |
| Ollama | https://ollama.com/blog | Most popular local model runner; tracks which models are available locally |
| Anyscale | https://www.anyscale.com/blog | Ray framework; distributed ML and production agent orchestration |
| SemiAnalysis | https://www.semianalysis.com | Chip economics and GPU supply chain analysis |

---

## 10. Macro & Hardware Watch

The chip supply chain and data centre capacity constrain everything else in the AI stack.

### Computing.co.uk
UK-based enterprise IT publication with dedicated AI & Machine Learning and Infrastructure verticals. Strong on European enterprise adoption and infrastructure investment angles that US-centric sources miss.

| Resource | URL |
|---|---|
| AI & Machine Learning | https://www.computing.co.uk/knowledge/artificial-intelligence |
| Infrastructure | https://www.computing.co.uk/knowledge/infrastructure |

### Hardware & semiconductor sources

| Source | URL | Strength |
|---|---|---|
| NVIDIA News (primary) | https://nvidianews.nvidia.com/ | Official NVIDIA product announcements — the most important company in the AI stack |
| NVIDIA Developer Blog | https://developer.nvidia.com/blog/ | CUDA, inference libraries, GPU architecture deep-dives |
| SemiAnalysis | https://www.semianalysis.com | Best analysis of chip industry economics and GPU supply chain |
| The Next Platform | https://www.nextplatform.com/ | Best publication covering HPC and AI infrastructure economics in depth |
| Datacenter Dynamics | https://www.datacenterdynamics.com/ | Industry bible for data centre construction, power capacity, and AI infrastructure buildout |
| Cerebras blog | https://cerebras.ai/blog/ | Wafer-scale compute, interconnect architecture |
| Groq blog | https://groq.com/blog/ | LPU inference, throughput, energy efficiency |
| The Information (AI hardware) | search `"AI chips" OR "GPU" site:theinformation.com` | Insider reporting on Nvidia, AMD, custom silicon |
| Tom's Hardware AI | https://www.tomshardware.com | GPU benchmarks, hardware release coverage |

---

## 11. Model Evaluations & Transparency Reports

Evaluation is now a discipline in its own right — large enough to stand alone, distinct from research papers (§2) and product news (§6). Tracks how models are measured, compared, and held accountable, including inference economics.

### LMSYS

The team behind Chatbot Arena. Their blog provides methodology insights, dataset releases, and analysis of preference data that goes well beyond the Arena UI.

- **Blog**: https://lmsys.org/blog/
- **Arena**: https://chat.lmsys.org
- **Strength**: Human preference data at scale, Elo methodology, head-to-head model comparisons

### Artificial Analysis

Tracks model quality, inference speed, and cost across providers in real time. Essential for understanding the economics of model deployment — not just capability but cost-per-token and latency under load.

- **Analysis blog**: https://artificialanalysis.ai/blog
- **Live data**: https://artificialanalysis.ai
- **Strength**: Provider-agnostic, continuously updated, tracks price and performance together

### Scale AI — SEAL Leaderboards

Expert-annotated safety and capability evaluations with higher rigour than crowd-sourced alternatives.

- **URL**: https://scale.com/leaderboard
- **Strength**: Expert annotation quality, task-specificity, safety dimension

### HELM (Holistic Evaluation of Language Models)

Standardised, reproducible benchmarks from Stanford CRFM (Percy Liang's group). The most comprehensive single framework: accuracy, calibration, robustness, fairness, and efficiency.

- **URL**: https://crfm.stanford.edu/helm/latest/
- **Strength**: Reproducibility, breadth of metrics, institutional credibility

### LiveBench

Contamination-free benchmarks using current-events questions — directly addresses the key weakness of static benchmarks (where training data may contain test answers).

- **URL**: https://livebench.ai/
- **Strength**: Contamination-resistant; grows over time; growing credibility in the research community

### AlpacaEval

Widely used instruction-following evaluation; frequently referenced in paper comparisons as a standard reference point.

- **URL**: https://tatsu-lab.github.io/alpaca_eval/
- **Strength**: Lightweight, widely adopted, good for relative comparisons

### Hugging Face Open LLM Leaderboard

Community-maintained benchmark leaderboard comparing open-source models across standard tasks.

- **URL**: https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard
- **Strength**: Open-source focus, community velocity, tracks fine-tunes and base models

### WhatLLM.org

Weekly digest of model ranking changes — useful for tracking momentum without parsing raw leaderboard diffs.

- **URL**: https://whatllm.org
