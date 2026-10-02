# Newsletter Sources

Use these sources and search strategies for each category. Always prefer primary sources over aggregators. Check dates carefully.

---

## Don't cite

These turned up in past issues when a category came up short. Skip the item, or find its primary source or a specialist outlet, rather than cite:

- **Investment and personal-finance sites** (The Motley Fool, Seeking Alpha, Benzinga, InvestorPlace). Cite the company's announcement or a news report. Enforced by `scripts/check_issue.py`.
- **Syndicated finance pages** (Yahoo Finance, MSN). Cite the original publisher named on the page. Enforced by `scripts/check_issue.py`.
- **Fan and enthusiast sites for one company** (e.g. SammyFans). Cite the company or a trade outlet such as those in section 10. Enforced by `scripts/check_issue.py`.
- **Crypto outlets for stories that aren't about crypto** (e.g. Forkast on AI infrastructure CVEs). Cite the researcher's disclosure.
- **Anonymous aggregators** (e.g. quasa.io, which has no named writers and sells its own crypto token). Cite the body's own page, such as the EU AI Board's.
- **Rewrites of a primary source you can reach** (a news post about a leaderboard, a changelog or a paper). Cite the leaderboard, changelog or paper.
- **Rolling indexes** (a blog root, changelog, releases page, docs root or trending list). Every URL in this file is a place to look, not a URL to cite: cite the page carrying the story. Enforced by `scripts/check_issue.py`.
- **Press-release wires**: a hard rule in SKILL.md Step 2.

---

## Search only

These sites block automated fetches (HTTP 403 or no connection when checked on 2026-09-13), so fetching one wastes a turn. Find their stories by search, take the date from the snippet, and cite the article URL the search returns:

OpenAI News, xAI News, Reuters, Rapporteur (ex-Euractiv), Axios, Bloomberg (also paywalled), The Information (also paywalled), Gartner, McKinsey, BCG (403 since 2026-10-02), Datacenter Dynamics, Dark Reading, Computing.co.uk, the Center for Democracy & Technology, Lawfare, EU Council press releases, and Reddit (login wall). The BAIR blog didn't respond at all on 2026-09-13.

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
| r/MLOps | MLOps, model deployment, agent observability, production AI systems |

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
| @karpathy (Andrej Karpathy) | Anthropic (pretraining) | Technical insights, model intuition |
| @ylecun (Yann LeCun) | AMI Labs (ex-Meta) | Contrarian views on progress |
| @fchollet (François Chollet) | Ndea / ARC Prize | AGI benchmarking, capability scepticism |
| @GaryMarcus | Independent | AI criticism, failure cases |
| @emollick (Ethan Mollick) | Wharton | Enterprise adoption, real-world use |
| @bcherny (Boris Cherny) | Anthropic / Claude Code | Claude Code, agentic tooling |
| @danhendrycks | CAIS | Safety, evals, frontier risk |

**Search strategy**: `site:twitter.com OR site:x.com "LLM" OR "agentic AI" OR "model release" 2026`

### LinkedIn

LinkedIn posts from named practitioners surface opinions, field notes, and previews not published elsewhere. Most content is behind an auth wall, so `WebFetch` of LinkedIn URLs will fail — always use `WebSearch` with `site:linkedin.com`. Search snippets are usually sufficient to assess and summarise.

**Key profiles**:

| Name | Profile slug (linkedin.com/in/...) | Affiliation | Signal type |
|---|---|---|---|
| Andrew Ng | andrewyng | deeplearning.ai | Applied AI essays, education, weekly field notes — most-followed ML person on LinkedIn |
| Yann LeCun | yannlecun | AMI Labs (ex-Meta) | Architecture debates, AGI scepticism; more substantive on LinkedIn than X |
| Ethan Mollick | emollick | Wharton School | Enterprise AI adoption evidence, research-backed practical use cases |
| Mustafa Suleyman | mustafa-suleyman | Microsoft AI CEO | Microsoft's in-house frontier models, superintelligence strategy, safety framing |
| Cassie Kozyrkov | kozyrkov | CEO and AI adviser, ex-Google Chief Decision Scientist | AI decision-making, MLOps foundations, AI literacy |
| Sebastian Raschka | sebastianraschka | Independent researcher | LLM training, architectures, concise paper summaries |
| Jay Alammar | jalammar | Independent / Cohere | ML visualisations, transformer explanations, educational deep-dives |
| Chip Huyen | chiphuyen | Independent | Inference systems, real-world LLM deployment, MLOps |
| Harrison Chase | harrison-chase-961287118 | LangChain CEO | Agent frameworks, production LLM tooling |
| Jerry Liu | jerry-liu-64390071 | LlamaIndex CEO | RAG systems, agent architectures |
| Gary Marcus | gary-marcus-b6384b4 | Independent AI critic | AI limitations, failure cases, hype analysis |
| Jeff Dean | jeff-dean-8b212555 | Discovery Loop co-founder (left Google in August 2026) | AI research direction, systems at scale |

**Search strategy**: `site:linkedin.com/posts (andrewyng OR yannlecun OR emollick OR kozyrkov OR sebastianraschka OR jalammar OR chiphuyen) "LLM" OR "AI agents" 2026`

---

## 2. Research & Papers

### arXiv
- **URL**: https://arxiv.org/search/?searchtype=all&query=agentic+AI+LLM&start=0
- **Categories to search**: cs.AI, cs.CL, cs.LG, cs.CR (security)
- Search for: `agentic`, `agent`, `RAG`, `tool use`, `RLHF`, `alignment`, `jailbreak`, `prompt injection`
- **Hugging Face daily papers**: https://huggingface.co/papers (aggregates top arXiv papers daily)

### Hugging Face Trending Papers (formerly Papers with Code)
- **URL**: https://huggingface.co/papers/trending (paperswithcode.com now redirects here)
- Focus on: tasks tagged `language-modelling`, `question-answering`, `agents`, `code-generation`

