# Customising the Skill

All files in `.claude/skills/newsletter-ai/` are plain markdown (or JSON for canvas files). Edit them directly — no build step required. Changes take effect immediately in the next Claude Code session.

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
## 12. Podcasts & Video

| Source | URL |
|---|---|
| Latent Space Podcast | https://www.latent.space/podcast |
| Lex Fridman AI episodes | https://lexfridman.com/podcast |
| TWIML AI Podcast | https://twimlai.com/podcast |
```

2. Add the category to the list in `SKILL.md` under **Step 1**:

```markdown
12. **Podcasts & Video** (Latent Space, TWIML, Lex Fridman AI episodes)
```

3. Add a matching section to `template.md` following the same pattern as existing sections.

4. Add the new category to the `categories` list in `obsidian-template.md` frontmatter.

---

## Changing the output format

Edit `.claude/skills/newsletter-ai/template.md`.

**Examples:**

- Remove a section entirely — delete the section block from the template
- Rename a section — change the `##` heading
- Add a new field to each item — add a line like `**Key takeaway**: [one sentence]` to the item template
- Change the tag vocabulary — update the tag list in `SKILL.md` Step 3 and the template simultaneously

---

## Configuring the Obsidian vault path

The default vault path is `~/Documents/AI-Newsletter-Vault/`. There are two ways to change it:

### Per-run override (argument)

Pass the vault path when invoking the skill:

```
/newsletter-ai vault:~/Obsidian/AI-News/
/newsletter-ai vault:~/Documents/PKM/Newsletter/
```

### Permanent change

Edit `SKILL.md` and update the default vault path in Step 5:

```markdown
**Default vault path**: `~/Your/Custom/Path/`
```

---

## Updating the canvas mindmaps

The two canvas files (`newsletter-structure.canvas` and `sources.canvas`) are written to the vault on first run only. If you want to update them:

1. Edit the `.canvas` JSON files in `.claude/skills/newsletter-ai/`
2. Delete the corresponding file from the vault:
   ```bash
   rm ~/Documents/AI-Newsletter-Vault/canvas/newsletter-structure.canvas
   ```
3. Run `/newsletter-ai` — Step 5c will recreate it from the updated template

Alternatively, rearrange nodes directly in Obsidian's Canvas editor. Changes you make in Obsidian do not affect the skill template files.

---

## Scoping to a single topic permanently

If you want a dedicated skill that only covers, say, AI security:

1. Copy the skill directory:

```bash
cp -r ~/.claude/skills/newsletter-ai/ ~/.claude/skills/newsletter-ai-security/
```

2. Edit `~/.claude/skills/newsletter-ai-security/SKILL.md`:
   - Change `name: newsletter-ai-security`
   - Update the description
   - In Step 1, remove all categories except **AI Security**
   - In Step 2, tighten the relevance filter to security-only

3. Trim `sources.md` to security sources only.

4. Adjust `template.md` to remove non-security sections.

5. Update `obsidian-template.md` to reflect the narrower category list.

---

## Changing the default time window

In `SKILL.md`, Step 1 says:

> search for content published in the **last 7 days**

Change `7 days` to any interval (`14 days`, `30 days`, `this month`). This sets the default; you can always override per-run with arguments.

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

This repo ships a `site/` directory and a `.github/workflows/newsletter.yml` workflow that publish a new issue every Friday.

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

**3. Add `ANTHROPIC_API_KEY`** to **Settings → Secrets and variables → Actions**.

