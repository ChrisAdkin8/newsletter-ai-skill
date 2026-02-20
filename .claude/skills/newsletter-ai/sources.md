# Newsletter Sources

Use these sources and search strategies for each category. Always prefer primary sources over aggregators. Check dates carefully.

---

## 1. Community & Discussion

### Reddit

Search these subreddits for high-engagement posts (100+ upvotes preferred):

| Subreddit | Focus |
|---|---|
| r/MachineLearning | Research, papers, technical discussion |
| r/LocalLLaMA | Open-source models, local inference, fine-tuning |
| r/artificial | General AI news and discussion |
| r/AIAssistants | Agent frameworks, chatbots, workflows |
| r/LanguageModelAPI | API usage, prompting, integrations |
| r/singularity | Capability milestones, futures discussion |
| r/AIdev | Developer tools and frameworks |
| r/ChatGPT | OpenAI product discussion, real-world use cases |
| r/ClaudeAI | Anthropic product discussion and community |
| r/OpenAI | OpenAI news, research, and community |

**Search strategy**: Use `site:reddit.com` in WebSearch with keywords like `"agentic AI"`, `"LLM"`, `"Claude"`, `"GPT"`, `"agent"`, `"fine-tuning"` plus `after:YYYY-MM-DD`.

### Hacker News

One of the highest-signal sources for technical AI discussion. Papers, tools, and controversies often break here before mainstream press. Threads surface practitioner reactions that blogs and press releases don't capture.

- **URL**: https://news.ycombinator.com
- **Search strategy**: `site:news.ycombinator.com "AI" OR "LLM" OR "agent"` — or use HN Search at https://hn.algolia.com
- Focus on posts with 100+ points and active comment threads

### X / Twitter

Many significant AI announcements, capability claims, and safety incidents happen on X before any blog post. Monitor these accounts and search for key terms.

**Key accounts to search**:

| Account | Affiliation | Signal type |
|---|---|---|
| @AnthropicAI | Anthropic | Official announcements |
| @OpenAI | OpenAI | Official announcements |
| @GoogleDeepMind | Google DeepMind | Official announcements |
| @sama (Sam Altman) | OpenAI CEO | Strategy, product intent |
| @karpathy (Andrej Karpathy) | Independent | Technical insights, model intuition |
| @ylecun (Yann LeCun) | Meta Chief AI Scientist | Contrarian views on progress |
| @fchollet (François Chollet) | Google / ARC-AGI | AGI benchmarking, capability scepticism |
| @GaryMarcus | Independent | AI criticism, failure cases |
| @emollick (Ethan Mollick) | Wharton | Enterprise adoption, real-world use |
| @bcherny (Boris Cherny) | Anthropic / Claude Code | Claude Code, agentic tooling |
| @danhendrycks | CAIUS | Safety, evals, frontier risk |

**Search strategy**: `site:twitter.com OR site:x.com "LLM" OR "agentic AI" OR "model release" 2026`

### LinkedIn

LinkedIn posts from named practitioners surface opinions, field notes, and previews not published elsewhere. Most content is behind an auth wall, so `WebFetch` of LinkedIn URLs will fail — always use `WebSearch` with `site:linkedin.com`. Search snippets are usually sufficient to assess and summarise.

**Key profiles**:

| Name | Profile slug (linkedin.com/in/...) | Affiliation | Signal type |
|---|---|---|---|
| Andrew Ng | andrewyng | deeplearning.ai | Applied AI essays, education, weekly field notes — most-followed ML person on LinkedIn |
| Yann LeCun | yannlecun | Meta Chief AI Scientist | Architecture debates, AGI scepticism; more substantive on LinkedIn than X |
| Ethan Mollick | emollick | Wharton School | Enterprise AI adoption evidence, research-backed practical use cases |
| Mustafa Suleyman | mustafa-suleyman | Microsoft AI CEO | AI strategy, product direction, safety framing |
| Cassie Kozyrkov | cassiek | ex-Google Chief Decision Scientist | AI decision-making, MLOps foundations, AI literacy |
| Sebastian Raschka | sebastianraschka | Independent researcher | LLM training, architectures, concise paper summaries |
| Jay Alammar | jalammar | Independent / Cohere | ML visualisations, transformer explanations, educational deep-dives |
| Chip Huyen | chiphuyen | Independent | Inference systems, real-world LLM deployment, MLOps |
| Harrison Chase | harrison-chase-961287118 | LangChain CEO | Agent frameworks, production LLM tooling |
| Jerry Liu | jerry-liu-24a8b040 | LlamaIndex CEO | RAG systems, agent architectures |
| Gary Marcus | gary-marcus-65902 | Independent AI critic | AI limitations, failure cases, hype analysis |
| Jeff Dean | jeff-dean-8b212555 | Google Senior Fellow | AI research direction, systems at scale |