### Conferences
- NeurIPS: https://neurips.cc/ · ICML: https://icml.cc/ · ICLR: https://iclr.cc/
- Accepted papers, best-paper awards and workshop programmes land in bursts. Check the current conference's site during its week, and cite the paper (arXiv or the proceedings page), not the coverage.

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
| Alignment Research Center (ARC) | https://www.alignment.org/blog/ | Alignment research, evals, red-teaming — quiet since June 2026 |
| Center for AI Safety (CAIS) | https://safe.ai/work/research | Policy, evals, frontier risk framing |
| Apollo Research | https://www.apolloresearch.ai/science | Deception, scheming, agent evaluations |
| METR | https://metr.org | Frontier model capability benchmarking |
| Redwood Research | https://blog.redwoodresearch.org/ | Adversarial training, alignment techniques |
| FAR AI | https://www.far.ai/ | Scalable oversight, alignment research |
| Transluce | https://transluce.org | Independent evals and interpretability; agent-behaviour investigations |
| Goodfire | https://www.goodfire.com/research | Interpretability research |
| Anthropic Alignment Science | https://alignment.anthropic.com/ | Anthropic's alignment research posts, often before a paper |
| OpenAI Alignment | https://alignment.openai.com/ | OpenAI's safety research posts; fetchable, unlike openai.com/news |

**Search strategy**: `site:alignment.org`, `site:safe.ai`, `site:apolloresearch.ai`, `site:metr.org`, `site:redwoodresearch.org`, `site:far.ai`, `site:transluce.org`, `site:goodfire.com`, `site:alignment.anthropic.com`, `site:alignment.openai.com`, `"frontier AI" eval 2026`.

### Academic Labs

| Lab | URL | Focus |
|---|---|---|
| Stanford HAI | https://hai.stanford.edu/news | AI policy, economics, society |
| Berkeley AI Research (BAIR) | https://bair.berkeley.edu/blog/ | Robotics, RL, LLM research |
| Allen Institute for AI (AI2) | https://allenai.org/research | Open research, NLP, reasoning |
| EleutherAI | https://blog.eleuther.ai/ | Open-source models, interpretability, evals |

### Alignment & Safety Forums

Priority sources — major safety research often appears here before arXiv.

- **Alignment Forum**: https://www.alignmentforum.org/ — Where ARC, Apollo, Anthropic, and independent alignment researchers publish work first. Sleeper Agents, Apollo's scheming evaluations, and Anthropic's interpretability work all appeared here before arXiv. Check weekly.
- **LessWrong**: https://www.lesswrong.com/ — Community analysis and early framing of capability milestones. Lower signal-to-noise than the Alignment Forum but catches practitioner reasoning before papers form.

**Search strategy**: `site:alignmentforum.org`, `site:lesswrong.com AI`, `"alignment forum" AI safety 2026`.

---

## 3. Technical Blogs & Engineering Posts

### Major lab blogs

| Lab | URL |
|---|---|
| Anthropic | https://www.anthropic.com/news |
| Anthropic Research | https://www.anthropic.com/research |
| Anthropic Engineering | https://www.anthropic.com/engineering |
| OpenAI | https://openai.com/news/ |
| Google DeepMind | https://deepmind.google/blog/ |
| Meta AI | https://ai.meta.com/blog/ |
| Hugging Face | https://huggingface.co/blog |
| Microsoft Research | https://www.microsoft.com/en-us/research/blog/ |
| Microsoft Azure AI | https://azure.microsoft.com/en-us/blog/tag/ai/ |
| Apple ML Research | https://machinelearning.apple.com/ |
| Amazon Science | https://www.amazon.science/blog |
| xAI | https://x.ai/news | search only — 403 |
| Google (product and research) | https://blog.google/innovation-and-ai/technology/ai/ |
| Sakana AI | https://sakana.ai/blog/ |
| Thinking Machines Lab | https://thinkingmachines.ai/blog/ |
| Black Forest Labs | https://bfl.ai/blog |
| Sarvam AI | https://www.sarvam.ai/blogs |

### Chinese labs

These ship many of the week's open-weight releases. Cite the lab's own announcement or model card, not a Western rewrite of it — the Hugging Face repo counts as primary, a news article about it doesn't.

| Lab | URL |
|---|---|
| DeepSeek | https://api-docs.deepseek.com/news/ |
| DeepSeek (weights, papers, code) | https://github.com/deepseek-ai |
| Qwen (Alibaba) | https://qwen.ai/research |
| Qwen on GitHub | https://github.com/QwenLM |
| Moonshot AI (Kimi) | https://www.kimi.ai/blog/ |
| Z.ai / Zhipu (GLM) | https://docs.z.ai/release-notes/new-released |
| MiniMax | https://www.minimax.io/news |
| ByteDance Seed | https://seed.bytedance.com/en/ |
| Baidu ERNIE | https://ernie.baidu.com/blog/ (quiet since May 2026) |
| Tencent Hunyuan | https://huggingface.co/tencent |
| Xiaomi MiMo | https://huggingface.co/XiaomiMiMo |
| Meituan LongCat | https://huggingface.co/meituan-longcat |
| Ant Group inclusionAI (Ling, Ming) | https://huggingface.co/inclusionAI |

