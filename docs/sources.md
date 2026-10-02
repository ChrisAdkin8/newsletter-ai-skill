# Source Catalogue

Full annotated list of sources used by the skill, grouped by category. This is the human-readable reference version with rationale for each source. The machine-readable version Claude uses lives at `.claude/skills/newsletter-ai/sources.md`.

---

## Don't cite

The first scheduled issue (2026-W37) filled its thinnest sections from sources like these. Each was a symptom of a category with nothing citable that week. The skill skips such items, or finds the primary source or a specialist outlet:

- **Investment and personal-finance sites** (The Motley Fool, Seeking Alpha, Benzinga, InvestorPlace): written for investors, and they rarely add reporting of their own. Enforced by `scripts/check_issue.py`.
- **Syndicated finance pages** (Yahoo Finance, MSN): republish someone else's article; cite the original publisher. Enforced by `scripts/check_issue.py`.
- **Fan and enthusiast sites for one company** (e.g. SammyFans): not a credible source for industry news such as TSMC's roadmap. Enforced by `scripts/check_issue.py`.
- **Crypto outlets for stories that aren't about crypto** (e.g. Forkast on AI infrastructure CVEs): cite the researcher's disclosure.
- **Anonymous aggregators** (e.g. quasa.io on an EU AI Board meeting): no named writers, a crypto token of its own, and a summary of a page it could have linked. Cite the body's own page.
- **Rewrites of a primary source you can reach**: cite the leaderboard, changelog or paper itself.
- **Rolling indexes** (a blog root, changelog, releases page, docs root or trending list): the catalogue lists them as places to look, and each is rewritten in place, so a citation stops matching the story. Cite the page carrying the story; enforced by `scripts/check_issue.py`.
- **Press-release wires**: already a hard rule, enforced by `scripts/check_issue.py`.

---

## Search only

These sites block automated fetches (HTTP 403 or no connection when checked on 2026-09-13), so fetching one wastes a turn. Find their stories by search, take the date from the snippet, and cite the article URL the search returns:

OpenAI News, xAI News, Reuters, Rapporteur (ex-Euractiv), Axios, Bloomberg (also paywalled), The Information (also paywalled), Gartner, McKinsey, BCG (403 since 2026-10-02), Datacenter Dynamics, Dark Reading, Computing.co.uk, the Center for Democracy & Technology, Lawfare, EU Council press releases, and Reddit (login wall). The BAIR blog didn't respond at all on 2026-09-13.

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
| @karpathy (Andrej Karpathy) | Anthropic (pretraining) | Technical insights, model intuition, LLM education |
| @ylecun (Yann LeCun) | AMI Labs (ex-Meta) | Contrarian views on AGI progress; architectures |
| @fchollet (François Chollet) | Ndea / ARC Prize | AGI benchmarking, capability scepticism |
| @GaryMarcus | Independent AI critic | AI failures, limitation claims, hype debunking |
| @emollick (Ethan Mollick) | Wharton School | Enterprise adoption evidence, practical use cases |
| @bcherny (Boris Cherny) | Anthropic / Claude Code | Claude Code, agentic tooling |
| @danhendrycks | CAIS | Safety research, evals, frontier risk |

### LinkedIn

LinkedIn posts from named practitioners surface field notes, opinions, and previews not published elsewhere — particularly from people who post more substantively on LinkedIn than on X. Most LinkedIn content is behind an authentication wall, so `WebFetch` of LinkedIn URLs will fail. Always use `WebSearch` with `site:linkedin.com` to find indexed posts. Search snippets are usually sufficient to assess relevance and write a summary.