**Search strategy**: `site:linkedin.com/posts (andrewyng OR yannlecun OR emollick OR cassiek OR sebastianraschka OR jalammar OR chiphuyen) "LLM" OR "AI agents" 2026`

---

## 2. Research & Papers

### arXiv
- **URL**: https://arxiv.org/search/?searchtype=all&query=agentic+AI+LLM&start=0
- **Categories to search**: cs.AI, cs.CL, cs.LG, cs.CR (security)
- Search for: `agentic`, `agent`, `RAG`, `tool use`, `RLHF`, `alignment`, `jailbreak`, `prompt injection`
- **Hugging Face daily papers**: https://huggingface.co/papers (aggregates top arXiv papers daily)

### Papers with Code
- **URL**: https://paperswithcode.com/latest
- Focus on: tasks tagged `language-modelling`, `question-answering`, `agents`, `code-generation`

### Semantic Scholar
- Search: https://www.semanticscholar.org/search?q=agentic+AI&sort=Relevance&timeRange=last-30-days

### Nature Machine Intelligence
- **URL**: https://www.nature.com/natmachintell/
- High-impact peer-reviewed journal; slower cadence but authoritative on capability and societal research

### Major Lab Research Publications

| Lab | URL |
|---|---|
| Google DeepMind | https://deepmind.google/research/publications/ |
| Microsoft Research | https://www.microsoft.com/en-us/research/blog/ |
| Apple ML Research | https://machinelearning.apple.com/ |
| Amazon Science | https://www.amazon.science/blog |

**Search strategy**: `site:microsoft.com/en-us/research "language model" OR "agent"`, `site:machinelearning.apple.com`, `site:amazon.science "LLM"`.

### Alignment & Safety Research Labs

Essential for tracking agentic AI safety — these labs publish work that contextualises frontier risk before it surfaces in mainstream coverage.

| Lab | URL | Focus |
|---|---|---|
| Alignment Research Center (ARC) | https://alignment.org/blog | Alignment research, evals, red-teaming |
| Center for AI Safety (CAIUS) | https://www.safe.ai/research | Policy, evals, frontier risk framing |
| Apollo Research | https://www.apolloresearch.ai/research | Deception, scheming, agent evaluations |
| METR | https://metr.org | Frontier model capability benchmarking |
| Redwood Research | https://www.redwoodresearch.org/ | Adversarial training, alignment techniques |
| FAR AI | https://far.ai/ | Scalable oversight, alignment research |

**Search strategy**: `site:alignment.org`, `site:safe.ai/research`, `site:apolloresearch.ai`, `site:metr.org`, `site:redwoodresearch.org`, `site:far.ai`, `"frontier AI" eval 2026`.

### Academic Labs

| Lab | URL | Focus |
|---|---|---|
| Stanford HAI | https://hai.stanford.edu/news | AI policy, economics, society |
| Berkeley AI Research (BAIR) | https://bair.berkeley.edu/blog/ | Robotics, RL, LLM research |
| Allen Institute for AI (AI2) | https://allenai.org/blog | Open research, NLP, reasoning |
| EleutherAI | https://blog.eleuther.ai/ | Open-source models, interpretability, evals |

---

## 3. Technical Blogs & Engineering Posts

### Major lab blogs

| Lab | URL |
|---|---|
| Anthropic | https://www.anthropic.com/news |
| Anthropic Research | https://www.anthropic.com/research |
| OpenAI | https://openai.com/news/ |
| Google DeepMind | https://deepmind.google/discover/blog/ |
| Meta AI | https://ai.meta.com/blog/ |
| Hugging Face | https://huggingface.co/blog |
| Microsoft Research | https://www.microsoft.com/en-us/research/blog/ |
| Microsoft Azure AI | https://azure.microsoft.com/en-us/blog/tag/ai/ |
| Apple ML Research | https://machinelearning.apple.com/ |
| Amazon Science | https://www.amazon.science/blog |

