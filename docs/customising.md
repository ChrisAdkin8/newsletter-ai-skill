# Customising the Skill

All files in `.claude/skills/newsletter-ai/` are plain markdown. Edit them directly — no build step required. Changes take effect in the next Claude Code session, and scheduled runs use them from the next run, since they load the skill straight from the repo.

---

## Adding a new source

Open `.claude/skills/newsletter-ai/sources.md` and add an entry to the relevant category section.

**Example — adding a new security blog:**

```markdown
| Snyk Security Blog | https://snyk.io/blog/tag/ai-security/ |
```

Add it to the table under **5. AI Security → Security research & news**.

**Example — adding a new subreddit:**

```markdown
| r/OpenAI | OpenAI product news and community discussion |
```

Add it to the table under **1. Community & Discussion — Reddit**.

No other files need updating — `SKILL.md` references `sources.md` as a whole, so additions are picked up automatically.

---

## Adding an entirely new source category

1. Add a new section to `sources.md`:

```markdown
## 15. Podcasts & Video

| Source | URL |
|---|---|
| Latent Space Podcast | https://www.latent.space/podcast |
| Lex Fridman AI episodes | https://lexfridman.com/podcast |
| TWIML AI Podcast | https://twimlai.com/podcast |
```

2. Add the category to the list in `SKILL.md` under **Step 1**:

```markdown
15. **Podcasts & Video** (Latent Space, TWIML, Lex Fridman AI episodes)
```

3. Add a matching section to `template.md` following the same pattern as existing sections.

4. Add the category, with the rationale for each source, to [`docs/sources.md`](sources.md).

---

## Changing the output format

Edit `.claude/skills/newsletter-ai/template.md`.

**Examples:**

- Remove a section entirely — delete the section block from the template
- Rename a section — change the `##` heading
- Add a new field to each item — add a line like `**Key takeaway**: [one sentence]` to the item template
- Change the tag vocabulary — update the tag list in `SKILL.md` Step 3 and the template simultaneously

---

## Scoping to a single topic permanently

If you want a dedicated skill that only covers, say, AI security:

1. Copy the skill directory:

```bash
cp -r .claude/skills/newsletter-ai/ .claude/skills/newsletter-ai-security/
```

2. Edit `.claude/skills/newsletter-ai-security/SKILL.md`:
   - Change `name: newsletter-ai-security`
   - Update the description
   - In Step 1, remove all categories except **AI Security**
   - In Step 2, tighten the relevance filter to security-only

3. Trim `sources.md` to security sources only.

4. Adjust `template.md` to remove non-security sections.

---

## Changing the default time window

In `SKILL.md`, Step 1 says:

> search for content published in the window: the **7 days up to the issue date**

Change `7 days` there and in Step 2's "Dated inside the window" rule, and change `WINDOW_DAYS` in `scripts/check_issue.py` to match, or the checker will hold items your window allows.

---

## Changing the audience tone

The opening paragraph of `SKILL.md` defines the audience:

> Your audience is technical practitioners, researchers, and security professionals.

Change this to adjust the writing tone for the whole newsletter. Examples:

- `Your audience is C-suite executives with limited technical background.` — produces higher-level summaries
- `Your audience is open-source developers building with LLMs.` — tightens focus on tooling and code
- `Your audience is security analysts at enterprise organisations.` — emphasises threat and risk framing

---

## Web publishing (Hugo + PaperMod on Cloudflare Pages)

