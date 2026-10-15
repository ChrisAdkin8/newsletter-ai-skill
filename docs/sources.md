# Source Catalogue

The catalogue of sources the skill searches lives in one place: [`.claude/skills/newsletter-ai/sources.md`](../.claude/skills/newsletter-ai/sources.md). The model reads that file on every run, so it is written for the model, and it is the only copy. This page is a map of it.

An earlier version of this page carried a second, annotated copy of the whole catalogue. The two drifted apart within weeks, so it was retired; `git log -- docs/sources.md` has it if you want the rationale prose.

## How the catalogue is organised

- **Don't cite** — the outlets that turned up when a category ran short and that the skill must never link: investment and personal-finance sites, syndicated finance pages, single-company fan sites, crypto outlets off their beat, anonymous aggregators, rewrites of a reachable primary source, rolling indexes and press-release wires. The ones a host list can identify are also enforced by [`scripts/check_issue.py`](../scripts/check_issue.py).
- **Search only** — sites that block automated fetches, so the skill finds their stories by search and cites the article URL the search returns, and the few that refuse `curl` but load with `WebFetch`.
- **Fifteen numbered categories**, matching Step 1 of [`SKILL.md`](../.claude/skills/newsletter-ai/SKILL.md): each lists its sources in a table with a URL and what it's good for, followed by the search queries that work for it. Every URL in the catalogue is a place to look, not a page to cite.

| # | Category | # | Category |
|---|---|---|---|
| 1 | Community & Discussion | 9 | Open Source & Specialised Infrastructure |
| 2 | Research & Papers | 10 | Macro & Hardware Watch |
| 3 | Technical Blogs & Engineering Posts | 11 | Model Evaluations & Transparency |
| 4 | Analyst & Industry Reports | 12 | Newsletters & Podcasts (leads to primary sources only) |
| 5 | AI Security | 13 | Cloud Native & CNCF |
| 6 | Product & Company News | 14 | Trending Open Source AI |
| 7 | Regulatory & Policy | 15 | AI Coding Practitioners |
| 8 | Agent Era & Technical Workflows |   |   |

## Changing it

Add, move or retire a source by editing the catalogue directly; no other file needs to change. [Customising → Adding a new source](customising.md#adding-a-new-source) has examples, and [Adding an entirely new source category](customising.md#adding-an-entirely-new-source-category) covers the files a new category touches.

When you add a source, say in its row what it's for. The model uses that to decide when to search it, and it is the only rationale the catalogue keeps.