### Infrastructure & tooling company blogs

These companies often publish technical deep-dives before mainstream press picks them up.

| Company | URL | Focus |
|---|---|---|
| NVIDIA Developer | https://developer.nvidia.com/blog/ | CUDA, inference, new GPU architectures |
| NVIDIA News | https://nvidianews.nvidia.com/ | Official product announcements |
| Cerebras | https://cerebras.ai/blog/ | Wafer-scale AI compute |
| Groq | https://groq.com/blog/ | Inference speed, LPU architecture |
| Lambda Labs | https://lambdalabs.com/blog/ | GPU cloud, training infrastructure |
| CoreWeave | https://www.coreweave.com/blog | GPU cloud, HPC, AI infra |
| Fireworks AI | https://fireworks.ai/blog | Inference optimisation, model serving |
| Anyscale | https://www.anyscale.com/blog | Ray, distributed ML, production agents |
| Weights & Biases | https://wandb.ai/fully-connected | MLOps, experiment tracking, agent observability |
| vLLM | https://blog.vllm.ai/ | Inference serving, PagedAttention, throughput |
| Scale AI | https://scale.com/blog | Data labelling, fine-tuning, RLHF methodology |
| Databricks | https://www.databricks.com/blog | Enterprise LLM training and deployment |
| Ollama | https://ollama.com/blog | Local model running and distribution |
| CrewAI | https://www.crewai.com/blog | Multi-agent frameworks, role-based agents |

### AI-only and technical media

Higher signal-to-noise than general tech press.

| Outlet | URL | Strength |
|---|---|---|
| The Decoder | https://the-decoder.com | Fast, accurate model release coverage |
| VentureBeat AI | https://venturebeat.com/category/ai/ | Enterprise AI, startup coverage |
| MIT Technology Review AI | https://www.technologyreview.com/topic/artificial-intelligence/ | Credible long-form journalism |
| Ars Technica AI | https://arstechnica.com/ai/ | Technically accurate, detailed model coverage |
| IEEE Spectrum AI | https://spectrum.ieee.org/artificial-intelligence | Authoritative on hardware and systems |
| The Information (AI) | https://www.theinformation.com | Breaks stories on major lab internals (paywalled) |
| ML News | https://mlnews.org | Curated weekly ML developments |

### Individual researchers & practitioners

| Author | URL | Focus |
|---|---|---|
| Sebastian Raschka | https://magazine.sebastianraschka.com | Training, architectures, paper reviews |
| Lilian Weng | https://lilianweng.github.io | Deep technical surveys, agent architectures |
| Simon Willison | https://simonwillison.net | LLM tooling, prompt injection, practical use |
| Andrej Karpathy | https://karpathy.ai | Fundamentals, model internals |
| Nathan Lambert | https://www.interconnects.ai | RLHF, alignment, open-source models |
| Chip Huyen | https://huyenchip.com/blog | MLOps, deployment, real-world LLM systems |
| Dwarkesh Patel | https://www.dwarkeshpatel.com | Long-form interviews with frontier lab leaders |
| Ethan Mollick | https://www.oneusefulthing.org | Practical enterprise AI adoption signal |
| Dan Hendrycks | https://www.danhendrycks.com | Eval commentary, safety, frontier risk |
| Percy Liang | https://crfm.stanford.edu | HELM, transparency, evaluation frameworks |
| François Chollet | https://fchollet.substack.com | ARC-AGI benchmark, AGI definitions, capability scepticism |
| Gary Marcus | https://garymarcus.substack.com | AI criticism, failure cases, hype analysis |
| Cameron Wolfe | https://cameronrwolfe.substack.com | Deep learning deep-dives, paper breakdowns |

### Engineering & framework blogs
- LangChain: https://blog.langchain.dev
- LlamaIndex: https://www.llamaindex.ai/blog
- Cohere: https://cohere.com/blog
- Mistral: https://mistral.ai/news/
- Together AI: https://www.together.ai/blog