For context and translation rather than citation: ChinaTalk (https://www.chinatalk.media/) and Recode China AI (https://www.recodechinaai.com/). Treat both as section 12 secondary sources — use them to find the story, then cite the lab.

**Search strategy**: `site:qwen.ai`, `site:api-docs.deepseek.com`, `DeepSeek OR Qwen OR Kimi OR GLM release <month> 2026`, `site:huggingface.co deepseek OR Qwen OR moonshotai OR tencent OR XiaomiMiMo OR meituan-longcat OR inclusionAI`.

### Infrastructure & tooling company blogs

These companies often publish technical deep-dives before mainstream press picks them up.

| Company | URL | Focus |
|---|---|---|
| NVIDIA Developer | https://developer.nvidia.com/blog/ | CUDA, inference, new GPU architectures |
| NVIDIA News | https://nvidianews.nvidia.com/ | Official product announcements |
| Cerebras | https://www.cerebras.ai/blog | Wafer-scale AI compute |
| Groq | https://groq.com/blog/ | Inference speed, LPU architecture |
| Lambda | https://lambda.ai/blog | GPU cloud, training infrastructure |
| CoreWeave | https://www.coreweave.com/blog-categories/blog | GPU cloud, HPC, AI infra |
| Fireworks AI | https://fireworks.ai/blog | Inference optimisation, model serving |
| Anyscale | https://www.anyscale.com/blog | Ray, distributed ML, production agents |
| AWS Machine Learning | https://aws.amazon.com/blogs/machine-learning/ | Bedrock, Trainium, SageMaker, agent tooling |
| Weights & Biases (CoreWeave) | https://wandb.ai/site/articles/ | W&B articles; the old Fully Connected URL now redirects to CoreWeave Forge. MLOps, experiment tracking, agent observability |
| vLLM | https://vllm.ai/blog | Inference serving, PagedAttention, throughput |
| Scale AI | https://scale.com/blog | Data labelling, fine-tuning, RLHF methodology |
| Databricks | https://www.databricks.com/blog | Enterprise LLM training and deployment |
| Ollama | https://ollama.com/blog | Local model running and distribution |
| CrewAI | https://crewai.com/blog | Multi-agent frameworks, role-based agents |
| Modal | https://modal.com/blog | Serverless GPU inference; high-quality engineering posts on cold starts, GPU utilisation, and model deployment patterns |
| Microsoft Agent Framework | https://devblogs.microsoft.com/agent-framework/ | Agent Framework releases (successor to AutoGen and Semantic Kernel); Microsoft's agentic AI frameworks widely deployed in enterprise |

### AI-only and technical media

Higher signal-to-noise than general tech press.

| Outlet | URL | Strength |
|---|---|---|
| The Decoder | https://the-decoder.com | Fast, accurate model release coverage |
| VentureBeat AI | https://venturebeat.com/ | Enterprise AI, startup coverage |
| MIT Technology Review AI | https://www.technologyreview.com/topic/artificial-intelligence/ | Credible long-form journalism |
| Ars Technica AI | https://arstechnica.com/ai/ | Technically accurate, detailed model coverage |
| IEEE Spectrum AI | https://spectrum.ieee.org/topic/artificial-intelligence/ | Authoritative on hardware and systems |
| The Information (AI) | https://www.theinformation.com | Breaks stories on major lab internals (paywalled) |

### Individual researchers & practitioners

| Author | URL | Focus |
|---|---|---|
| Sebastian Raschka | https://magazine.sebastianraschka.com | Training, architectures, paper reviews |
| Lilian Weng | https://lilianweng.github.io | Deep technical surveys, agent architectures |
| Simon Willison | https://simonwillison.net | LLM tooling, prompt injection, practical use |
| Andrej Karpathy (blog) | https://karpathy.bearblog.dev/blog/ | Fundamentals, model internals; posts rarely since he joined Anthropic in May 2026 |
| Nathan Lambert | https://www.interconnects.ai | RLHF, alignment, open-source models |
| Dwarkesh Patel | https://www.dwarkesh.com/ | Long-form interviews with frontier lab leaders |
| Ethan Mollick | https://www.oneusefulthing.org | Practical enterprise AI adoption signal |
| Percy Liang | https://crfm.stanford.edu | HELM, transparency, evaluation frameworks |
| ARC Prize (François Chollet) | https://arcprize.org/blog | ARC-AGI benchmark results and analysis; capability scepticism grounded in data |
| Gary Marcus | https://garymarcus.substack.com | AI criticism, failure cases, hype analysis |
| Cameron Wolfe | https://cameronrwolfe.substack.com | Deep learning deep-dives, paper breakdowns |
| Dario Amodei | https://darioamodei.com | Essays from Anthropic's CEO, cited as primary when the essay is the story |
| Tim Dettmers | https://timdettmers.com | Quantisation, efficient training, hardware economics |

### Engineering & framework blogs
- LangChain: https://www.langchain.com/blog and https://interrupt.langchain.com (same publisher; blog.langchain.com now redirects to the first)
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
| McKinsey Global Institute | https://www.mckinsey.com/capabilities/quantumblack/our-insights |
| BCG Henderson Institute | https://www.bcg.com/capabilities/artificial-intelligence |
| Deloitte Insights | https://www.deloitte.com/us/en/insights/topics/emerging-technologies.html |

### AI-focused analyst & VC firms

| Source | URL | Strength |
|---|---|---|
| The AI Index (Stanford HAI) | https://hai.stanford.edu/ai-index | Annual benchmark report, policy, education |
| RAND AI | https://www.rand.org/topics/artificial-intelligence.html | National security, policy implications |
| Georgetown CSET | https://cset.georgetown.edu/publications/ | AI and national security, China compute, data-driven policy analysis |
| GovAI | https://www.governance.ai/research | Frontier-AI governance research |
| IAPS | https://www.iaps.ai/research | AI policy and compute governance research |
| Epoch AI | https://epoch.ai/latest | Compute trends, scaling, empirical forecasts |
| AI Now Institute | https://ainowinstitute.org | Labour impact, power, accountability |
| OECD AI | https://oecd.ai/en/ | Policy adoption data, international statistics |
| Brookings AI | https://www.brookings.edu/topics/artificial-intelligence/ | Policy analysis, governance, societal impact |
| a16z AI | https://a16z.com/ai/ | VC perspective, State of AI essays, market sizing |
| Sequoia Capital AI | https://sequoiacap.com/stories/ | Strategic AI market framing, startup trends |
| AI as Normal Technology (ex-AI Snake Oil) | https://www.normaltech.ai/ | Sceptical, evidence-based critique |
| Import AI (Jack Clark) | https://jack-clark.net | Weekly digest, safety, capabilities |
| Air Street Press (Nathan Benaich) | https://press.airstreet.com/ | Analysis and the annual State of AI Report (usually October) |
| Ben Thompson / Stratechery | https://stratechery.com | Business strategy, platform dynamics |

**Search strategy**: `site:gartner.com AI agents`, `"agentic AI" site:mckinsey.com`, `site:a16z.com AI`, `site:brookings.edu artificial-intelligence`.

---

## 5. AI Security

### OWASP
- **OWASP Top 10 for LLM Applications**: https://genai.owasp.org/llm-top-10/
- **OWASP AI Exchange**: https://owaspai.org
- GitHub for latest updates: https://github.com/OWASP/www-project-top-10-for-large-language-model-applications

### MITRE
- **MITRE ATLAS** (adversarial ML threat matrix): https://atlas.mitre.org
- **MITRE CVE** (search for AI/LLM CVEs): https://www.cve.org/CVERecord/SearchResults?query=LLM
- **ATT&CK for AI**: search https://attack.mitre.org

### NIST
- **NIST AI hub** (now titled "Super intelligence"; the AI RMF sits under it): https://www.nist.gov/super-intelligence
- **NIST AI publications**: https://csrc.nist.gov/publications (filter by AI)

### Government cybersecurity agencies

Primary government sources for operational AI security guidance — essential alongside OWASP and MITRE.

| Agency | URL | Covers |
|---|---|---|
| CISA (US) | https://www.cisa.gov/topics/cybersecurity-best-practices/super-intelligence | US operational AI security, critical infrastructure guidance |
| ENISA (EU) | https://www.enisa.europa.eu/ | EU AI threat landscape, security guidelines for AI Act |
| NCSC (UK) | https://www.ncsc.gov.uk/section/advice-guidance/all-topics?topics=Artificial%20intelligence | UK AI security guidance, joint CISA/NCSC advisories |

**Search strategy**: `site:cisa.gov AI`, `site:enisa.europa.eu "artificial intelligence"`, `site:ncsc.gov.uk AI`.

### Threat intelligence labs

These labs publish the actual zero-day disclosures, campaign analyses, and incident write-ups — they break the stories that corporate security blogs (Lakera, HiddenLayer) interpret. Distinct from §5 vendor security blogs in that their primary output is threat reporting, not product marketing.

| Lab | URL | Focus |
|---|---|---|
| Google Threat Intelligence Group (GTIG) | https://cloud.google.com/blog/topics/threat-intelligence | AI-assisted attacks, zero-day discovery, state-sponsored campaigns — publishes Google's confirmed AI exploit disclosures |
| Microsoft Threat Intelligence | https://www.microsoft.com/en-us/security/blog/topic/threat-intelligence/ | Enterprise threat actor reporting, AI-assisted intrusions, ransomware campaigns |
| Palo Alto Unit 42 | https://unit42.paloaltonetworks.com | MCP attack vectors, prompt injection research, agent framework vulnerabilities |
| Mandiant (Google Cloud) | https://cloud.google.com/blog/topics/threat-intelligence/mandiant | Incident response, nation-state AI use, breach forensics |

**Search strategy**: `site:cloud.google.com/blog "threat intelligence"`, `site:microsoft.com/en-us/security/blog "threat intelligence"`, `site:unit42.paloaltonetworks.com`, `"GTIG" OR "Mandiant" AI 2026`.

### Security research & news

| Source | URL | Focus |
|---|---|---|
| AI Village | https://aivillage.org | DEF CON AI track, red-teaming, community |
| Lakera Research | https://www.lakera.ai/research | Gandalf attack analysis, AI Model Risk Index, adversarial ML papers; Lakera is now part of Check Point |
| HiddenLayer | https://www.hiddenlayer.com/innovation-hub | Adversarial ML research; discovered Policy Puppetry (2025) and EchoGram attacks |
| Embrace the Red | https://embracethered.com/blog/ | Johann Rehberger's prompt injection CVE research — real vulnerabilities in GitHub Copilot, Claude Code, Amazon Q, and coding agents |
| Snyk Labs (ex-Invariant) | https://labs.snyk.io/ | MCP security research; discovered Tool Poisoning Attacks and MCP-Scan; Invariant Labs acquired by Snyk 2025 |
| Adversa AI | https://adversa.ai/blog | Adversarial attacks, evasion techniques, MCP security digests |
| Trail of Bits | https://blog.trailofbits.com/ | Hands-on AI red-teaming and model audits |
| Microsoft Security | https://www.microsoft.com/en-us/security/blog/ | AI-assisted attacks, enterprise threat intelligence |
| Simon Willison (prompt injection) | https://simonwillison.net/tags/prompt-injection/ | Real-world prompt injection incidents |
| Wired AI & Security | https://www.wired.com/tag/artificial-intelligence/ | Mainstream AI security incidents |
| Dark Reading AI | https://www.darkreading.com/keyword/artificial-intelligence | Enterprise security practitioner coverage |
| Krebs on Security (AI-related) | https://krebsonsecurity.com | High-quality incident coverage |
| The Hacker News | https://thehackernews.com | Fast, detailed AI security incident coverage; consistently first to publish AI exploit and vulnerability stories |
| The Register (AI/ML) | https://www.theregister.com/ai_ml/ | Sceptical, technically literate AI and security incident reporting |
| CyberScoop | https://cyberscoop.com | Government cybersecurity reporting; strong on CISA, NSA, and Five Eyes advisories |
| Bloomberg Cyber | https://www.bloomberg.com/cybersecurity | Breaking enterprise incidents and AI-related breach disclosures (paywalled) |
| Check Point Research | https://research.checkpoint.com/ | Primary vulnerability research, with frequent findings in AI and LLM platforms |
| OX Security | https://www.ox.security/blog/ | Primary research, with CVEs, on AI coding agents and MCP supply-chain flaws |
| Anthropic Frontier Red Team | https://www.anthropic.com/research/team/frontier-red-team | Primary findings on AI cyber and bio capabilities |
| Wiz Research | https://www.wiz.io/blog/tag/ai | Primary disclosures of flaws in AI and cloud infrastructure |
| XBOW | https://xbow.com/blog | AI-driven vulnerability discovery, with CVEs |
| AISLE | https://aisle.com/blog | AI-driven vulnerability discovery, with CVEs in core open-source projects |
| Zenity Labs | https://zenity.io/blog | Attacks on agents and enterprise copilots |
| Pillar Security | https://www.pillar.security/blog | Agent and AI-app attack research |
| Malwarebytes Labs (AI) | https://www.malwarebytes.com/blog/category/ai | Consumer-side AI-assistant threats; cite only their own research |
| BankInfoSecurity / ISMG (AI & ML) | https://www.bankinfosecurity.com/artificial-intelligence-machine-learning-c-469 | Named reporters with original reporting on AI security and policy |

**Search strategy**: `site:owasp.org LLM`, `site:cisa.gov AI security`, `site:lakera.ai/research`, `site:hiddenlayer.com/innovation-hub`, `site:embracethered.com`, `site:labs.snyk.io`, `"prompt injection" site:github.com`, `"AI security" CVE 2026`, `MITRE ATLAS new technique`, `MCP security vulnerability 2026`, `site:research.checkpoint.com AI`, `site:ox.security/blog`, `site:anthropic.com "frontier red team"`, `site:wiz.io/blog AI`, `site:xbow.com/blog`, `site:aisle.com`, `site:zenity.io/blog`, `site:pillar.security/blog`, `site:bankinfosecurity.com AI`.

---

## 6. Product & Company News

### Model releases & benchmarks
- Search: `"new model" OR "model release" LLM site:huggingface.co`
- OpenRouter model list: https://openrouter.ai/models (sorted by date)
- Arena (formerly LMSYS Chatbot Arena): https://arena.ai/leaderboard (leaderboard changes)

### Developer tool release notes
- Claude Code changelog: https://code.claude.com/docs/en/changelog — a place to find a release, never to cite: it has no per-version anchor (checked 2026-09-18). Cite the release's own page, `https://github.com/anthropics/claude-code/releases/tag/vX.Y.Z`.

### Funding & M&A
- Search: `AI startup funding 2026 series`
- Crunchbase News (AI): https://news.crunchbase.com/sections/ai/
- TechCrunch AI: https://techcrunch.com/category/artificial-intelligence/
- Axios AI: https://www.axios.com/technology/artificial-intelligence
- CNBC Technology: https://www.cnbc.com/technology/ and CNBC AI: https://www.cnbc.com/ai-artificial-intelligence/ (daily: deals, funding, earnings)
- Reuters Technology: https://www.reuters.com/technology/ (blocks automated fetches: find the story by search and cite the article URL)

### LinkedIn
Named practitioner profiles — see **1. Community & Discussion → LinkedIn** for the full profile list and search strategy.

---

## 7. Regulatory & Policy

Track government, legal, and compliance developments. **Always go to primary government sources first** — secondary commentary lags by days and adds interpretation.

### Government primary sources

| Source | URL | Covers |
|---|---|---|
| European Commission — AI Act | https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai | EU AI Act implementation, delegated acts, enforcement |
| EU Council (Consilium) | https://www.consilium.europa.eu/en/press/press-releases/ | Council press releases — political agreements (e.g. AI omnibus deal) land here before Commission digital strategy |
| European Parliament — AI | https://www.europarl.europa.eu/topics/en/topic/artificial-intelligence | Parliament position, plenary votes, MEP statements on AI legislation |
| UK AI Security Institute (AISI) | https://www.aisi.gov.uk/ | UK frontier AI safety, evaluations, international coordination |
| EU AI Office | https://digital-strategy.ec.europa.eu/en/policies/ai-office | AI Act enforcement body: GPAI code of practice, guidelines, consultations |
| EU AI Board | https://digital-strategy.ec.europa.eu/en/policies/ai-board | Member-state board steering AI Act enforcement; meeting outcomes land here |
| NIST CAISSI (US, ex-CAISI) | https://www.nist.gov/caissi | US Center for Advancing Innovation and Standards for Super Intelligence (renamed from CAISI; nist.gov/caisi redirects): pre-deployment model testing, model evaluations, AI Agent Standards Initiative |
| International AI Safety Report | https://internationalaisafetyreport.org | Annual report (February) plus occasional Key Updates; check it when a new edition lands |
| White House OSTP | https://www.whitehouse.gov/ostp/ | US AI executive policy, national strategy |
| FTC (US) | https://www.ftc.gov/news-events/news/press-releases | US enforcement on AI deception, unfair practices, data misuse |
| UK ICO | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/ | UK data protection regulator; AI guidance affecting LLM deployments |
| Canada — responsible AI | https://www.canada.ca/en/government/system/digital-government/digital-government-innovations/responsible-use-ai.html | Federal responsible-AI guidance. The AIDA bill died in January 2025 with no successor, so Canada has no federal AI law |
| Future of Life Institute | https://futureoflife.org/ | AI policy advocacy, open letters, international governance |
| Frontier Model Forum | https://www.frontiermodelforum.org/publications/ | Industry safety body's technical reports and frameworks |

**Search strategy**: `"EU AI Act" enforcement site:ec.europa.eu`, `site:consilium.europa.eu AI`, `site:europarl.europa.eu artificial-intelligence`, `site:aisi.gov.uk`, `site:nist.gov/caissi`, `"AI Office" OR "AI Board" site:digital-strategy.ec.europa.eu`, `site:frontiermodelforum.org`, `site:lawfaremedia.org AI`, `site:fpf.org AI`, `site:ftc.gov AI`, `site:ico.org.uk artificial-intelligence`, `Canada AI regulation`.

### Legal & compliance commentary

| Source | URL | Focus |
|---|---|---|
| IAPP News & Analysis | https://iapp.org/news/ | Privacy law, AI governance, data protection |
| Covington — Inside Privacy | https://www.insideprivacy.com | Data protection, AI Act, enforcement actions |
| Covington — Inside Global Tech | https://www.insideglobaltech.com | Cross-border tech regulation, AI policy |
| HSF Kramer — Behind the Prompt | search `"Behind the Prompt" HSF Kramer site:linkedin.com` | Monthly AI insights, enterprise governance |
| Ada Lovelace Institute | https://www.adalovelaceinstitute.org | Independent UK think tank; rigorous research on AI governance, bias, and accountability — one of the most credible UK policy voices |
| Center for Democracy & Technology | https://cdt.org/ai-policy/ | US civil liberties angle; covers FTC AI enforcement, workplace surveillance, and biometric AI regulation |
| Electronic Frontier Foundation | https://www.eff.org/issues/ai | Civil liberties, IP, and surveillance dimensions of AI that legal commentary sources miss |
| Lawfare (AI) | https://www.lawfaremedia.org/topics/cybersecurity-tech/artificial-intelligence | US legal and national-security analysis: state AI laws, federal preemption; blocks automated fetches, so find stories by search |
| Future of Privacy Forum | https://fpf.org/ | Tracks US state AI and privacy laws; neutral legal analysis |

### Weekly policy news

Government sites publish irregularly, so most weeks start here to find what happened, then cite the primary document where there is one.

| Source | URL | Focus |
|---|---|---|
| Rapporteur (ex-Euractiv) | https://www.rapporteur.com/ | Euractiv relaunched as Rapporteur on 2026-09-28 and euractiv.com redirects there. EU policy news, often first on AI Act and digital omnibus negotiations; blocks automated fetches, so find stories by search |
| Tech Policy Press | https://www.techpolicy.press/ | Frequent news and analysis on US, EU and UK tech and AI policy |
| Transformer | https://www.transformernews.ai/ | Weekly AI policy and safety news; strong on frontier-model regulation and lab governance |
| EU AI Act Newsletter | https://artificialintelligenceact.substack.com/ | Weekly AI Act implementation roundup; secondary, so cite the Commission, AI Office or member-state document it points to |

**Search strategy**: `site:techpolicy.press AI`, `site:transformernews.ai`, `"AI Act" site:artificialintelligenceact.substack.com`, `"AI Act" site:rapporteur.com`, `"AI Act" euractiv` (older stories).

---

## 8. Agent Era & Technical Workflows

Practitioner-focused sources on building and operating agentic AI systems in production.

### Vellum AI Blog
- **URL**: https://www.vellum.ai/blog
- **Focus**: LLM evaluation, orchestration patterns, prompt engineering, production agent workflows

### ByteByteGo
- **Newsletter / Substack**: https://blog.bytebytego.com
- **Focus**: System design patterns for AI, scalable architectures, LLM infrastructure diagrams

### Pydantic AI
- **Docs / Blog**: https://pydantic.dev/articles and https://pydantic.dev/docs/ai/
- **Focus**: Production-grade agent framework from the Pydantic team; first-class MCP support, typed agent patterns, multi-agent orchestration

### LangChain / LangGraph Blog
- **URL**: https://www.langchain.com/blog
- **Focus**: Agent framework patterns, LangGraph state machine releases, LangChain platform announcements, "State of Agent Engineering" reports

### Composio
- **URL**: https://composio.dev/blog
- **Focus**: Tool integration layer for MCP agents; active publisher on MCP security, connector ecosystem, and multi-agent tooling patterns

### Model Context Protocol
- **Spec and docs**: https://modelcontextprotocol.io/
- **Blog**: https://blog.modelcontextprotocol.io/
- **Focus**: the protocol itself — spec revisions, registry, transport and auth changes. Cite this rather than a vendor's summary when the protocol is the story.

### Coding agents
| Product | URL | Focus |
|---|---|---|
| Claude Code changelog | https://code.claude.com/docs/en/changelog | Release notes (also section 6); a place to find a release, never to cite: it has no per-version anchor (checked 2026-09-18). Cite the release's own page, `https://github.com/anthropics/claude-code/releases/tag/vX.Y.Z` |
| Cognition (Devin) | https://cognition.com/blog | Autonomous SWE agents, benchmarks |
| Cursor | https://cursor.com/blog | Editor-integrated agents, model routing |
| n8n | https://blog.n8n.io/ | Workflow automation with LLM steps |
| Factory | https://factory.com/news | Autonomous coding agents (Droids) |
| Amp | https://ampcode.com/chronicle | Coding agent from Sourcegraph's team |
| OpenHands | https://www.openhands.dev/blog | Open-source coding agent |
| GitHub Copilot changelog | https://github.blog/changelog/label/copilot/ | Copilot agent releases; a changelog index, so cite the entry's own page |

### A2A Protocol
- **Blog**: https://a2a-protocol.org/latest/blog/
- **Focus**: the agent-to-agent protocol (v1.0, donated by Google to the Linux Foundation). Cite this rather than a vendor's summary when the protocol is the story.

### Hugging Face — Agents tag
- **URL**: https://huggingface.co/blog?tag=agents
- **Focus**: Agent framework announcements, smolagents releases, and community agent builds from the HF ecosystem (distinct from the main HF blog in open-source section)

**Search strategy**: `"agentic workflow" OR "LLM orchestration" site:vellum.ai OR site:blog.bytebytego.com`, `site:langchain.com/blog`, `site:pydantic.dev/articles OR site:pydantic.dev/docs/ai`, `site:modelcontextprotocol.io`, `site:a2a-protocol.org`, `site:cognition.com/blog`, `site:factory.com`, `site:ampcode.com`, `site:composio.dev/blog`, `"agent architecture" production 2026`, `"MCP" OR "model context protocol" agent 2026`.

---

## 9. Open Source & Specialised Infrastructure

### Hugging Face (open-source angle)
- Open-source model releases: https://huggingface.co/models?sort=trending
- Community blog: https://huggingface.co/blog

### Infrastructure & scaling
- **Anyscale blog**: https://www.anyscale.com/blog — Ray framework, distributed ML in production
- **vLLM blog**: https://vllm.ai/blog — dominant open-source inference serving framework
- **SGLang**: https://docs.sglang.io/ and https://github.com/sgl-project/sglang — the other high-throughput serving engine; releases often benchmark against vLLM
- **llama.cpp**: https://github.com/ggml-org/llama.cpp/releases — the local-inference substrate under Ollama and much else; releases track new model architectures. The releases index is where to look; cite the release's own page, `/releases/tag/bXXXX`.
- **Ollama blog**: https://ollama.com/blog — most popular local model runner
- **SemiAnalysis**: https://newsletter.semianalysis.com/ — chip economics, GPU supply chain

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
| SemiAnalysis | https://newsletter.semianalysis.com/ | Deep chip industry analysis, GPU economics |
| The Next Platform | https://www.nextplatform.com/ | HPC and AI infrastructure economics in depth |
| Datacenter Dynamics | https://www.datacenterdynamics.com/ | Data centre construction, power capacity, AI infrastructure buildout |
| Cerebras blog | https://www.cerebras.ai/blog | Wafer-scale compute developments |
| Groq blog | https://groq.com/blog/ | LPU inference architecture |
| The Information (AI hardware) | search `"AI chips" OR "GPU" site:theinformation.com` | Insider chip reporting |
| Tom's Hardware AI | search `"AI" site:tomshardware.com` | GPU benchmarks, hardware releases |
| AMD AI / ROCm blog | https://rocm.blogs.amd.com/ | MI300X/MI350 developments, ROCm ecosystem; AMD is now a genuine NVIDIA alternative for inference workloads |
| Chips and Cheese | https://chipsandcheese.com | Deep architectural analysis of AMD, Intel, and NVIDIA silicon; complements SemiAnalysis on chip internals |
| Fabricated Knowledge | https://www.fabricatedknowledge.com | Semiconductor supply chain; essential on TSMC capacity, CoWoS packaging, and HBM allocation that constrain AI infrastructure |
| TrendForce | https://www.trendforce.com/news/ | Primary market research on HBM, DRAM and foundry pricing and capacity |
| ServeTheHome | https://www.servethehome.com/ | Hands-on server, accelerator and networking hardware coverage |
| Reuters Technology | https://www.reuters.com/technology/ | Chip deals, export controls and supply-chain news; blocks automated fetches, so find stories by search |

**Search strategy**: `"Nvidia" OR "GPU cluster" OR "AI infrastructure" 2026`, `"data centre AI" site:computing.co.uk`, `site:nextplatform.com AI`, `site:datacenterdynamics.com`, `site:rocm.blogs.amd.com`, `site:chipsandcheese.com`, `site:fabricatedknowledge.com`, `site:trendforce.com HBM OR DRAM`, `site:servethehome.com`, `site:reuters.com chips AI`.

---

## 11. Model Evaluations & Transparency Reports

Evaluation is now a discipline in its own right — distinct from research (§2) and product news (§6). Tracks how models are being measured, compared, and held accountable, including inference economics.

### LMSYS
- **Blog**: https://www.lmsys.org/blog/
- **Arena**: https://arena.ai/leaderboard (formerly LMSYS Chatbot Arena)
- **Focus**: Chatbot Arena methodology, Elo rankings, human preference data at scale

### Artificial Analysis
- **URL**: https://artificialanalysis.ai/articles and https://artificialanalysis.ai
- **Focus**: Model quality, speed, and cost across providers in real time — essential for deployment economics

### Scale AI — SEAL Leaderboards
- **URL**: https://labs.scale.com/leaderboard
- **Focus**: Expert-annotated evaluations; higher rigour than crowd-sourced alternatives

### HELM (Holistic Evaluation of Language Models)
- **URL**: https://crfm.stanford.edu/helm/capabilities/latest/
- **Focus**: Standardised, reproducible benchmarks across accuracy, calibration, robustness, fairness, efficiency

### LiveBench
- **URL**: https://livebench.ai/
- **Focus**: Contamination-free benchmarks using current-events questions; directly addresses the key weakness of static benchmarks

### MLCommons (MLPerf, AILuminate)
- **URL**: https://mlcommons.org/insights/
- **Focus**: Industry-standard, peer-reviewed benchmarks for training and inference speed and for safety. Cite MLCommons, not a vendor's press release about its results

### Vals AI
- **URL**: https://www.vals.ai/home
- **Focus**: Expert-built benchmarks for finance, legal and coding, plus the Vals Index

### Terminal-Bench
- **URL**: https://www.tbench.ai/news
- **Focus**: Agentic coding benchmark that labs quote at launch

### LLM-Stats
- **URL**: https://llm-stats.com
- **Focus**: Cross-model benchmark, price and context-window comparison, updated as models ship

### WhatLLM.org
- **URL**: https://whatllm.org
- **Focus**: Live model rankings and comparisons, with an occasional blog

**Search strategy**: `site:lmsys.org/blog`, `site:artificialanalysis.ai`, `site:labs.scale.com`, `"HELM benchmark" site:crfm.stanford.edu`, `site:livebench.ai`, `site:mlcommons.org`, `site:vals.ai`, `site:tbench.ai`, `"eval" OR "benchmark" LLM 2026`.

---

## 12. Newsletters & Podcasts

**Secondary sources only.** Use search snippets to identify stories, then find and link the primary source. Content discovered here goes into whichever existing section fits — Research, Engineering, Industry, etc. Do not cite a podcast or newsletter when you can cite the original paper or post.

| Source | URL | Focus |
|---|---|---|
| The Batch (deeplearning.ai) | https://www.deeplearning.ai/the-batch/ | Andrew Ng's weekly digest; surfaces enterprise adoption signals and research framing before mainstream press |
| Latent Space | https://www.latent.space/podcast | Developer-focused interviews with AI researchers and builders; often first to surface new research directions weeks before papers publish |
| TWIML AI Podcast | https://twimlai.com/podcast/twimlai | Technical ML and AI interviews; strong on production ML, research, and hardware topics |
| Don't Worry About the Vase (Zvi Mowshowitz) | https://thezvi.substack.com | The most complete weekly roundup of the AI week; good for finding stories |
| Exponential View (Azeem Azhar) | https://www.exponentialview.co | Weekly on AI's economic and social effects |
| Understanding AI (Timothy B. Lee) | https://www.understandingai.org | Explainers and reporting on AI policy and capabilities |

**Search strategy**: `site:deeplearning.ai/the-batch`, `site:latent.space`, `site:twimlai.com`, `site:thezvi.substack.com`, `site:exponentialview.co`, `site:understandingai.org`. Use as gap-fillers — if a story appears here and not in primary sources, find and link the primary source rather than citing the newsletter/podcast.

---

## 13. Cloud Native & CNCF

How AI models and agents are built and run on Kubernetes and CNCF projects, plus the CNCF's own major news: graduations, new projects, releases and KubeCon. Prefer the project's own blog or release notes; use The New Stack and KubeWeekly to find stories, then cite the primary.

### CNCF and Kubernetes

| Source | URL | Focus |
|---|---|---|
| CNCF Landscape | https://landscape.cncf.io |
| CNCF Blog | https://www.cncf.io/blog/ | Project updates, end-user case studies, community news |
| CNCF Announcements | https://www.cncf.io/announcements/ | Graduations, new projects, surveys and KubeCon news; the CNCF's own announcements, not a wire |
| CNCF Reports | https://www.cncf.io/reports/ | Annual survey, cloud native AI reports |
| CNCF TOC | https://github.com/cncf/toc/issues | Project applications and moves between sandbox, incubating and graduated |
| Kubernetes Blog | https://kubernetes.io/blog/ | Release announcements, feature deep-dives such as Dynamic Resource Allocation for accelerators |
| Last Week in Kubernetes Development | https://lwkd.info/ | Weekly: merged features, KEPs, release timelines |

### AI on Kubernetes projects

CNCF maturity as listed in the CNCF landscape on 2026-09-13. Where the URL is a releases index, cite the release's own `/releases/tag/…` page, not the index.

| Project | Maturity | URL | Focus |
|---|---|---|---|
| Kubeflow | graduated | https://blog.kubeflow.org/ | ML pipelines, training and serving on Kubernetes |
| KServe | incubating | https://github.com/kserve/kserve/releases | Model inference serving and LLM runtimes |
| llm-d | sandbox | https://llm-d.ai/blog | Distributed LLM inference on Kubernetes |
| kagent | sandbox | https://kagent.dev/blog | Framework for AI agents that run on and operate Kubernetes |
| KAITO | sandbox | https://github.com/kaito-project/kaito/releases | Automated model deployment and fine-tuning |
| Volcano | incubating | https://volcano.sh/blog/ | Batch and AI job scheduling — blog quiet since May 2026 |
| HAMi | incubating | https://github.com/Project-HAMi/HAMi/releases | GPU sharing and virtualisation |
| Dapr | graduated | https://blog.dapr.io/posts/ | Dapr Agents and durable workflows for agents — blog quiet since June 2026 |
| OpenTelemetry | graduated | https://opentelemetry.io/blog/ | GenAI semantic conventions; tracing model and agent calls |
| Kueue | Kubernetes SIG Scheduling | https://kueue.sigs.k8s.io/ | Job queueing and quotas for AI and batch |
| Gateway API Inference Extension | Kubernetes SIG Network | https://gateway-api-inference-extension.sigs.k8s.io/ | Model-aware routing for inference traffic |

### News

| Source | URL | Focus |
|---|---|---|
| The New Stack | https://thenewstack.io/kubernetes/ | Daily cloud native and platform engineering news |
| KubeWeekly | https://www.cncf.io/kubeweekly/ | The CNCF's weekly digest; secondary, so use it to find stories and cite the primary |

**Search strategy**: `site:cncf.io/blog AI OR agent`, `site:cncf.io/announcements`, `site:kubernetes.io/blog`, `site:lwkd.info`, `site:thenewstack.io kubernetes AI`, `site:llm-d.ai`, `site:kagent.dev`, `KServe release`, `"Dynamic Resource Allocation" GPU kubernetes`, `KubeCon 2026 AI`.

---

## 14. Trending Open Source AI

Open-source AI projects gaining traction this week: agent frameworks, coding agents, inference engines, MCP servers, and evaluation and developer tools. An item here is a project whose adoption grew in the window, not an established project's routine release (that belongs in section 9). Link the repository, or a release inside the window, and state the evidence in the summary with its source: stars gained this week, a trending rank, download growth or usage share.

### Where traction shows

These are lists and dashboards: evidence for a trend, not sources to cite. Fetch the first two directly, once each.

| Source | URL | Signal |
|---|---|---|
| GitHub Trending (weekly) | https://github.com/trending?since=weekly | Most stars gained this week; filter by language, e.g. `/trending/python?since=weekly` |
| OSS Insight Trending | https://ossinsight.io/trending | Trending repos, with star, fork and contributor growth from GitHub event data |
| OSS Insight Collections | https://ossinsight.io/collections | Rankings within AI collections such as agent frameworks, LLM tools and MCP |
| Trendshift | https://trendshift.io/ | Daily momentum ranking of GitHub repos, with history |
| Star History | https://www.star-history.com/ | Star growth curves, to confirm a trend isn't a one-day spike |
| Hugging Face trending models | https://huggingface.co/models?sort=trending | Open-weight models gaining downloads and likes |
| Hugging Face trending Spaces | https://huggingface.co/spaces?sort=trending | Demos and apps gaining users |
| Hugging Face Trending Papers | https://huggingface.co/papers/trending | Papers whose code is catching on |
| Show HN | https://news.ycombinator.com/show | Launches of new open-source tools, with community reaction |
| OpenRouter Rankings | https://openrouter.ai/rankings | Token usage by model and app, including open-weight models' share of real traffic |
| Ollama Library (popular) | https://ollama.com/library?sort=popular | Which open models people run locally |
| pepy.tech / PyPI Stats | https://pepy.tech/, https://pypistats.org/ | Python package downloads and their growth |
| npm trends | https://npmtrends.com/ | JavaScript and TypeScript package downloads |

### Foundations and hosts

| Source | URL | Focus |
|---|---|---|
| Agentic AI Foundation (AAIF) | https://aaif.io/ | Linux Foundation home for open agent standards and projects: new projects and releases |
| LF AI & Data | https://lfaidata.foundation/ | Linux Foundation AI and data projects: new hosted projects, graduations |
| PyTorch Foundation blog | https://pytorch.org/blog/ | PyTorch and the projects the foundation hosts |
| GitHub Blog — open source | https://github.blog/open-source/ | GitHub's own open-source reports and data |

### Rules for this section

- **Evidence, not hype.** Say what grew, by how much and according to what, e.g. "+6,200 stars this week (GitHub Trending)".
- **Cite the project.** Link its repository or release, labelled with its publisher ("GitHub" for github.com), not a trending page, listicle or aggregator.
- **Check the trend is real.** A star spike with little commit, issue or contributor activity is suspect, because fake stars are a known problem. Check Star History or OSS Insight before featuring it.
- **Skip** awesome-lists, course and tutorial repos, prompt collections, and anything tied to a crypto token.

**Search strategy**: fetch GitHub Trending (weekly) and OSS Insight Trending, pick 2–4 AI projects, and confirm each on Star History. Then search `"Show HN" open source AI agent`, `open source AI agent framework GitHub stars this week`, `site:aaif.io`, `site:lfaidata.foundation`.

---

## 15. AI Coding Practitioners

How working engineers actually use coding agents: field reports, workflows, failure modes, team practices and measured effects on productivity. This isn't product news (section 6) or agent-building frameworks (section 8). A coding agent's release belongs there; a practitioner's account of using it belongs here. Cite the practitioner's own post, not a roundup that quotes it.

Sources checked on 2026-10-02. Each posted within the previous two months except where noted.

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
