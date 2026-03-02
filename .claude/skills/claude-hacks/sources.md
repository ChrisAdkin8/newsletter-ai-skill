# Claude Hacks Sources

Use these sources and search strategies for each category. Always prefer primary sources. Use `WebSearch` first; only `WebFetch` when the snippet lacks enough detail to write the description. One fetch per item maximum.

There is **no recency filter** — useful tips are timeless. The duplicate-URL check in SKILL.md Step 2 is the freshness gate.

---

## 1. Reddit

The highest-volume community source. r/ClaudeAI in particular surfaces real-world tips that practitioners have tested.

| Subreddit | Focus |
|---|---|
| r/ClaudeAI | Claude Code workflows, CLAUDE.md tips, settings, frustrations and workarounds |
| r/AIdev | Developer tooling, agent patterns, MCP integrations |
| r/LocalLLaMA | Local model + Claude Code hybrid workflows |

**Search strategy**:

```
site:reddit.com/r/ClaudeAI "CLAUDE.md" OR "tip" OR "workflow" OR "productivity" OR "MCP" OR "slash command"
site:reddit.com "Claude Code" tip OR hack OR workflow upvotes:50+
```

Filter for posts with 50+ upvotes. Prioritise posts where the body or top comment contains a concrete technique, snippet, or configuration — not just opinions.

---

## 2. Hacker News

HN catches "Show HN" posts of Claude Code tools, practitioner war stories, and high-signal comment threads. A single HN thread can surface 5–10 distinct tips from its comments.

- **URL**: https://news.ycombinator.com
- **HN Search**: https://hn.algolia.com/?query=claude+code&type=story

**Search strategy**:

```
site:news.ycombinator.com "Claude Code"
"Claude Code" tips OR workflow site:hn.algolia.com
```

For threads with 100+ points, fetch the page and scan top comments for concrete tips — comment threads often contain better hacks than the linked article.

---

## 3. X / Twitter

Boris Cherny (@bcherny), the Claude Code lead, and other Anthropic engineers post undocumented tips and workflow hints here before they reach docs. Simon Willison (@simonw) regularly posts Claude Code experiments.

**Key accounts**:

| Account | Signal type |
|---|---|
| @bcherny | Claude Code internals, undocumented features, workflow hints from the team |
| @anthropicai | Official feature announcements |
| @simonw (Simon Willison) | Real-world experiments, prompt injection findings, practical tips |
| @alexalbert__ | Anthropic developer relations; community tips |
| @ErikBjare | Power-user Claude Code workflows |

**Search strategy**:

```
"Claude Code" tip OR hack OR workflow site:twitter.com OR site:x.com
"CLAUDE.md" site:twitter.com
from:bcherny "Claude Code"
```

---

## 4. GitHub

GitHub surfaces three types of valuable content: repos built specifically for Claude Code tips (awesome-lists, dotfiles, template collections), issues and discussions in the main `anthropics/claude-code` repo, and CLAUDE.md files from public repos that demonstrate good patterns.

**Search strategy**:

```
site:github.com "CLAUDE.md" tips OR examples OR template
site:github.com "awesome-claude" OR "claude-code-tips" OR "claude-code-hacks"
site:github.com/anthropics "Claude Code" workflow
"CLAUDE.md" site:github.com language:markdown stars:>10
```

Also check:
- `https://github.com/anthropics/claude-code` — README, issues, discussions
- `https://github.com/topics/claude-code` — repos tagged with the topic
- Gists: `site:gist.github.com "CLAUDE.md" OR "claude code"`

---

## 5. Anthropic Official

Primary authoritative source. Docs and changelog entries are definitively accurate; check these first to ensure accuracy of any tip that relates to documented behaviour.

| Source | URL |
|---|---|
| Claude Code docs | https://docs.anthropic.com/en/docs/claude-code/ |
| Anthropic blog (Claude Code posts) | https://www.anthropic.com/news |
| Anthropic changelog | https://www.anthropic.com/changelog |
| Claude Code GitHub repo | https://github.com/anthropics/claude-code |

**Search strategy**:

```
site:docs.anthropic.com "claude code" tips OR configuration OR CLAUDE.md
site:anthropic.com/news "Claude Code" 2025 OR 2026
```

---

## 6. YouTube

Video walkthroughs often demonstrate techniques that are hard to convey in text — keyboard shortcuts, UI flows, real-time agentic sessions.

**Search strategy**:

```
"Claude Code" tutorial OR tips OR workflow site:youtube.com
"Claude Code" productivity site:youtube.com 2025 OR 2026
```

Filter for videos with >1,000 views. Prefer videos that show a specific technique or workflow rather than general overviews. When citing a video, use the YouTube URL as the link target.

Key channels to check:
- Anthropic official YouTube channel
- Developer YouTube channels known for AI coding content (Fireship, Theo, ThePrimeagen when relevant)

---

## 7. Blogs & Personal Sites

Individual practitioners who write detailed Claude Code posts. Simon Willison is the most prolific and reliable; others post occasionally but with high quality.

| Author / Site | URL | Signal type |
|---|---|---|
| Simon Willison | https://simonwillison.net | Detailed experiments, prompt injection, practical use cases |
| Lena Reinhard | search `"Claude Code" site:lenareinhard.com` | Enterprise workflow posts |
| Dev.to | https://dev.to/search?q=claude+code | Community developer posts |
| Medium | search `"Claude Code" tips site:medium.com` | Tutorial articles |
| Substack | search `"Claude Code" site:substack.com` | Developer newsletters |
| Hashnode | search `"Claude Code" site:hashnode.com` | Developer blog posts |

**Search strategy**:

```
site:simonwillison.net "claude code"
"Claude Code" productivity tips site:dev.to OR site:medium.com OR site:hashnode.com
"CLAUDE.md" example site:substack.com
```

---

## 8. MCP Ecosystem

MCP (Model Context Protocol) is Claude Code's primary extension mechanism. The MCP ecosystem has its own blogs, registries, and community channels that surface useful server recommendations.

| Source | URL |
|---|---|
| MCP official docs | https://modelcontextprotocol.io |
| MCP servers registry | https://github.com/modelcontextprotocol/servers |
| Awesome MCP Servers | search `site:github.com "awesome-mcp"` |
| Composio blog | https://blog.composio.io |
| Pydantic AI blog | https://ai.pydantic.dev/blog/ |

**Search strategy**:

```
"MCP server" "Claude Code" useful OR recommended site:github.com OR site:reddit.com
site:modelcontextprotocol.io
"model context protocol" best servers 2025 OR 2026
```

Focus on MCP servers that are directly useful in Claude Code sessions (filesystem, git, databases, browser control, etc.). Skip model-serving MCP servers.

---

## 9. Podcasts & Video (secondary)

Latent Space, Syntax FM, and similar developer podcasts occasionally do deep Claude Code episodes. Use these as pointers to primary resources — always cite the underlying blog post, repo, or docs page rather than the podcast itself.

| Source | URL |
|---|---|
| Latent Space | https://www.latent.space/podcast |
| Syntax FM | https://syntax.fm |
| TWIML AI | https://twimlai.com/podcast |

**Search strategy**:

```
"Claude Code" site:latent.space OR site:syntax.fm
"Claude Code" podcast transcript tips
```

When a podcast discusses a Claude Code technique, find the primary source (GitHub repo, blog post, docs page) that the hosts are referencing and use that URL as the entry.