---

## 4. Analyst & Industry Reports

### Tier-1 Analysts
| Source | URL |
|---|---|
| Gartner | https://www.gartner.com/en/information-technology/insights/artificial-intelligence |
| Forrester | https://www.forrester.com/research/artificial-intelligence/ |
| IDC | https://www.idc.com/research/AI |
| McKinsey Global Institute | https://www.mckinsey.com/capabilities/quantumblack/our-insights |
| BCG Henderson Institute | https://www.bcg.com/capabilities/artificial-intelligence |
| Deloitte Insights | https://www2.deloitte.com/us/en/insights/topics/ai-and-machine-learning.html |

### AI-focused analyst & VC firms

| Source | URL | Strength |
|---|---|---|
| The AI Index (Stanford HAI) | https://aiindex.stanford.edu | Annual benchmark report, policy, education |
| RAND AI | https://www.rand.org/topics/artificial-intelligence.html | National security, policy implications |
| Epoch AI | https://epochai.org/blog | Compute trends, scaling, empirical forecasts |
| AI Now Institute | https://ainowinstitute.org | Labour impact, power, accountability |
| OECD AI | https://oecd.ai/en/ | Policy adoption data, international statistics |
| Brookings AI | https://www.brookings.edu/topic/artificial-intelligence/ | Policy analysis, governance, societal impact |
| a16z AI | https://a16z.com/ai/ | VC perspective, State of AI essays, market sizing |
| Sequoia Capital AI | https://www.sequoiacap.com/our-perspective/ | Strategic AI market framing, startup trends |
| AI Snake Oil | https://www.aisnakeoil.com | Sceptical, evidence-based critique |
| Import AI (Jack Clark) | https://jack-clark.net | Weekly digest, safety, capabilities |
| The Gradient | https://thegradient.pub | Academic-adjacent, deep technical coverage |
| Ben Thompson / Stratechery | https://stratechery.com | Business strategy, platform dynamics |

**Search strategy**: `site:gartner.com AI agents`, `"agentic AI" site:mckinsey.com`, `site:a16z.com AI`, `site:brookings.edu artificial-intelligence`.

---

## 5. AI Security

### OWASP
- **OWASP Top 10 for LLM Applications**: https://owasp.org/www-project-top-10-for-large-language-model-applications/
- **OWASP AI Exchange**: https://owaspai.org
- GitHub for latest updates: https://github.com/OWASP/www-project-top-10-for-large-language-model-applications

### MITRE
- **MITRE ATLAS** (adversarial ML threat matrix): https://atlas.mitre.org
- **MITRE CVE** (search for AI/LLM CVEs): https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=LLM
- **ATT&CK for AI**: search https://attack.mitre.org

### NIST
- **AI Risk Management Framework**: https://www.nist.gov/artificial-intelligence
- **NIST AI publications**: https://csrc.nist.gov/publications (filter by AI)

### Government cybersecurity agencies

Primary government sources for operational AI security guidance — essential alongside OWASP and MITRE.

| Agency | URL | Covers |
|---|---|---|
| CISA (US) | https://www.cisa.gov/artificial-intelligence | US operational AI security, critical infrastructure guidance |
| ENISA (EU) | https://www.enisa.europa.eu/ | EU AI threat landscape, security guidelines for AI Act |
| NCSC (UK) | https://www.ncsc.gov.uk/section/artificial-intelligence/ | UK AI security guidance, joint CISA/NCSC advisories |

**Search strategy**: `site:cisa.gov AI`, `site:enisa.europa.eu "artificial intelligence"`, `site:ncsc.gov.uk AI`.

### Security research & news

| Source | URL | Focus |
|---|---|---|
| AI Village | https://aivillage.org | DEF CON AI track, red-teaming, community |
| Lakera AI Security | https://www.lakera.ai/blog | Prompt injection, guardrails, production security |
| Protect AI | https://protectai.com/blog | MLOps security, model supply chain |
| Adversa AI | https://adversa.ai/blog | Adversarial attacks, evasion techniques |
| Trail of Bits | https://blog.trailofbits.com/ | Hands-on AI red-teaming and model audits |
| Microsoft Security | https://www.microsoft.com/en-us/security/blog/ | AI-assisted attacks, enterprise threat intelligence |
| Simon Willison (prompt injection) | https://simonwillison.net/tags/prompt-injection/ | Real-world prompt injection incidents |
| Wired AI & Security | https://www.wired.com/tag/artificial-intelligence/ | Mainstream AI security incidents |
| Dark Reading AI | https://www.darkreading.com/keyword/artificial-intelligence | Enterprise security practitioner coverage |
| Krebs on Security (AI-related) | https://krebsonsecurity.com | High-quality incident coverage |

