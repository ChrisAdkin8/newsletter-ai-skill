# `site/` — Hugo + PaperMod static site

This directory hosts a [Hugo](https://gohugo.io) static site themed with [PaperMod](https://github.com/adityatelange/hugo-PaperMod). Cloudflare Pages builds and deploys it automatically on every push to `main`.

The Hugo binary and PaperMod theme are not vendored eagerly — run the bootstrap script once to scaffold a configured site with PaperMod pinned to a known-good commit.

---

## Prerequisites

You need **Hugo Extended** on your `PATH` locally (only needed during bootstrap and local preview; the Cloudflare build installs its own copy).

```bash
# macOS
brew install hugo

# Linux — download the latest hugo_extended_*_linux-amd64.tar.gz from:
#   https://github.com/gohugoio/hugo/releases
# Verify the SHA256 against the published checksum, then extract to /usr/local/bin.

# Windows
scoop install hugo-extended
```

The Cloudflare Pages build uses whatever version you specify via the `HUGO_VERSION` environment variable (see below) — pin to the same version you have locally.

---

## One-time setup

### 1. Scaffold the site

```bash
./site/scripts/bootstrap.sh
```

The script:

- Verifies Hugo Extended is installed and meets the minimum version
- Initialises a Hugo site in `site/`
- Clones [PaperMod](https://github.com/adityatelange/hugo-PaperMod) at the pinned ref (`v8.0` by default), then strips the `.git` directory — a frozen copy, not a submodule
- Records the resolved commit SHA in `site/themes/PaperMod/.papermod-sha`
- Writes a minimal `hugo.toml` with PaperMod enabled, archive + tags menus, and RSS

Override the pinned ref if you need a different version:

```bash
PAPERMOD_REF=master ./site/scripts/bootstrap.sh
# or pin to a specific commit
PAPERMOD_REF=ee54fe27d633c8aafa49ce0a30b1d97a0e8d2a3e ./site/scripts/bootstrap.sh
```

After the script finishes, edit `site/hugo.toml` to set:

- `baseURL` — your Cloudflare Pages URL (e.g. `https://newsletter-ai.pages.dev/`)
- `title` and the `[params.homeInfoParams]` block — site branding

Then commit everything in `site/` (including `themes/PaperMod/`):

```bash
git add site/
git commit -m "Scaffold Hugo + PaperMod site"
git push
```

### 2. Connect Cloudflare Pages

[Cloudflare dashboard](https://dash.cloudflare.com/) → **Workers & Pages → Create → Pages → Connect to Git**, pick this repo, then on the build configuration screen:

| Setting | Value |
|---|---|
| Production branch | `main` |
| Framework preset | Hugo |
| Root directory (advanced) | `site` |
| Build command | `hugo --gc --minify` |
| Build output directory | `public` |
| Environment variable | `HUGO_VERSION=0.161.1` *(or whatever you have locally — see `hugo version`)* |
| Build system version | **v2** *(Settings → Builds & deployments — v1 ignores `HUGO_VERSION`)* |

Root directory and output directory must be **consistent**: Cloudflare `cd`s into the root before building, and resolves the output path relative to it. Setting root to `site` *and* output to `site/public` makes Cloudflare look for `site/site/public` and fail with *"Could not detect a directory containing static files"*.

Click **Save and Deploy**. The first build takes ~30 seconds.

#### Troubleshooting

- **`Could not detect a directory containing static files`** — root/output mismatch (see above), or the build command never ran (framework preset with empty build command).
- **`Command failed with exit code 1: npx hugo` / `npm error could not determine executable to run`** — `HUGO_VERSION` env var is missing, or Build system version is v1. Cloudflare's Hugo preset shells out to `npx hugo`, which only works when the Hugo binary is provisioned via `HUGO_VERSION` on build system **v2**. Fix: set both, then **Retry deployment** (no new commit needed).

### 3. Enable the scheduled newsletter workflow

Add `ANTHROPIC_API_KEY` to **Settings → Secrets and variables → Actions → New repository secret**. The workflow at `.github/workflows/newsletter.yml` runs every Friday at 09:00 UTC; the commit it produces triggers Cloudflare Pages to deploy.

Trigger a manual run any time from **Actions → Generate Weekly Newsletter → Run workflow**.

---

## Local development

```bash
cd site
hugo server                  # http://localhost:1313 — live reload on edit
hugo                         # builds to site/public
hugo --gc --minify           # production build (same as Cloudflare runs)
```

---

## Updating PaperMod

Vendored themes don't auto-update — that's the point. To pull a newer version:

```bash
# Pick a new tag or commit SHA from https://github.com/adityatelange/hugo-PaperMod
rm -rf site/themes/PaperMod
PAPERMOD_REF=<new-ref> ./site/scripts/bootstrap.sh   # only re-scaffolds the theme dir
git add site/themes/PaperMod
git commit -m "Bump PaperMod to <ref>"
```

Diff your old vs. new copy before committing if you want to inspect what changed.

---

## Why the Hugo + PaperMod choice

Compared to a typical npm-based blog (Astro, Next.js, Gatsby, etc.):

| Concern | This setup | Astro Paper / Next.js |
|---|---|---|
| Dependency tree to audit | 1 Go binary + 1 theme repo | ~600–800 npm packages |
| Build-time code execution surface | Hugo + theme templates only | Every imported npm module |
| Install-time hooks (Shai-Hulud vector) | None | `--ignore-scripts` mitigates |
| Build speed | <1 second for hundreds of posts | 5–60 seconds typical |
| Upstream supply chain incidents (npm-style) | Unheard of in Hugo ecosystem | Several per year |

What this trades away:

- A larger ecosystem of off-the-shelf components (Astro/Next have more)
- Slightly less polished default typography than Astro Paper out of the box (PaperMod is still excellent, just stylistically simpler)
- Go template syntax instead of JSX (some find it less ergonomic)

For a newsletter site that publishes one Markdown file per week, none of those matter. PaperMod ships everything you need: dark mode, search, RSS, tag and archive pages, custom domain, mobile-responsive layout.
