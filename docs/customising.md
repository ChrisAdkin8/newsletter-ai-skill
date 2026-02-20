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

## Installing into a specific project only

Instead of the global `~/.claude/skills/` location, copy the skill into the project:

```bash
mkdir -p /path/to/your-project/.claude/skills/newsletter-ai
cp -r .claude/skills/newsletter-ai/ /path/to/your-project/.claude/skills/newsletter-ai/
```

This makes `/newsletter-ai` available only when working inside that project.