**Search strategy**: `site:owasp.org LLM`, `site:cisa.gov AI security`, `"prompt injection" site:github.com`, `"AI security" CVE 2026`, `MITRE ATLAS new technique`.

---

## 6. Product & Company News

### Model releases & benchmarks
- Search: `"new model" OR "model release" LLM site:huggingface.co`
- OpenRouter model list: https://openrouter.ai/models (sorted by date)
- LMSYS Chatbot Arena: https://chat.lmsys.org (leaderboard changes)

### Funding & M&A
- Search: `AI startup funding 2026 series`
- Crunchbase AI: https://www.crunchbase.com/hub/artificial-intelligence-companies
- TechCrunch AI: https://techcrunch.com/category/artificial-intelligence/
- Axios AI: https://www.axios.com/technology/artificial-intelligence

### LinkedIn
Named practitioner profiles — see **1. Community & Discussion → LinkedIn** for the full profile list and search strategy.

---

## 7. Regulatory & Policy

Track government, legal, and compliance developments. **Always go to primary government sources first** — secondary commentary lags by days and adds interpretation.

### Government primary sources

| Source | URL | Covers |
|---|---|---|
| European Commission — AI Act | https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai | EU AI Act implementation, delegated acts, enforcement |
| UK AI Safety Institute | https://www.gov.uk/government/organisations/ai-safety-institute | UK frontier AI safety, evaluations, international coordination |
| White House OSTP | https://www.whitehouse.gov/ostp/ | US AI executive policy, national strategy |
| FTC (US) | https://www.ftc.gov/policy/advocacy-research/tech-at-ftc | US enforcement on AI deception, unfair practices, data misuse |
| UK ICO | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/ | UK data protection regulator; AI guidance affecting LLM deployments |
| Canada AI (AIDA) | https://www.canada.ca/en/government/system/digital-government/digital-government-innovations/responsible-use-ai.html | First G7 AI legislation (Artificial Intelligence and Data Act) |
| Future of Life Institute | https://futureoflife.org/ | AI policy advocacy, open letters, international governance |

**Search strategy**: `"EU AI Act" enforcement site:ec.europa.eu`, `site:gov.uk "AI Safety Institute"`, `site:ftc.gov AI`, `site:ico.org.uk artificial-intelligence`, `"AIDA" Canada AI legislation`.

### Legal & compliance commentary

| Source | URL | Focus |
|---|---|---|
| IAPP News & Analysis | https://iapp.org/news/ | Privacy law, AI governance, data protection |
| IAPP AI Governance | https://iapp.org/resources/article-archive/ai-governance/ | In-depth guides, practitioner tools |
| Covington — Inside Privacy | https://www.insideprivacy.com | Data protection, AI Act, enforcement actions |
| Covington — Inside Global Tech | https://www.insideglobaltech.com | Cross-border tech regulation, AI policy |
| HSF Kramer — Behind the Prompt | search `"Behind the Prompt" HSF Kramer site:linkedin.com` | Monthly AI insights, enterprise governance |

---

## 8. Agent Era & Technical Workflows

Practitioner-focused sources on building and operating agentic AI systems in production.

### Vellum AI Blog
- **URL**: https://www.vellum.ai/blog
- **Focus**: LLM evaluation, orchestration patterns, prompt engineering, production agent workflows

### ByteByteGo
- **Newsletter / Substack**: https://blog.bytebytego.com
- **Focus**: System design patterns for AI, scalable architectures, LLM infrastructure diagrams

**Search strategy**: `"agentic workflow" OR "LLM orchestration" site:vellum.ai OR site:blog.bytebytego.com`, `"agent architecture" production 2026`.

---