That's it. The scheduled workflow generates the newsletter, writes `site/content/posts/YYYY-MM-DD.md`, and pushes. Cloudflare Pages auto-deploys within ~30 seconds.

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
/newsletter-ai vault:~/Obsidian/AI-News/ web:./site
```

The skill writes `<web-path>/content/posts/YYYY-MM-DD.md` with Hugo + PaperMod-compatible frontmatter and the clean newsletter body, then runs `git commit && git push`. Cloudflare Pages deploys within ~30 seconds.

### Changing the default web path permanently

Edit `SKILL.md` Step 6a to hard-code your repo path instead of reading it from `$ARGUMENTS`:

```markdown
**Web repo path**: `./site`
```

Then invoke the skill without the `web:` argument and it will always publish.

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

Instead of the global `~/.claude/skills/` location, copy the skill into the project:

```bash
mkdir -p /path/to/your-project/.claude/skills/newsletter-ai
cp -r .claude/skills/newsletter-ai/ /path/to/your-project/.claude/skills/newsletter-ai/
```

This makes `/newsletter-ai` available only when working inside that project.

---

## Scheduled automation (GitHub Actions)

This repo ships `.github/workflows/newsletter.yml`, a weekly cron workflow that generates the newsletter on a GitHub-hosted runner, commits it to `site/content/posts/`, and pushes — Cloudflare Pages then deploys automatically. No local machine required.

> ⚠️ **Cost note:** the workflow runs `claude -p` on a GitHub runner, which authenticates against `ANTHROPIC_API_KEY` and bills your **Anthropic API account per token**. A single full-category run can be costly. If you already have a Claude Code subscription, running `/newsletter-ai web:./site` locally is free (it uses subscription quota) and performs the same commit/push — see [`CLAUDE.md` → Publishing a new issue](../CLAUDE.md#publishing-a-new-issue). Keep the scheduled workflow only if hands-off automation is worth the API cost to you.

### One-time setup

**1. Scaffold the Hugo site** (only needed once — see [Web publishing → Option A](#option-a--in-repo-recommended-for-scheduled-publishing) above):

```bash
./site/scripts/bootstrap.sh
git add site/ && git commit -m "Scaffold Hugo + PaperMod site" && git push
```

**2. Add your Anthropic API key as a GitHub secret:**

Go to `https://github.com/YOUR-ORG/YOUR-REPO/settings/secrets/actions`, click **New repository secret**, and add:

- **Name:** `ANTHROPIC_API_KEY`
- **Value:** your key from [console.anthropic.com](https://console.anthropic.com)

**3. Connect the repo to Cloudflare Pages** (one-time dashboard step — see [Web publishing → Option A](#option-a--in-repo-recommended-for-scheduled-publishing) above for the exact build settings).

That's it. A new issue publishes every Friday at 09:00 UTC. You can also trigger a run at any time from the **Actions** tab → **Generate Weekly Newsletter** → **Run workflow**.

### Supply-chain protections in the workflow

The shipped workflow's only npm dependency is the Claude Code CLI itself, installed inside the GitHub-hosted runner. Mitigations applied:

- Claude Code CLI is installed at a **pinned version** with `--ignore-scripts` (no postinstall code runs)
- The Cloudflare Pages build runs only Hugo — no `npm install` is ever invoked there
- PaperMod is vendored as a frozen copy at a known commit SHA, recorded in `site/themes/PaperMod/.papermod-sha`
- `.github/dependabot.yml` scans GitHub Actions versions weekly

Bump `CLAUDE_CODE_VERSION` in the workflow file only after reviewing the upstream release. Bump PaperMod by re-running the bootstrap script with `PAPERMOD_REF=<new-ref>` and committing the result (see [`site/README.md`](../site/README.md#updating-papermod)).

### Changing the schedule

Edit the `cron` expression in the workflow file. Examples:

| Cron | Schedule |
|---|---|
| `0 9 * * 5` | Every Friday at 09:00 UTC (default) |
| `0 7 * * 1` | Every Monday at 07:00 UTC |
| `0 9 1 * *` | First day of each month at 09:00 UTC |

### Keeping skill files in sync

When you update the skill (e.g. add a source to `sources.md`):

- **Option A (in-repo)**: the skill files live in this repo at `.claude/skills/newsletter-ai/`. Just commit and push as normal — the next scheduled workflow run picks up the change.
- **Option B (separate Hugo repo)**: copy the updated files into that repo and commit:

```bash
cp -r ~/.claude/skills/newsletter-ai/ ~/my-newsletter-site/.claude/skills/newsletter-ai/
cd ~/my-newsletter-site && git add .claude/ && git commit -m "Update newsletter skill" && git push
```

### Obsidian vault during automated runs

The Obsidian vault is **not** written during automated runs — the GitHub Actions runner is ephemeral. Only the web publish step (Step 6) runs. If you want a local vault copy of a particular issue, run the skill manually:

```
/newsletter-ai vault:~/Documents/AI-Newsletter-Vault/
```