The skill can auto-publish each issue to a public website using a [Hugo](https://gohugo.io) static site themed with [PaperMod](https://github.com/adityatelange/hugo-PaperMod) and deployed on **Cloudflare Pages**. You get dark mode, full-text search, tag pages, archive view, RSS, and fast CDN delivery — all on a free tier with **unlimited bandwidth**.

Vercel and Netlify both support Hugo natively if you prefer them.

**Why Hugo + PaperMod over npm-based stacks?** One Go binary plus one theme repo to audit, no transitive dependency tree, builds in under a second, and no exposure to npm supply-chain incidents (Shai-Hulud, `eslint-config-prettier`, `node-ipc`, etc.).

### Option A — in-repo (recommended for scheduled publishing)

This repo ships a `site/` directory that the skill publishes into. To publish every week without you, see [Scheduled publishing (launchd)](#scheduled-publishing-launchd).

**Prerequisite:** Hugo Extended on your local PATH (`brew install hugo` on macOS).

**1. Scaffold the site:**

```bash
./site/scripts/bootstrap.sh
git add site/ && git commit -m "Scaffold Hugo + PaperMod site"
git push
```

The bootstrap script verifies your Hugo version, initialises a Hugo site, clones PaperMod at the pinned ref (`v8.0` by default), strips the `.git` directory to vendor it as a frozen copy, and records the resolved commit SHA in `site/themes/PaperMod/.papermod-sha`. See [`site/README.md`](../site/README.md) for the full rationale and how to bump PaperMod later.

**2. Connect Cloudflare Pages:**

[Cloudflare dashboard](https://dash.cloudflare.com/) → Workers & Pages → Create → Pages → Connect to Git → select your repo, then set:

| Setting | Value |
|---|---|
| Production branch | `main` |
| Framework preset | Hugo |
| Root directory (advanced) | `site` |
| Build command | `hugo --gc --minify` |
| Build output directory | `public` |
| Environment variable | `HUGO_VERSION=0.161.1` *(or whatever you have locally — see `hugo version`)* |
| Build system version | **v2** *(Settings → Builds & deployments — v1 ignores `HUGO_VERSION`)* |

> **Heads-up on path consistency:** root and output must agree. Cloudflare `cd`s into the root directory before building and resolves the output path relative to it, so setting root to `site` *and* output to `site/public` makes it look for `site/site/public` → *"Could not detect a directory containing static files"*. And without `HUGO_VERSION` on Build system v2, the Hugo preset's `npx hugo` step fails with `npm error could not determine executable to run`.

That's it. Each run of `scripts/weekly.sh` writes `site/content/posts/YYYY-MM-DD.md`, checks it, and pushes it, and Cloudflare Pages auto-deploys within ~30 seconds.

### Option B — separate Hugo repo (manual local publishing)

If you'd rather keep the site in its own repo:

```bash
hugo new site my-newsletter-site --format toml
cd my-newsletter-site
git clone --depth 1 --branch v8.0 \
  https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
rm -rf themes/PaperMod/.git           # vendor as frozen copy
echo 'theme = "PaperMod"' >> hugo.toml
git init && git add . && git commit -m "Initial Hugo + PaperMod site"
gh repo create my-newsletter-site --public --push
```

Then connect that repo to Cloudflare Pages (same dashboard steps as Option A).

### Using it

Pass the path to your Hugo repo when invoking the skill:

```
/newsletter-ai web:./site                          # Option A — this repo
/newsletter-ai web:~/my-newsletter-site            # Option B — separate repo
```

The skill writes `<web-path>/content/posts/YYYY-MM-DD.md` with Hugo + PaperMod-compatible frontmatter and the clean newsletter body. It doesn't commit or push. Check the post, then publish it yourself:

```bash
python3 scripts/check_issue.py <web-path>/content/posts/YYYY-MM-DD.md
git -C <web-path> add content/posts && git -C <web-path> commit -m "Newsletter YYYY-MM-DD" && git -C <web-path> push
```

Cloudflare Pages deploys within ~30 seconds. For this repo's site, `scripts/weekly.sh` does all of this for you.

### Changing the default web path permanently

Edit `SKILL.md` Step 6b to hard-code your repo path instead of reading it from `$ARGUMENTS`:

```markdown
**Web repo path**: `./site`
```

Then invoke the skill without the `web:` argument and it will always write the post.

### What the site looks like

Each issue becomes a post at `https://your-site.pages.dev/posts/YYYY-MM-DD/`. PaperMod provides:

- Chronological post list on the home page with reading time + summary
- Archive page at `/archives/` with one-line entries grouped by year
- Tag pages (e.g. `/tags/newsletter/`) grouping all issues with that tag
- Full-text search via the built-in Fuse-style index
- RSS feed at `/index.xml`
- Dark/light mode based on system preference
- Mobile-responsive layout with clean typography
- Reading time, table of contents, breadcrumbs, and "back to top" on each post

---

## Installing into a specific project only

The skill is a project skill in this repo. To use it in another project, copy it there:

```bash
mkdir -p /path/to/your-project/.claude/skills/newsletter-ai
cp -r .claude/skills/newsletter-ai/ /path/to/your-project/.claude/skills/newsletter-ai/
```

This makes `/newsletter-ai` available only when working inside that project.

---

## Scheduled publishing (launchd)

A launchd agent on your Mac runs `scripts/weekly.sh` every day at 09:07 and 18:07, and it publishes at most one issue per week. An issue week runs from Friday to Thursday, so a week has 14 slots; if the Mac is asleep at a slot, launchd runs it on wake. Runs use your Claude Code subscription, capped at $10 each with `--max-budget-usd`.

The model runs with no shell, no MCP servers and no access to `~/notes`, and can write only under `site/content/posts/` and `.newsletter/`. The script owns git: it pushes only if the run added nothing but the new post and `scripts/check_issue.py` passes it.

### One-time setup

**1. Store a token in the Keychain.** `claude setup-token` prints a one-year token. Save it under `claude-newsletter`; with `-w` last, `security` prompts for it instead of taking it on the command line:

```bash
claude setup-token
security add-generic-password -s claude-newsletter -a "$USER" -w
```

**2. Install the agent:**

```bash
scripts/install-agent.sh
```

This copies the pinned CLI (`CLAUDE_PIN` in the script) and `scripts/weekly.sh` to `~/.local/share/newsletter-ai/`, renders `scripts/local.newsletter-ai.weekly.plist.in` into `~/Library/LaunchAgents/`, and loads it. launchd runs the installed copy, so nothing written into the repo is executed on the next slot.

**3. Vet it under launchd with a probe**, which only sends "say ok":

```bash
PROBE=1 scripts/install-agent.sh
launchctl kickstart -k gui/$(id -u)/local.newsletter-ai.weekly   # expect a "probe ok" notification
scripts/install-agent.sh                                         # clears PROBE
```

**4. Publish now**, or wait for the next slot:

```bash
launchctl kickstart -k gui/$(id -u)/local.newsletter-ai.weekly
```

### What a run does

1. It exits if this week's issue is already out (`last-ok` holds the week), or if the Anthropic API is unreachable.
2. It warns if the repo's `scripts/weekly.sh` differs from the installed copy, or if a global copy of the skill exists in `~/.claude/skills/`.
3. It needs `main` and a clean tree, then fetches. If the last run committed but failed to push, it pushes that commit now; any other unpushed commit stops it.
4. It runs `/newsletter:newsletter-ai web:<repo>/site date:<today> week:<week> triage:<repo>/.newsletter`.
5. It holds the issue unless the only change is the new `site/content/posts/<date>.md` and the checker passes it. Otherwise it commits `Newsletter <date>`, pushes, and records the week in `last-ok`.
6. It filters `.newsletter/triage.md` into `~/notes/inbox/<date>-newsletter-triage.md` (see [How it works → Step 5](how-it-works.md#step-5-triage-optional)) and notifies you with the run's cost.

### When an issue is held

A held post stays in `site/content/posts/`, uncommitted, and later slots stop at the clean-tree check until you deal with it. The checker's findings are in `~/Library/Logs/newsletter/<week>.check`. Either:

- delete the post (`rm site/content/posts/<date>.md`), and the next slot tries again; or
- fix it, then check, commit and push it yourself, and record the week so the agent doesn't write a second issue:

```bash
python3 scripts/check_issue.py site/content/posts/<date>.md --week <week>
git add site/content/posts/<date>.md && git commit -m "Newsletter <date>" && git push
echo <week> > ~/Library/Logs/newsletter/last-ok
```

### Publishing by hand

Run the same wrapper from a terminal in the repo:

```bash
scripts/weekly.sh
```

It uses the installed pinned CLI, so run `scripts/install-agent.sh` first; `CLAUDE_BIN=$(command -v claude) scripts/weekly.sh` uses your current one instead. `/newsletter-ai web:./site` in Claude Code writes the post without publishing it, which is useful for a preview.

### Day to day

| To | Do |
|---|---|
| Change the wrapper | Edit `scripts/weekly.sh`, run `make check`, then re-run `scripts/install-agent.sh`. Every slot notifies you until you do. |
| Change the triage interests | Edit `scripts/interests.txt`, one interest per line. |
| Change the schedule | Edit `StartCalendarInterval` in `scripts/local.newsletter-ai.weekly.plist.in` and re-run the installer. |
| Bump the CLI | Re-run spike 1's confinement probe ([`docs/specs/2026-09-13-weekly-local-publishing.md`](specs/2026-09-13-weekly-local-publishing.md#spike-questions)), then change `CLAUDE_PIN` in `scripts/install-agent.sh`, install with `PROBE=1` and kickstart. |
| Read the logs | `~/Library/Logs/newsletter/`: `launchd.log`, `<week>.json` (the run's result), `<week>.check` (the checker's output) and `last-ok`. |
| Stop it | `launchctl bootout gui/$(id -u)/local.newsletter-ai.weekly`, then remove `~/Library/LaunchAgents/local.newsletter-ai.weekly.plist` and `~/.local/share/newsletter-ai/`. |

Deleting the Keychain item doesn't revoke the token; it stays valid for a year.