## 9. Open Source & Specialised Infrastructure

### Hugging Face (open-source angle)
- Open-source model releases: https://huggingface.co/models?sort=trending
- Community blog: https://huggingface.co/blog

### Infrastructure & scaling
- **Anyscale blog**: https://www.anyscale.com/blog — Ray framework, distributed ML in production
- **vLLM blog**: https://blog.vllm.ai/ — dominant open-source inference serving framework
- **Ollama blog**: https://ollama.com/blog — most popular local model runner
- **SemiAnalysis**: https://www.semianalysis.com — chip economics, GPU supply chain

**Search strategy**: `open-source LLM release site:huggingface.co`, `"AI infrastructure" scaling 2026`.

---

## 10. Macro & Hardware Watch

The chip supply chain and data centre capacity constrain everything else in the AI stack.

### Computing.co.uk
- **AI & Machine Learning**: https://www.computing.co.uk/knowledge/artificial-intelligence
- **Infrastructure**: https://www.computing.co.uk/knowledge/infrastructure

### Hardware & semiconductor sources

| Source | URL | Focus |
|---|---|---|
| NVIDIA News (primary) | https://nvidianews.nvidia.com/ | Official NVIDIA product and partnership announcements |
| NVIDIA Developer Blog | https://developer.nvidia.com/blog/ | CUDA, inference libraries, GPU architecture |
| SemiAnalysis | https://www.semianalysis.com | Deep chip industry analysis, GPU economics |
| The Next Platform | https://www.nextplatform.com/ | HPC and AI infrastructure economics in depth |
| Datacenter Dynamics | https://www.datacenterdynamics.com/ | Data centre construction, power capacity, AI infrastructure buildout |
| Cerebras blog | https://cerebras.ai/blog/ | Wafer-scale compute developments |
| Groq blog | https://groq.com/blog/ | LPU inference architecture |
| The Information (AI hardware) | search `"AI chips" OR "GPU" site:theinformation.com` | Insider chip reporting |
| Tom's Hardware AI | search `"AI" site:tomshardware.com` | GPU benchmarks, hardware releases |

**Search strategy**: `"Nvidia" OR "GPU cluster" OR "AI infrastructure" 2026`, `"data centre AI" site:computing.co.uk`, `site:nextplatform.com AI`, `site:datacenterdynamics.com`.

---

## 11. Model Evaluations & Transparency Reports

Evaluation is now a discipline in its own right — distinct from research (§2) and product news (§6). Tracks how models are being measured, compared, and held accountable, including inference economics.

### LMSYS
- **Blog**: https://lmsys.org/blog/
- **Arena**: https://chat.lmsys.org
- **Focus**: Chatbot Arena methodology, Elo rankings, human preference data at scale

### Artificial Analysis
- **URL**: https://artificialanalysis.ai/blog and https://artificialanalysis.ai
- **Focus**: Model quality, speed, and cost across providers in real time — essential for deployment economics

### Scale AI — SEAL Leaderboards
- **URL**: https://scale.com/leaderboard
- **Focus**: Expert-annotated evaluations; higher rigour than crowd-sourced alternatives

### HELM (Holistic Evaluation of Language Models)
- **URL**: https://crfm.stanford.edu/helm/latest/
- **Focus**: Standardised, reproducible benchmarks across accuracy, calibration, robustness, fairness, efficiency

### LiveBench
- **URL**: https://livebench.ai/
- **Focus**: Contamination-free benchmarks using current-events questions; directly addresses the key weakness of static benchmarks

### AlpacaEval
- **URL**: https://tatsu-lab.github.io/alpaca_eval/
- **Focus**: Widely used instruction-following evaluation; referenced in many paper comparisons

### Open LLM Leaderboard (Hugging Face)
- **URL**: https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard
- **Focus**: Open-source model rankings; tracks community fine-tunes and base models

### WhatLLM.org
- **URL**: https://whatllm.org
- **Focus**: Weekly digest of model ranking changes

**Search strategy**: `site:lmsys.org/blog`, `site:artificialanalysis.ai`, `site:scale.com/leaderboard`, `"HELM benchmark" site:crfm.stanford.edu`, `site:livebench.ai`, `"eval" OR "benchmark" LLM 2026`.
