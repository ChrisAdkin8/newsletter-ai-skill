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

## Web publishing (Astro + Vercel)

The skill can auto-publish each issue to a public website using an [Astro Paper](https://github.com/satnaing/astro-paper) static site deployed on Vercel or Netlify. The site gives you dark mode, full-text archives, tag filtering, RSS, and fast CDN delivery — all for free.

### One-time setup

**1. Create the Astro site:**

```bash
npm create astro@latest -- --template satnaing/astro-paper
cd my-astro-site
git init && git add . && git commit -m "Initial Astro Paper site"
```

**2. Push to GitHub:**

```bash
gh repo create my-newsletter-site --public --push
```

**3. Connect to Vercel (free tier):**

Go to [vercel.com](https://vercel.com), click **Add New Project**, import the GitHub repo, and click **Deploy**. That's it — Vercel auto-deploys on every `git push`.

*(Netlify works identically — drag the repo into [netlify.com](https://netlify.com) → **Import from Git**.)*

### Using it

Pass the path to your Astro repo when invoking the skill:

```
/newsletter-ai web:~/my-astro-site
/newsletter-ai vault:~/Obsidian/AI-News/ web:~/my-astro-site
```

The skill writes `src/data/blog/YYYY-MM-DD.md` with Astro Paper-compatible frontmatter and the clean newsletter body, then runs `git commit && git push`. Vercel deploys within ~30 seconds.

### Changing the default web path permanently

Edit `SKILL.md` Step 6a to hard-code your repo path instead of reading it from `$ARGUMENTS`:

```markdown
**Web repo path**: `~/my-astro-site`
```

Then invoke the skill without the `web:` argument and it will always publish.

### What the site looks like

Each issue becomes a post at `https://your-site.vercel.app/posts/YYYY-MM-DD`. The Astro Paper theme provides:

- Chronological issue archive on the home page
- Tag pages (e.g. `/tags/newsletter`) grouping all issues
- RSS feed at `/rss.xml`
- Dark/light mode based on system preference
- Mobile-responsive layout with clean typography

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

The skill can run on a weekly schedule using GitHub Actions — no local machine required. Claude Code CLI is installed on the runner, the skill is loaded from your Astro repo, and the generated issue is committed and pushed, triggering your Vercel or GitHub Pages deployment automatically.

### One-time setup

**1. Copy the skill files into your Astro repo:**

```bash
mkdir -p ~/my-astro-site/.claude/skills/newsletter-ai
cp ~/.claude/skills/newsletter-ai/* ~/my-astro-site/.claude/skills/newsletter-ai/
```

**2. Create the workflow file** at `.github/workflows/newsletter.yml` in your Astro repo:

```yaml
name: Generate Weekly Newsletter

on:
  schedule:
    - cron: '0 9 * * 5'  # Every Friday at 09:00 UTC
  workflow_dispatch:       # Allow manual trigger from GitHub UI

permissions:
  contents: write

jobs:
  generate:
    runs-on: ubuntu-latest
    timeout-minutes: 30

    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install Claude Code CLI
        run: npm install -g @anthropic-ai/claude-code

      - name: Install newsletter skill
        run: |
          mkdir -p ~/.claude/skills
          cp -r .claude/skills/newsletter-ai ~/.claude/skills/

      - name: Configure git
        run: |
          git config user.name "Newsletter Bot"
          git config user.email "bot@yourdomain.com"
          git remote set-url origin https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/${{ github.repository }}.git

      - name: Generate and publish newsletter
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          claude --dangerously-skip-permissions -p "/newsletter-ai web:$(pwd)"

      - name: Push any unpushed changes
        run: |
          git add src/data/blog/ || true
          git diff --staged --quiet || git commit -m "Newsletter $(date -u +%Y-%m-%d)"
          git push || true
```

**3. Add your Anthropic API key as a GitHub secret:**

Go to `https://github.com/YOUR-ORG/YOUR-REPO/settings/secrets/actions`, click **New repository secret**, and add:

- **Name:** `ANTHROPIC_API_KEY`
- **Value:** your key from [console.anthropic.com](https://console.anthropic.com)

That's it. A new issue publishes every Friday at 09:00 UTC. You can also trigger a run at any time from the **Actions** tab → **Generate Weekly Newsletter** → **Run workflow**.

### Changing the schedule

Edit the `cron` expression in the workflow file. Examples:

| Cron | Schedule |
|---|---|
| `0 9 * * 5` | Every Friday at 09:00 UTC (default) |
| `0 7 * * 1` | Every Monday at 07:00 UTC |
| `0 9 1 * *` | First day of each month at 09:00 UTC |

### Keeping skill files in sync

When you update the skill (e.g. add a source to `sources.md`), copy the updated files into the Astro repo and commit:

```bash
cp ~/.claude/skills/newsletter-ai/* ~/my-astro-site/.claude/skills/newsletter-ai/
cd ~/my-astro-site && git add .claude/ && git commit -m "Update newsletter skill" && git push
```

### Obsidian vault during automated runs

The Obsidian vault is **not** written during automated runs — the GitHub Actions runner is ephemeral. Only the web publish step (Step 6) runs. If you want a local vault copy of a particular issue, run the skill manually:

```
/newsletter-ai vault:~/Documents/AI-Newsletter-Vault/
```