**Why named profiles rather than hashtags**: Broad LinkedIn hashtag searches (#LLM, #AgenticAI) return mostly promotional content. Targeting specific individuals by profile slug produces far higher signal.

**Key profiles**:

| Name | Profile slug (linkedin.com/in/...) | Affiliation | What to watch for |
|---|---|---|---|
| Andrew Ng | andrewyng | deeplearning.ai | Applied AI essays, practical use cases, education — the most-followed ML practitioner on LinkedIn; posts weekly |
| Yann LeCun | yannlecun | AMI Labs (ex-Meta) | Architecture debates, AGI scepticism; notably posts more substantive content on LinkedIn than on X |
| Ethan Mollick | emollick | Wharton School | Enterprise AI adoption evidence, research-backed practical use cases; cross-posts from oneusefulthing.org |
| Mustafa Suleyman | mustafa-suleyman | Microsoft AI CEO | Microsoft's in-house frontier models (MAI Superintelligence) and safety framing; Copilot moved to Jacob Andreou in March 2026 |
| Cassie Kozyrkov | kozyrkov | CEO and AI adviser, ex-Google Chief Decision Scientist | AI decision-making, MLOps foundations, statistical thinking — prolific and genuinely educational |
| Sebastian Raschka | sebastianraschka | Independent researcher | LLM training, architectures, concise paper summaries — high-quality technical content in short-form |
| Jay Alammar | jalammar | Independent / Cohere | ML visualisations, transformer explanations, educational deep-dives |
| Chip Huyen | chiphuyen | Independent | Inference systems, real-world LLM deployment, MLOps |
| Harrison Chase | harrison-chase-961287118 | LangChain CEO | Agent frameworks, production LLM tooling, agentic design patterns |
| Jerry Liu | jerry-liu-64390071 | LlamaIndex CEO | RAG systems, agentic data pipelines, agent architectures |
| Gary Marcus | gary-marcus-b6384b4 | Independent AI critic | AI failures, limitation claims, hype analysis — high-profile sceptic voice |
| Jeff Dean | jeff-dean-8b212555 | Discovery Loop co-founder (left Google in August 2026) | AI research direction, scale, Google-era ML systems |

**Search strategy**: `site:linkedin.com/posts (andrewyng OR yannlecun OR emollick OR kozyrkov OR sebastianraschka OR jalammar OR chiphuyen) "LLM" OR "AI agents" 2026`

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

### Hugging Face Trending Papers (formerly Papers with Code)
Links papers to their implementations. Useful for finding papers with reproducible experiments and real code. Papers with Code now redirects here.
URL: https://huggingface.co/papers/trending

### Conferences
NeurIPS (https://neurips.cc/), ICML (https://icml.cc/) and ICLR (https://iclr.cc/) release accepted papers, best-paper awards and workshop programmes in bursts. A newsletter that only watches arXiv reads the same during a conference week as any other. Check the current conference's site that week, and cite the paper rather than the coverage of it.

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
| Alignment Research Center (ARC) | https://www.alignment.org/blog/ | Alignment research, eval methodology, red-teaming — quiet since June 2026 |
| Center for AI Safety (CAIS) | https://safe.ai/work/research | Policy briefs, evals, frontier risk framing. Dan Hendrycks leads this |
| Apollo Research | https://www.apolloresearch.ai/science | Deception, scheming, and agentic model evaluations |
| METR | https://metr.org | Frontier model capability benchmarking; produces evaluations used by major labs |
| Redwood Research | https://blog.redwoodresearch.org/ | Adversarial training, scalable oversight, alignment techniques |
| FAR AI | https://www.far.ai/ | Scalable oversight, mechanistic interpretability, alignment |
| Transluce | https://transluce.org | Independent evals and interpretability lab; its agent-behaviour investigations get picked up widely |
| Goodfire | https://www.goodfire.com/research | Interpretability research lab |
| Anthropic Alignment Science | https://alignment.anthropic.com/ | Anthropic's alignment team blog, separate from anthropic.com/research; misalignment and automated-alignment work often lands here first |
| OpenAI Alignment | https://alignment.openai.com/ | OpenAI's research-first safety posts. Fetchable, unlike openai.com/news |

**Why these matter for agentic coverage**: Agentic systems with tool use and long-horizon planning create novel failure modes (scheming, deception, goal misgeneralisation). These labs study exactly that.

### Academic Labs

| Lab | URL | Focus |
|---|---|---|
| Stanford HAI | https://hai.stanford.edu/news | AI policy, economics of AI, societal impact |
| Berkeley AI Research (BAIR) | https://bair.berkeley.edu/blog/ | Robotics, RL, LLM research with code |
| Allen Institute for AI (AI2) | https://allenai.org/research | Open research, NLP, reasoning, open-source models |
| EleutherAI | https://blog.eleuther.ai/ | Open-source model training, interpretability, evals |

### Alignment & Safety Forums

Priority sources — major safety research often appears here before arXiv.

- **Alignment Forum**: https://www.alignmentforum.org/ — Where ARC, Apollo, Anthropic, and independent alignment researchers publish work first. Sleeper Agents, Apollo's scheming evaluations, and Anthropic's interpretability work all appeared here before arXiv. Check weekly.
- **LessWrong**: https://www.lesswrong.com/ — Community analysis and early framing of capability milestones. Lower signal-to-noise than the Alignment Forum but catches practitioner reasoning before papers form.

**Search strategy**: `site:alignmentforum.org`, `site:lesswrong.com AI`, `"alignment forum" AI safety 2026`.

---

## 3. Technical Blogs & Engineering Posts

### Major lab blogs

| Organisation | URL | What to expect |
|---|---|---|
| Anthropic | https://www.anthropic.com/news | Model releases, safety research, policy |
| Anthropic Research | https://www.anthropic.com/research | Technical papers and interpretability work |
| Anthropic Engineering | https://www.anthropic.com/engineering | Agent harness, sandboxing and Claude Code design posts |
| OpenAI | https://openai.com/news/ | Model releases, API updates, safety announcements |
| Google DeepMind | https://deepmind.google/blog/ | Research results, model releases |
| Meta AI | https://ai.meta.com/blog/ | Open-source model releases, research |
| Hugging Face | https://huggingface.co/blog | Open-source tooling, model releases, tutorials |
| Microsoft Research | https://www.microsoft.com/en-us/research/blog/ | AI research with applied angle; Copilot, Azure AI |
| Microsoft Azure AI | https://azure.microsoft.com/en-us/blog/tag/ai/ | Enterprise AI deployment, Azure AI service updates |
| Apple ML Research | https://machinelearning.apple.com/ | On-device ML, private compute, multimodal |
| Amazon Science | https://www.amazon.science/blog | Cloud AI, agent tooling, inference at scale |
| xAI | https://x.ai/news | Grok releases and technical reports; blocks automated fetches, so find stories by search |
| Google (product and research) | https://blog.google/innovation-and-ai/technology/ai/ | Gemini product news and research framing, distinct from the DeepMind blog |
| Sakana AI | https://sakana.ai/blog/ | Tokyo lab; evolutionary model merging and agent research that rarely gets Western coverage |
| Thinking Machines Lab | https://thinkingmachines.ai/blog/ | Mira Murati's lab; posts rarely but each one is news |
| Black Forest Labs | https://bfl.ai/blog | German image-model lab (FLUX); the main European entry besides Mistral |
| Sarvam AI | https://www.sarvam.ai/blogs | India's leading model lab; Indic-language and sovereign-AI models |

### Chinese labs

A large share of each week's open-weight releases comes from these labs, and the published issues have been citing them second-hand — DeepSeek V4 to Hugging Face and MIT Technology Review, Kimi K3 to the vLLM blog. The catalogue's own rule is to prefer the primary source, so these are here to make that possible. The lab's announcement or its Hugging Face model card is primary; an article about the release is not.

| Lab | URL | What to expect |
|---|---|---|
| DeepSeek | https://api-docs.deepseek.com/news/ | Release notes for V-series and R-series models |
| DeepSeek on GitHub | https://github.com/deepseek-ai | Weights, technical reports, inference code |
| Qwen (Alibaba) | https://qwen.ai/research | Qwen releases with benchmark tables and model cards |
| Qwen on GitHub | https://github.com/QwenLM | Weights and serving code |
| Moonshot AI (Kimi) | https://www.kimi.ai/blog/ | Kimi releases, long-context work |
| Z.ai / Zhipu (GLM) | https://docs.z.ai/release-notes/new-released | GLM family releases |
| MiniMax | https://www.minimax.io/news | Model and product announcements |
| ByteDance Seed | https://seed.bytedance.com/en/ | Seed research and model releases |
| Baidu ERNIE | https://ernie.baidu.com/blog/ | ERNIE and research output — quiet since May 2026 |
| Tencent Hunyuan | https://huggingface.co/tencent | Frequent open-weight releases (Hunyuan / Hy) |
| Xiaomi MiMo | https://huggingface.co/XiaomiMiMo | MiMo reasoning and agent models |
| Meituan LongCat | https://huggingface.co/meituan-longcat | Large MIT-licensed LongCat models |
| Ant Group inclusionAI (Ling, Ming) | https://huggingface.co/inclusionAI | Ant Group's open-model organisation |

For context rather than citation: [ChinaTalk](https://www.chinatalk.media/) and [Recode China AI](https://www.recodechinaai.com/) explain and translate what these labs ship. Treat them as section 12 secondary sources — find the story there, then cite the lab.

### Infrastructure & tooling company blogs

These companies often publish technical deep-dives before mainstream press picks them up. Particularly valuable for understanding the compute economics and serving layer that underpins agentic deployments.

| Company | URL | What they write about |
|---|---|---|
| NVIDIA Developer Blog | https://developer.nvidia.com/blog/ | CUDA, inference libraries, new GPU architecture, TensorRT |
| NVIDIA News | https://nvidianews.nvidia.com/ | Official product and partnership announcements |
| Cerebras | https://www.cerebras.ai/blog | Wafer-scale compute, speed records |
| Groq | https://groq.com/blog/ | LPU inference, throughput benchmarks |
| Lambda | https://lambda.ai/blog | GPU cloud, training infrastructure |
| CoreWeave | https://www.coreweave.com/blog-categories/blog | GPU cloud, HPC, enterprise AI infrastructure |
| Fireworks AI | https://fireworks.ai/blog | Inference optimisation, model serving |
| Anyscale | https://www.anyscale.com/blog | Ray framework, distributed ML, production agent orchestration |
| AWS Machine Learning | https://aws.amazon.com/blogs/machine-learning/ | Bedrock, Trainium and SageMaker; the hyperscaler missing next to Azure and Google Cloud |
| Weights & Biases (CoreWeave) | https://wandb.ai/site/articles/ | W&B articles; the old Fully Connected URL now redirects to CoreWeave Forge. MLOps, experiment tracking, agent observability — de facto standard |
| vLLM | https://vllm.ai/blog | Dominant open-source inference serving; PagedAttention, throughput |
| Scale AI | https://scale.com/blog | Data labelling, fine-tuning, RLHF methodology |
| Databricks | https://www.databricks.com/blog | Enterprise LLM training and deployment; acquired MosaicML |
| Ollama | https://ollama.com/blog | Most popular local model runner |
| CrewAI | https://crewai.com/blog | Multi-agent frameworks, role-based agent patterns |
| Modal | https://modal.com/blog | Serverless GPU inference; high-quality engineering posts on cold starts, GPU utilisation, and model deployment patterns |
| Microsoft Agent Framework | https://devblogs.microsoft.com/agent-framework/ | Agent Framework releases (successor to AutoGen and Semantic Kernel); Microsoft's agentic AI frameworks widely deployed in enterprise |

### AI-only and technical media

Higher signal-to-noise than general tech press — dedicated AI editorial teams, faster and more accurate on model releases.

| Outlet | URL | Strength |
|---|---|---|
| The Decoder | https://the-decoder.com | Fast, accurate model release and research coverage |
| VentureBeat AI | https://venturebeat.com/ | Enterprise AI adoption, startup and funding coverage |
| MIT Technology Review AI | https://www.technologyreview.com/topic/artificial-intelligence/ | Long-form, credible journalism from an authoritative institution |
| Ars Technica AI | https://arstechnica.com/ai/ | Technically accurate, detailed; good model release and policy coverage |
| IEEE Spectrum AI | https://spectrum.ieee.org/topic/artificial-intelligence/ | Authoritative on hardware and systems; slower but rigorous |
| The Information (AI) | https://www.theinformation.com | Breaks internal stories on major labs (paywalled; use search for free previews) |

### Individual researchers & practitioners

Publish infrequently but with depth. These individuals often surface shifts before companies formalise them.

| Author | URL | Focus |
|---|---|---|
| Sebastian Raschka | https://magazine.sebastianraschka.com | Training, architectures, paper reviews |
| Lilian Weng (OpenAI) | https://lilianweng.github.io | Deep technical surveys, agent architectures |
| Simon Willison | https://simonwillison.net | LLM tooling, prompt injection, practical use |
| Andrej Karpathy (blog) | https://karpathy.bearblog.dev/blog/ | Fundamentals, model internals; posts rarely since he joined Anthropic in May 2026 |
| Nathan Lambert | https://www.interconnects.ai | RLHF, alignment, open-source models |
| Dwarkesh Patel | https://www.dwarkesh.com/ | Long-form interviews with frontier lab leaders |
| Ethan Mollick | https://www.oneusefulthing.org | Practical enterprise AI adoption signal; research-backed |
| Percy Liang | https://crfm.stanford.edu | HELM benchmark, AI transparency, evaluation methodology |
| ARC Prize (François Chollet) | https://arcprize.org/blog | ARC-AGI benchmark results and analysis; capability scepticism grounded in data |
| Gary Marcus | https://garymarcus.substack.com | High-profile AI sceptic; covers AI failures and limitation claims |
| Cameron Wolfe | https://cameronrwolfe.substack.com | High-quality deep learning newsletter with detailed paper breakdowns |
| Dario Amodei | https://darioamodei.com | Essays from Anthropic's CEO; when the essay is the story, this is the primary source |
| Tim Dettmers | https://timdettmers.com | Quantisation, efficient training and GPU economics; posts rarely but in depth |

### Engineering & framework blogs
- LangChain: https://www.langchain.com/blog
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
| McKinsey Global Institute | https://www.mckinsey.com/capabilities/quantumblack/our-insights | Economic impact, transformation surveys |
| BCG Henderson Institute | https://www.bcg.com/capabilities/artificial-intelligence | Strategic framing, sector analysis |
| Deloitte Insights | https://www.deloitte.com/us/en/insights/topics/emerging-technologies.html | Enterprise readiness, risk |

### AI-focused research organisations & VC firms

| Source | URL | Strength |
|---|---|---|
| Stanford HAI AI Index | https://hai.stanford.edu/ai-index | Annual benchmark report, policy, education |
| RAND AI | https://www.rand.org/topics/artificial-intelligence.html | National security, policy implications |
| Georgetown CSET | https://cset.georgetown.edu/publications/ | AI and national security, China compute, data-driven policy analysis |
| GovAI | https://www.governance.ai/research | Frontier-AI governance research |
| IAPS | https://www.iaps.ai/research | AI policy and compute governance research |
| Epoch AI | https://epoch.ai/latest | Compute trends, scaling, empirical forecasts |
| AI Now Institute | https://ainowinstitute.org | Labour impact, power concentration, accountability |
| OECD AI | https://oecd.ai/en/ | Policy adoption data, international comparative statistics |
| Brookings AI | https://www.brookings.edu/topics/artificial-intelligence/ | Policy analysis, governance, societal impact; credible centrist framing |
| a16z AI | https://a16z.com/ai/ | Most prominent AI-focused VC; State of AI essays, market sizing; shapes enterprise narratives |
| Sequoia Capital AI | https://sequoiacap.com/stories/ | Strategic AI market framing, startup ecosystem trends |
| AI as Normal Technology (ex-AI Snake Oil) | https://www.normaltech.ai/ | Sceptical, evidence-based critique |
| Import AI (Jack Clark) | https://jack-clark.net | Weekly digest, safety, capabilities |
| Air Street Press (Nathan Benaich) | https://press.airstreet.com/ | Analysis and the annual State of AI Report (usually October) |
| Stratechery (Ben Thompson) | https://stratechery.com | Business strategy, platform dynamics |

---

## 5. AI Security

### OWASP
The Open Worldwide Application Security Project maintains the authoritative LLM application security guidance.

| Resource | URL | What it covers |
|---|---|---|
| OWASP Top 10 for LLM Applications | https://genai.owasp.org/llm-top-10/ | The 10 most critical LLM security risks |
| OWASP AI Exchange | https://owaspai.org | Broader AI risk catalogue, community-maintained |
| GitHub (latest updates) | https://github.com/OWASP/www-project-top-10-for-large-language-model-applications | Tracks revisions and new entries |

### MITRE
MITRE maintains threat taxonomies widely used by security teams and governments.

| Resource | URL | What it covers |
|---|---|---|
| MITRE ATLAS | https://atlas.mitre.org | Adversarial ML threat matrix — tactics, techniques, procedures |
| MITRE CVE (AI/LLM) | https://www.cve.org/CVERecord/SearchResults?query=LLM | Published CVEs mentioning LLM or AI systems |
| MITRE ATT&CK | https://attack.mitre.org | Enterprise threat framework (increasingly includes AI-assisted attacks) |

### NIST

| Resource | URL | What it covers |
|---|---|---|
| NIST AI hub (now titled "Super intelligence") | https://www.nist.gov/super-intelligence | AI RMF 1.0, Playbook, profiles |
| NIST AI publications | https://csrc.nist.gov/publications | Formal publications, drafts open for comment |

### Government cybersecurity agencies

These are the primary government sources for operational AI security guidance — a major gap in many AI security reading lists.

| Agency | URL | What it covers |
|---|---|---|
| CISA (US) | https://www.cisa.gov/topics/cybersecurity-best-practices/super-intelligence | Operational AI security for critical infrastructure; joint advisories |
| ENISA (EU) | https://www.enisa.europa.eu/ | EU AI threat landscape reports; security guidance for AI Act compliance |
| NCSC (UK) | https://www.ncsc.gov.uk/section/advice-guidance/all-topics?topics=Artificial%20intelligence | UK AI security guidance; publishes joint advisories with CISA and ENISA |

**Why these matter**: CISA, ENISA, and NCSC publish joint advisories that carry regulatory weight — not just analysis but operational requirements. Any organisation deploying AI in regulated sectors needs to track these.

### Threat intelligence labs

These labs publish the actual zero-day disclosures, campaign analyses, and incident write-ups — they break the stories that corporate security blogs (Lakera, HiddenLayer) interpret. Distinct from §5 vendor security blogs in that their primary output is threat reporting, not product marketing.

| Lab | URL | Focus |
|---|---|---|
| Google Threat Intelligence Group (GTIG) | https://cloud.google.com/blog/topics/threat-intelligence | AI-assisted attacks, zero-day discovery, state-sponsored campaigns — publishes Google's confirmed AI exploit disclosures |
| Microsoft Threat Intelligence | https://www.microsoft.com/en-us/security/blog/topic/threat-intelligence/ | Enterprise threat actor reporting, AI-assisted intrusions, ransomware campaigns |
| Palo Alto Unit 42 | https://unit42.paloaltonetworks.com | MCP attack vectors, prompt injection research, agent framework vulnerabilities |
| Mandiant (Google Cloud) | https://cloud.google.com/blog/topics/threat-intelligence/mandiant | Incident response, nation-state AI use, breach forensics |

**Search strategy**: `site:cloud.google.com/blog "threat intelligence"`, `site:microsoft.com/en-us/security/blog "threat intelligence"`, `site:unit42.paloaltonetworks.com`, `"GTIG" OR "Mandiant" AI 2026`.

### Security research outlets

| Source | URL | Focus |
|---|---|---|
| AI Village | https://aivillage.org | DEF CON AI track, red-teaming, community |
| Lakera Research | https://www.lakera.ai/research | Gandalf adversarial attack analysis (279k real attacks), AI Model Risk Index; Lakera is now part of Check Point |
| HiddenLayer | https://www.hiddenlayer.com/innovation-hub | Adversarial ML research. Discovered **Policy Puppetry** (2025) — zero-day exploiting XML/JSON to bypass all major safety filters — and **EchoGram** (adversarial attack on defensive classifiers) |
| Embrace the Red | https://embracethered.com/blog/ | Johann Rehberger's documented prompt injection CVEs against GitHub Copilot (RCE via CVE-2025-53773), Claude Code, Amazon Q Developer, Windsurf, and others. The most prolific real-world prompt injection researcher |
| Snyk Labs (ex-Invariant) | https://labs.snyk.io/ | ETH Zurich spin-off acquired by Snyk (2025). Discovered **Tool Poisoning Attacks** (TPAs) on MCP and built MCP-Scan. Primary source for MCP security research |
| Adversa AI | https://adversa.ai/blog | Adversarial attacks, evasion techniques; publishes MCP Security Digests |
| Trail of Bits | https://blog.trailofbits.com/ | Hands-on AI red-teaming and model audits; highly respected security firm |
| Microsoft Security | https://www.microsoft.com/en-us/security/blog/ | AI-assisted attacks, enterprise threat intelligence at scale |
| Simon Willison (prompt injection) | https://simonwillison.net/tags/prompt-injection/ | Real-world prompt injection incident tracker |
| Wired AI & Security | https://www.wired.com/tag/artificial-intelligence/ | Mainstream coverage of AI security incidents |
| Dark Reading | https://www.darkreading.com/keyword/artificial-intelligence | Enterprise security practitioner audience |
| Krebs on Security | https://krebsonsecurity.com | High-quality incident coverage when AI is involved |
| The Hacker News | https://thehackernews.com | Fast, detailed AI security incident coverage; consistently first to publish AI exploit and vulnerability stories |
| The Register (AI/ML) | https://www.theregister.com/ai_ml/ | Sceptical, technically literate AI and security incident reporting |
| CyberScoop | https://cyberscoop.com | Government cybersecurity reporting; strong on CISA, NSA, and Five Eyes advisories |
| Bloomberg Cyber | https://www.bloomberg.com/cybersecurity | Breaking enterprise incidents and AI-related breach disclosures (paywalled) |
| Check Point Research | https://research.checkpoint.com/ | Primary vulnerability research; frequent findings in AI and LLM platforms, such as cross-account data leakage in ChatGPT (2026) |
| OX Security | https://www.ox.security/blog/ | Primary research, with CVEs, on AI coding agents and MCP supply-chain flaws; cited in two of the first three issues |
| Anthropic Frontier Red Team | https://www.anthropic.com/research/team/frontier-red-team | Primary findings on AI cyber and bio capabilities |
| Wiz Research | https://www.wiz.io/blog/tag/ai | Primary disclosures of flaws in AI and cloud infrastructure |
| XBOW | https://xbow.com/blog | AI-driven vulnerability discovery, with CVEs |
| AISLE | https://aisle.com/blog | AI-driven vulnerability discovery, with CVEs in core open-source projects |
| Zenity Labs | https://zenity.io/blog | Attacks on agents and enterprise copilots |
| Pillar Security | https://www.pillar.security/blog | Agent and AI-app attack research |
| Malwarebytes Labs (AI) | https://www.malwarebytes.com/blog/category/ai | Consumer-side AI-assistant threats; cite only their own research |
| BankInfoSecurity / ISMG (AI & ML) | https://www.bankinfosecurity.com/artificial-intelligence-machine-learning-c-469 | Named reporters with original reporting on AI security and policy |

---

## 6. Product & Company News

### Model releases & benchmarks
| Source | URL | What to look for |
|---|---|---|
| OpenRouter models | https://openrouter.ai/models | Sorted by date; shows all available models across providers |
| Arena (formerly LMSYS Chatbot Arena) | https://arena.ai/leaderboard | Leaderboard shifts indicate meaningful capability changes |
| HuggingFace model hub | https://huggingface.co/models | Open-source model releases sorted by recent activity |

### Funding & M&A
| Source | URL |
|---|---|
| Crunchbase News (AI) | https://news.crunchbase.com/sections/ai/ |
| TechCrunch AI | https://techcrunch.com/category/artificial-intelligence/ |
| Axios AI | https://www.axios.com/technology/artificial-intelligence |
| CNBC Technology | https://www.cnbc.com/technology/ |
| CNBC AI | https://www.cnbc.com/ai-artificial-intelligence/ |
| Reuters Technology | https://www.reuters.com/technology/ |

CNBC was cited six times in the first three issues. Reuters is often first on deals but blocks automated fetches, so the skill finds its stories by search.

### Developer tool release notes
| Source | URL |
|---|---|
| Claude Code changelog | https://code.claude.com/docs/en/changelog (no per-version anchor, checked 2026-09-18; cite `https://github.com/anthropics/claude-code/releases/tag/vX.Y.Z`) |

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
| EU Council (Consilium) | https://www.consilium.europa.eu/en/press/press-releases/ | Council press releases — political agreements (e.g. AI omnibus deal) land here before Commission digital strategy |
| European Parliament — AI | https://www.europarl.europa.eu/topics/en/topic/artificial-intelligence | Parliament position, plenary votes, MEP statements on AI legislation |
| UK AI Security Institute (AISI) | https://www.aisi.gov.uk/ | UK frontier AI safety evaluations, international coordination on standards |
| EU AI Office | https://digital-strategy.ec.europa.eu/en/policies/ai-office | AI Act enforcement body: GPAI code of practice, guidelines, consultations |
| EU AI Board | https://digital-strategy.ec.europa.eu/en/policies/ai-board | Member-state board steering AI Act enforcement; meeting outcomes land here |
| NIST CAISSI (US, ex-CAISI) | https://www.nist.gov/caissi | US Center for Advancing Innovation and Standards for Super Intelligence (renamed from CAISI; nist.gov/caisi redirects): pre-deployment model testing, model evaluations, AI Agent Standards Initiative |
| International AI Safety Report | https://internationalaisafetyreport.org | Annual report (February) plus occasional Key Updates; check it when a new edition lands |
| White House OSTP | https://www.whitehouse.gov/ostp/ | US AI executive policy, national AI strategy, Federal agency guidance |
| FTC (US) | https://www.ftc.gov/news-events/news/press-releases | US enforcement on AI deception, unfair practices, and data misuse — enforcement actions here are news |
| UK ICO | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/ | UK data protection regulator with an active AI guidance programme |
| Canada — responsible AI | https://www.canada.ca/en/government/system/digital-government/digital-government-innovations/responsible-use-ai.html | Federal responsible-AI guidance. The AIDA bill died in January 2025 with no successor, so Canada has no federal AI law |
| Future of Life Institute | https://futureoflife.org/ | Policy advocacy; published the Pause AI letter; engages with EU AI Act and international governance |
| Frontier Model Forum | https://www.frontiermodelforum.org/publications/ | Industry safety body's technical reports and frameworks |

### Legal & compliance commentary

| Source | URL | What it covers |
|---|---|---|
| IAPP News & Analysis | https://iapp.org/news/ | Daily news on privacy law, AI regulation globally |
| Covington — Inside Privacy | https://www.insideprivacy.com | Data protection, AI Act, privacy enforcement (US & EU) |
| Covington — Inside Global Tech | https://www.insideglobaltech.com | Cross-border tech regulation, AI policy |
| HSF Kramer — Behind the Prompt | search `"Behind the Prompt" HSF Kramer site:linkedin.com` | Monthly AI insights, legal and enterprise AI governance trends |
| Ada Lovelace Institute | https://www.adalovelaceinstitute.org | Independent UK think tank; rigorous research on AI governance, bias, and accountability — one of the most credible UK policy voices |
| Center for Democracy & Technology | https://cdt.org/ai-policy/ | US civil liberties angle; covers FTC AI enforcement, workplace surveillance, and biometric AI regulation |
| Electronic Frontier Foundation | https://www.eff.org/issues/ai | Civil liberties, IP, and surveillance dimensions of AI that legal commentary sources miss |
| Lawfare (AI) | https://www.lawfaremedia.org/topics/cybersecurity-tech/artificial-intelligence | US legal and national-security analysis: state AI laws, federal preemption; blocks automated fetches, so find stories by search |
| Future of Privacy Forum | https://fpf.org/ | Tracks US state AI and privacy laws; neutral legal analysis |

### Weekly policy news

Government sites and law firms publish irregularly: in 2026-W37, 13 searches of them found nothing, and the issue had no policy section. These publish every week. Use them to find what happened, then cite the primary document where there is one.

| Source | URL | What it covers |
|---|---|---|
| Rapporteur (ex-Euractiv) | https://www.rapporteur.com/ | Euractiv relaunched as Rapporteur on 2026-09-28 and euractiv.com redirects there. EU policy news, often first on AI Act and digital omnibus negotiations (blocks automated fetches; found by search) |
| Tech Policy Press | https://www.techpolicy.press/ | Frequent news and analysis on US, EU and UK tech and AI policy |
| Transformer | https://www.transformernews.ai/ | Weekly AI policy and safety news; strong on frontier-model regulation and lab governance |
| EU AI Act Newsletter | https://artificialintelligenceact.substack.com/ | Weekly AI Act implementation roundup; secondary, pointing to Commission, AI Office and member-state documents |

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

- **URL**: https://www.langchain.com/blog — also published at https://blog.langchain.com and https://interrupt.langchain.com, so a search may return any of the three
- **Strength**: Authoritative on agent framework patterns; release notes for LangGraph Platform, LangGraph Studio, and LangChain 1.0

### Pydantic AI
Production-grade Python agent framework from the Pydantic team, with first-class MCP (Model Context Protocol) support. The docs/blog covers agent design patterns, multi-agent orchestration, and typed agent APIs.

- **URL**: https://pydantic.dev/articles, with the framework's own docs and posts at https://pydantic.dev/docs/ai/
- **Strength**: Strong typing, MCP-native, practical production focus; increasingly referenced alongside LangGraph for typed agent patterns

### Composio
- **URL**: https://composio.dev/blog
- **Focus**: Tool integration layer for MCP agents; active publisher on MCP security, connector ecosystem, and multi-agent tooling patterns

### Model Context Protocol
The interoperability standard the rest of this section keeps referring to. When the protocol itself is the story — a spec revision, the registry, a transport or auth change — this is the primary source, not a vendor's summary of it.

- **Spec and docs**: https://modelcontextprotocol.io/
- **Blog**: https://blog.modelcontextprotocol.io/

### Coding agents
The agentic coding tools are both the most-used agents in practice and a steady source of engineering write-ups.

| Product | URL | What to expect |
|---|---|---|
| Claude Code changelog | https://code.claude.com/docs/en/changelog (no per-version anchor, checked 2026-09-18; cite `https://github.com/anthropics/claude-code/releases/tag/vX.Y.Z`) | Release notes; also listed in section 6 |
| Cognition (Devin) | https://cognition.com/blog | Autonomous software engineering, benchmark claims worth checking |
| Cursor | https://cursor.com/blog | Editor-integrated agents, model routing, latency work |
| n8n | https://blog.n8n.io/ | Workflow automation with LLM steps; the low-code end of agent building |
| Factory | https://factory.com/news | Autonomous coding agents (Droids) |
| Amp | https://ampcode.com/chronicle | Coding agent from Sourcegraph's team |
| OpenHands | https://www.openhands.dev/blog | Open-source coding agent |
| GitHub Copilot changelog | https://github.blog/changelog/label/copilot/ | Copilot agent releases; a changelog index, so cite the entry's own page |

### A2A Protocol

The agent-to-agent protocol, at v1.0 and donated by Google to the Linux Foundation. Cite it rather than a vendor's summary when the protocol is the story.

- **URL**: https://a2a-protocol.org/latest/blog/

### Hugging Face — Agents tag
- **URL**: https://huggingface.co/blog?tag=agents
- **Focus**: Agent framework announcements, smolagents releases, and community agent builds from the HF ecosystem (distinct from the main HF blog in open-source section)

**Search strategy**: `"agentic workflow" OR "LLM orchestration" site:vellum.ai OR site:blog.bytebytego.com`, `site:langchain.com/blog`, `site:pydantic.dev/articles OR site:pydantic.dev/docs/ai`, `site:modelcontextprotocol.io`, `site:cognition.com/blog`, `site:composio.dev/blog`, `"agent architecture" production 2026`, `"MCP" OR "model context protocol" agent 2026`.

---

## 9. Open Source & Specialised Infrastructure

### Hugging Face
- Open-source model releases: https://huggingface.co/models?sort=trending
- Community blog: https://huggingface.co/blog

### Key open-source tools and their blogs

| Tool | URL | Why it matters |
|---|---|---|
| vLLM | https://vllm.ai/blog | Dominant open-source inference serving; architectural decisions affect how agents are deployed |
| SGLang | https://docs.sglang.io/, https://github.com/sgl-project/sglang | The other high-throughput serving engine; its releases benchmark against vLLM, so the two together show where serving performance actually is |
| llama.cpp | https://github.com/ggml-org/llama.cpp/releases (cite the release's own `/releases/tag/bXXXX` page) | The substrate under Ollama and most local inference; release notes are the earliest signal that a new architecture can run on consumer hardware |
| Ollama | https://ollama.com/blog | Most popular local model runner; tracks which models are available locally |
| Anyscale | https://www.anyscale.com/blog | Ray framework; distributed ML and production agent orchestration |
| SemiAnalysis | https://newsletter.semianalysis.com/ | Chip economics and GPU supply chain analysis |

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
| SemiAnalysis | https://newsletter.semianalysis.com/ | Best analysis of chip industry economics and GPU supply chain |
| The Next Platform | https://www.nextplatform.com/ | Best publication covering HPC and AI infrastructure economics in depth |
| Datacenter Dynamics | https://www.datacenterdynamics.com/ | Industry bible for data centre construction, power capacity, and AI infrastructure buildout |
| Cerebras blog | https://www.cerebras.ai/blog | Wafer-scale compute, interconnect architecture |
| Groq blog | https://groq.com/blog/ | LPU inference, throughput, energy efficiency |
| The Information (AI hardware) | search `"AI chips" OR "GPU" site:theinformation.com` | Insider reporting on Nvidia, AMD, custom silicon |
| Tom's Hardware AI | https://www.tomshardware.com | GPU benchmarks, hardware release coverage |
| AMD AI / ROCm blog | https://rocm.blogs.amd.com/ | MI300X/MI350 developments, ROCm ecosystem; AMD is now a genuine NVIDIA alternative for inference workloads |
| Chips and Cheese | https://chipsandcheese.com | Deep architectural analysis of AMD, Intel, and NVIDIA silicon; complements SemiAnalysis on chip internals |
| Fabricated Knowledge | https://www.fabricatedknowledge.com | Semiconductor supply chain; essential on TSMC capacity, CoWoS packaging, and HBM allocation that constrain AI infrastructure |
| TrendForce | https://www.trendforce.com/news/ | Primary market research on HBM, DRAM and foundry pricing and capacity: the numbers other outlets quote |
| ServeTheHome | https://www.servethehome.com/ | Hands-on server, accelerator and networking hardware coverage |
| Reuters Technology | https://www.reuters.com/technology/ | Chip deals, export controls and supply-chain news (blocks automated fetches; found by search) |

---

## 11. Model Evaluations & Transparency Reports

Evaluation is now a discipline in its own right — large enough to stand alone, distinct from research papers (§2) and product news (§6). Tracks how models are measured, compared, and held accountable, including inference economics.

### LMSYS

The team behind Chatbot Arena. Their blog provides methodology insights, dataset releases, and analysis of preference data that goes well beyond the Arena UI.

- **Blog**: https://www.lmsys.org/blog/
- **Arena**: https://arena.ai/leaderboard (formerly LMSYS Chatbot Arena)
- **Strength**: Human preference data at scale, Elo methodology, head-to-head model comparisons

### Artificial Analysis

Tracks model quality, inference speed, and cost across providers in real time. Essential for understanding the economics of model deployment — not just capability but cost-per-token and latency under load.

- **Analysis blog**: https://artificialanalysis.ai/articles
- **Live data**: https://artificialanalysis.ai
- **Strength**: Provider-agnostic, continuously updated, tracks price and performance together

### Scale AI — SEAL Leaderboards

Expert-annotated safety and capability evaluations with higher rigour than crowd-sourced alternatives.

- **URL**: https://labs.scale.com/leaderboard
- **Strength**: Expert annotation quality, task-specificity, safety dimension

### HELM (Holistic Evaluation of Language Models)

Standardised, reproducible benchmarks from Stanford CRFM (Percy Liang's group). The most comprehensive single framework: accuracy, calibration, robustness, fairness, and efficiency.

- **URL**: https://crfm.stanford.edu/helm/capabilities/latest/
- **Strength**: Reproducibility, breadth of metrics, institutional credibility

### LiveBench

Contamination-free benchmarks using current-events questions — directly addresses the key weakness of static benchmarks (where training data may contain test answers).

- **URL**: https://livebench.ai/
- **Strength**: Contamination-resistant; grows over time; growing credibility in the research community

### MLCommons (MLPerf, AILuminate)

Industry-standard, peer-reviewed benchmarks for training and inference speed (MLPerf) and safety (AILuminate). Vendors announce their results through press wires, so cite MLCommons.

- **URL**: https://mlcommons.org/insights/

### Vals AI

Expert-built benchmarks for finance, legal and coding tasks, plus the Vals Index that combines them.

- **URL**: https://www.vals.ai/home

### Terminal-Bench

Agentic coding benchmark in a real terminal; labs quote it at launch.

- **URL**: https://www.tbench.ai/news

### LLM-Stats
Cross-model comparison of benchmark scores, price per token and context window, updated as models ship. Useful for the one-line comparisons an item needs without fetching three leaderboards.

- **URL**: https://llm-stats.com

### WhatLLM.org

Live model rankings and comparisons, with an occasional blog. Useful for tracking momentum without parsing raw leaderboard diffs.

- **URL**: https://whatllm.org

---

## 12. Newsletters & Podcasts

**Secondary sources only.** Other people's digests are good at spotting stories early, but the newsletter never cites them. The skill uses their snippets to find a story, then links the primary source, the paper, post or announcement, under whichever section fits it.

| Source | URL | Strength |
|---|---|---|
| The Batch (deeplearning.ai) | https://www.deeplearning.ai/the-batch/ | Andrew Ng's weekly digest; surfaces enterprise adoption signals and research framing before mainstream press |
| Latent Space | https://www.latent.space/podcast | Developer-focused interviews with AI researchers and builders; often first to surface new research directions |
| TWIML AI Podcast | https://twimlai.com/podcast/twimlai | Technical ML and AI interviews; strong on production ML, research and hardware |
| Don't Worry About the Vase (Zvi Mowshowitz) | https://thezvi.substack.com | The most complete weekly roundup of the AI week; good for finding stories |
| Exponential View (Azeem Azhar) | https://www.exponentialview.co | Weekly on AI's economic and social effects |
| Understanding AI (Timothy B. Lee) | https://www.understandingai.org | Explainers and reporting on AI policy and capabilities |

**Search strategy**: `site:deeplearning.ai/the-batch`, `site:latent.space`, `site:twimlai.com`. Use them to fill gaps: if a story appears here and not in the primary sources, find and link the primary source rather than the newsletter or podcast.

---

## 13. Cloud Native & CNCF

This section covers how AI models and agents are built and run on Kubernetes and CNCF projects, plus the CNCF's own major news: graduations, new projects, releases and KubeCon. Much production AI now runs on Kubernetes, and the cloud native projects for inference, scheduling, GPU sharing and agent observability move fast, but they are covered patchily by AI-focused press.

### CNCF and Kubernetes

| Source | URL | Strength |
|---|---|---|
| CNCF Blog | https://www.cncf.io/blog/ | Project updates, end-user case studies, community news |
| CNCF Announcements | https://www.cncf.io/announcements/ | Graduations, new projects, surveys and KubeCon news. These are the CNCF's own announcements, so they are primary, not a wire |
| CNCF Reports | https://www.cncf.io/reports/ | The annual survey and cloud native AI reports: adoption data that analyst firms charge for |
| CNCF TOC | https://github.com/cncf/toc/issues | Where projects apply to join or move between sandbox, incubating and graduated; primary for maturity changes |
| Kubernetes Blog | https://kubernetes.io/blog/ | Release announcements and feature deep-dives, such as Dynamic Resource Allocation for GPUs and other accelerators |
| Last Week in Kubernetes Development | https://lwkd.info/ | Weekly summary of merged features, KEPs and release timelines, written by Kubernetes contributors |

### AI on Kubernetes projects

CNCF maturity as listed in the [CNCF landscape](https://landscape.cncf.io/) on 2026-09-13. Project blogs and release notes are the primary source for their own news. Where the URL is a releases index, cite the release's own `/releases/tag/…` page, not the index.

| Project | Maturity | URL | Why it matters |
|---|---|---|---|
| Kubeflow | graduated | https://blog.kubeflow.org/ | The longest-standing ML platform on Kubernetes: pipelines, training operators, serving |
| KServe | incubating | https://github.com/kserve/kserve/releases | Standard model-serving layer; integrates LLM runtimes such as vLLM |
| llm-d | sandbox | https://llm-d.ai/blog | Distributed LLM inference on Kubernetes, with disaggregated prefill and decode |
| kagent | sandbox | https://kagent.dev/blog | Framework for AI agents that run on, and operate, Kubernetes |
| KAITO | sandbox | https://github.com/kaito-project/kaito/releases | Automates model deployment and fine-tuning, including GPU node provisioning |
| Volcano | incubating | https://volcano.sh/blog/ | Batch scheduler used for AI training and inference jobs — blog quiet since May 2026 |
| HAMi | incubating | https://github.com/Project-HAMi/HAMi/releases | GPU sharing and virtualisation across vendors |
| Dapr | graduated | https://blog.dapr.io/posts/ | Dapr Agents and durable workflows for long-running agents — blog quiet since June 2026 |
| OpenTelemetry | graduated | https://opentelemetry.io/blog/ | GenAI semantic conventions: the emerging standard for tracing model and agent calls |
| Kueue | Kubernetes SIG Scheduling | https://kueue.sigs.k8s.io/ | Job queueing and quotas for shared GPU clusters |
| Gateway API Inference Extension | Kubernetes SIG Network | https://gateway-api-inference-extension.sigs.k8s.io/ | Model-aware load balancing for inference traffic |

### News

| Source | URL | Strength |
|---|---|---|
| The New Stack | https://thenewstack.io/kubernetes/ | Daily cloud native and platform engineering news |
| KubeWeekly | https://www.cncf.io/kubeweekly/ | The CNCF's weekly digest. Secondary: use it to find stories, then cite the primary |

**Search strategy**: `site:cncf.io/blog AI OR agent`, `site:cncf.io/announcements`, `site:kubernetes.io/blog`, `site:lwkd.info`, `site:thenewstack.io kubernetes AI`, `site:llm-d.ai`, `site:kagent.dev`, `KServe release`, `"Dynamic Resource Allocation" GPU kubernetes`, `KubeCon 2026 AI`.

---

## 14. Trending Open Source AI

Open-source AI projects that are gaining traction: agent frameworks, coding agents, inference engines, MCP servers, and evaluation and developer tools. Section 9 covers releases of established infrastructure. This section is about momentum: which projects practitioners are adopting now, often weeks before trade press notices them. A project qualifies because its adoption grew in the window, and each item states the evidence (stars gained, trending rank, downloads or usage share) and where it comes from.

### Where traction shows

Lists and dashboards measure the trend; the skill cites the project itself.

| Source | URL | Strength |
|---|---|---|
| GitHub Trending (weekly) | https://github.com/trending?since=weekly | The most direct signal: stars gained this week, filterable by language |
| OSS Insight Trending | https://ossinsight.io/trending | Built from GitHub event data, so it shows forks and contributors as well as stars |
| OSS Insight Collections | https://ossinsight.io/collections | Rankings within AI collections (agent frameworks, LLM tools, MCP), which puts a project in context |
| Trendshift | https://trendshift.io/ | Daily momentum ranking with history, so a project's trajectory is visible |
| Star History | https://www.star-history.com/ | Growth curves; the check that a trend is sustained rather than a one-day spike |
| Hugging Face trending models | https://huggingface.co/models?sort=trending | Open-weight models gaining downloads and likes |
| Hugging Face trending Spaces | https://huggingface.co/spaces?sort=trending | Demos and apps gaining users |
| Hugging Face Trending Papers | https://huggingface.co/papers/trending | Papers whose code is catching on; the successor to Papers with Code, which now redirects here |
| Show HN | https://news.ycombinator.com/show | Launches of new open-source tools, with the community's reaction |
| OpenRouter Rankings | https://openrouter.ai/rankings | Real token usage by model and app, a check on hype |
| Ollama Library (popular) | https://ollama.com/library?sort=popular | Which open models people actually run locally |
| pepy.tech / PyPI Stats | https://pepy.tech/, https://pypistats.org/ | Download growth for Python libraries, the language of most AI tooling |
| npm trends | https://npmtrends.com/ | Download comparisons for JavaScript and TypeScript agent SDKs |

### Foundations and hosts

| Source | URL | Strength |
|---|---|---|
| Agentic AI Foundation (AAIF) | https://aaif.io/ | Linux Foundation home for open agent standards and projects |
| LF AI & Data | https://lfaidata.foundation/ | Linux Foundation AI and data projects; new hosted projects signal industry backing |
| PyTorch Foundation blog | https://pytorch.org/blog/ | PyTorch and the projects the foundation hosts |
| GitHub Blog — open source | https://github.blog/open-source/ | GitHub's own open-source reports and data |

### Guarding against hype

Stars are easy to game, and fake stars are a known problem on GitHub. The skill treats a spike with little commit, issue or contributor activity as suspect and checks Star History or OSS Insight before featuring a project. It skips awesome-lists, course and tutorial repos, prompt collections, and anything tied to a crypto token. Because the checker rejects a URL used in the last four posts, the same trending repo can't reappear every week.

**Search strategy**: fetch GitHub Trending (weekly) and OSS Insight Trending, pick 2–4 AI projects, and confirm each on Star History. Then search `"Show HN" open source AI agent`, `open source AI agent framework GitHub stars this week`, `site:aaif.io`, `site:lfaidata.foundation`.

---

## 15. AI Coding Practitioners

The rest of the catalogue tracks what is released, funded, regulated and benchmarked. This section tracks how engineers actually work with coding agents: their workflows, what fails, how teams adopt the tools and what studies measure. The section takes first-hand accounts and measured studies, and leaves product launches to sections 6 and 8.

Every source was live on 2026-10-02 and had posted in the previous two months, except where noted. Candidates left out because they had gone quiet: Peter Steinberger (last post February 2026), the Aider blog (April 2026) and Eugene Yan (June 2026).

### Practitioner writers

| Writer | URL | Focus |
|---|---|---|
| Simon Willison | https://simonwillison.net/tags/coding-agents/ and https://simonwillison.net/tags/ai-assisted-programming/ | Daily notes on coding agents, agentic engineering patterns and their security limits (also section 3; one item per issue across both) |
| Armin Ronacher | https://lucumr.pocoo.org/ | Flask creator; detailed accounts of agentic coding in real projects, and what goes wrong |
| Mitchell Hashimoto | https://mitchellh.com/writing | Ghostty and HashiCorp founder; how he uses agents in a large open-source codebase (posts every month or two) |
| Geoffrey Huntley | https://ghuntley.com/ | Autonomous agent loops ("Ralph"), building and running coding agents unattended |
| Harper Reed | https://harper.blog/posts/ | End-to-end LLM codegen workflows: spec, plan, execute |
| Kent Beck | https://newsletter.kentbeck.com/ | TDD and design with AI "genies"; augmented coding (was tidyfirst.substack.com) |
| Addy Osmani | https://addyo.substack.com/ | Agent workflows, spec-driven development, team adoption |
| Birgitta Böckeler (martinfowler.com) | https://martinfowler.com/articles/exploring-gen-ai.html | Thoughtworks' running series on generative AI in software delivery; context engineering, spec-driven development |
| Thorsten Ball | https://registerspill.thorstenball.com/ | Weekly notes on building and using coding agents |
| Jesse Vincent | https://blog.fsck.com/ | Superpowers skills library; Claude Code workflows and agent skills |
| Hamel Husain | https://hamel.dev/ | Evals and error analysis applied to AI-written code and AI features |
| Sean Goedecke | https://www.seangoedecke.com/ | How AI changes day-to-day engineering inside a large company |
| Drew Breunig | https://www.dbreunig.com/ | Context engineering, how context fails, and DSPy-style practice |
| Jason Liu | https://jxnl.co/writing/ | Context engineering for coding agents; interviews with tool builders |
| Steve Yegge | https://steve-yegge.medium.com/ | Agent orchestration (Beads, Gas Town), vibe coding at scale; opinionated, posts monthly |
| Charity Majors | https://charity.wtf/ | Observability, production ownership and what AI-written code means for on-call |
| Every — Source Code | https://every.to/source-code | Kieran Klaassen and others on "compounding engineering" with agents in a small company |
| HumanLayer (Dex Horthy) | https://www.humanlayer.dev/blog | Context engineering for coding agents in large brownfield codebases; "12-factor agents" |

### Practice reporting and data

| Source | URL | Focus |
|---|---|---|
| The Pragmatic Engineer (Gergely Orosz) | https://newsletter.pragmaticengineer.com/ | Reported surveys and deep dives on how engineering teams use AI tools; many posts are paywalled, so cite only what the free page states |
| DORA | https://dora.dev/research/ | Google's research on AI-assisted software delivery; the annual report is primary data (quiet since June 2026, the report is due in the autumn) |
| Stack Overflow blog | https://stackoverflow.blog/ | Developer survey results and practitioner essays on AI tooling |
| Thoughtworks Technology Radar | https://www.thoughtworks.com/radar | Twice-yearly verdicts (adopt, trial, assess, hold) on AI coding tools and practices |
| METR | https://metr.org | Controlled studies of AI's effect on developer speed (also section 2) |

### Community

| Venue | Focus |
|---|---|
| r/ChatGPTCoding, r/ClaudeAI, r/cursor | Practitioners comparing workflows and tools (Reddit is search only) |
| Hacker News | Threads on practitioner posts, where the comments add field reports |

### Rules for this section

- **Practice, not product.** An item says what someone did with a coding agent and what they learned: a workflow, a failure, a measured result. A feature launch belongs in section 6 or 8.
- **First-hand or measured.** Prefer a practitioner's account of their own work, or a study with data. Skip listicles, "10 prompts for Cursor" posts and vendor marketing dressed as a case study.
- **One post per writer.** Several of these writers post daily, so the one-per-publisher rule matters here.

**Search strategy**: fetch Simon Willison's coding-agents tag once. Then search `site:lucumr.pocoo.org OR site:mitchellh.com OR site:ghuntley.com OR site:harper.blog`, `site:martinfowler.com "generative AI" OR agent`, `site:addyo.substack.com OR site:newsletter.kentbeck.com OR site:registerspill.thorstenball.com`, `site:blog.fsck.com OR site:seangoedecke.com OR site:dbreunig.com OR site:jxnl.co`, `"coding agent" OR "Claude Code" OR "Codex" OR "Cursor" workflow lessons`, `site:reddit.com/r/ChatGPTCoding OR site:reddit.com/r/ClaudeAI workflow`.
