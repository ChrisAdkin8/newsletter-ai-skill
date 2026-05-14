#!/usr/bin/env bash
#
# Bootstrap a Hugo + PaperMod site into ./site
#
# Why this is simpler than the previous Astro Paper bootstrap:
#   - Hugo is a single signed Go binary. Verify the SHA256 of one file
#     against the official release and you've audited 100% of the build tool.
#   - PaperMod is a single theme repo with one maintainer. Vendored as a
#     frozen copy (no submodule, no live tracking) so updates are explicit.
#   - No node_modules, no transitive dependency tree, no npm install at all.
#
# Override either pinned version via environment variable.
# Re-run safe: exits early if site/hugo.toml already exists.

set -euo pipefail

# --- Pinned versions ---------------------------------------------------------
PAPERMOD_REF="${PAPERMOD_REF:-v8.0}"
HUGO_MIN_VERSION="${HUGO_MIN_VERSION:-0.128.0}"
# -----------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SITE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${SITE_DIR}"

# -- Pre-flight checks --------------------------------------------------------

if ! command -v hugo >/dev/null 2>&1; then
  cat >&2 <<'EOF'
ERROR: hugo not found on PATH.

Install Hugo Extended (PaperMod recommends Extended):
  macOS:    brew install hugo
  Linux:    https://github.com/gohugoio/hugo/releases (download hugo_extended_*)
  Windows:  scoop install hugo-extended
            choco install hugo-extended

Verify the binary's SHA256 against the published checksum on the GitHub
release page before installing if you want a fully-audited supply chain.
EOF
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: git not found on PATH." >&2
  exit 1
fi

HUGO_VERSION="$(hugo version | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1 | tr -d v)"
echo "==> Found Hugo ${HUGO_VERSION} (minimum required: ${HUGO_MIN_VERSION})"

# Naive version comparison via sort -V
if [ "$(printf '%s\n%s\n' "${HUGO_MIN_VERSION}" "${HUGO_VERSION}" | sort -V | head -1)" != "${HUGO_MIN_VERSION}" ]; then
  echo "ERROR: Hugo ${HUGO_VERSION} is older than minimum ${HUGO_MIN_VERSION}." >&2
  echo "       Upgrade Hugo or override with HUGO_MIN_VERSION=${HUGO_VERSION}." >&2
  exit 1
fi

if [ -f hugo.toml ] || [ -f hugo.yaml ] || [ -f config.toml ] || [ -f config.yaml ]; then
  echo "Hugo config already exists — skipping scaffold."
  echo "Delete it (and themes/PaperMod, content/, hugo.toml) to re-bootstrap."
  exit 0
fi

# -- Sanity guard: refuse to scaffold if site/ holds unexpected files ---------

expected_only=(scripts README.md .gitignore .gitkeep)
for entry in "${SITE_DIR}"/* "${SITE_DIR}"/.[!.]*; do
  [ -e "${entry}" ] || continue
  name="$(basename "${entry}")"
  match=0
  for allowed in "${expected_only[@]}"; do
    if [ "${name}" = "${allowed}" ]; then match=1; break; fi
  done
  if [ "${match}" -eq 0 ]; then
    echo "Refusing to scaffold: unexpected file or directory in site/: ${name}" >&2
    echo "Move it aside or delete it, then re-run." >&2
    exit 1
  fi
done

# -- Initialise Hugo site -----------------------------------------------------

echo "==> Initialising Hugo site"
hugo new site . --force --format toml >/dev/null

# -- Vendor PaperMod theme at pinned ref --------------------------------------

echo "==> Cloning PaperMod @ ${PAPERMOD_REF} (frozen copy, not submodule)"
mkdir -p themes
rm -rf themes/PaperMod
git clone --depth 1 --branch "${PAPERMOD_REF}" \
  https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
# Record the resolved commit SHA before stripping .git
PAPERMOD_SHA="$(cd themes/PaperMod && git rev-parse HEAD)"
rm -rf themes/PaperMod/.git
echo "==> PaperMod pinned to ${PAPERMOD_REF} = ${PAPERMOD_SHA}"
echo "${PAPERMOD_SHA}" > themes/PaperMod/.papermod-sha

# -- Write a minimal site config ---------------------------------------------

cat > hugo.toml <<'EOF'
baseURL = "https://example.pages.dev/"
languageCode = "en-gb"
title = "Agentic AI & LLM Weekly"
theme = "PaperMod"
enableRobotsTXT = true
buildDrafts = false
buildFuture = false
buildExpired = false

[pagination]
pagerSize = 10

[outputs]
home = ["HTML", "RSS", "JSON"]

[params]
env = "production"
title = "Agentic AI & LLM Weekly"
description = "Weekly digest of agentic AI and LLM developments — curated by Claude Code."
keywords = ["AI", "LLM", "agentic", "newsletter"]
DateFormat = "2 January 2006"
defaultTheme = "auto"
ShowReadingTime = true
ShowShareButtons = false
ShowPostNavLinks = true
ShowBreadCrumbs = true
ShowCodeCopyButtons = true
ShowToc = true
TocOpen = false
ShowRssButtonInSectionTermList = true
disableScrollToTop = false

[params.homeInfoParams]
Title = "Agentic AI & LLM Weekly"
Content = "Curated weekly digest of agentic AI and LLM developments — research, security, products, and policy. New issues every Friday."

[[params.socialIcons]]
name = "rss"
url = "/index.xml"

[[menu.main]]
identifier = "archives"
name = "Archive"
url = "/archives/"
weight = 10

[[menu.main]]
identifier = "tags"
name = "Tags"
url = "/tags/"
weight = 20

[markup.goldmark.renderer]
unsafe = true
EOF

# -- Archives page (PaperMod has a special "archives" layout) -----------------

mkdir -p content
cat > content/archives.md <<'EOF'
---
title: "Archive"
layout: "archives"
url: "/archives/"
summary: "All newsletter issues."
ShowToc: false
ShowReadingTime: false
---
EOF

mkdir -p content/posts

cat <<EOF

==============================================================================
Bootstrap complete.

PaperMod pinned to:
  ref:   ${PAPERMOD_REF}
  sha:   ${PAPERMOD_SHA}

Next steps:
  1. Edit site/hugo.toml — set baseURL to your Cloudflare Pages URL
     and tweak the title / homeInfoParams to suit
  2. Preview locally:
       cd site && hugo server
       open http://localhost:1313
  3. Commit everything:
       git add site/ && git commit -m "Scaffold Hugo + PaperMod site"
  4. Push, then connect this repo to Cloudflare Pages
     (see site/README.md for the dashboard settings)
  5. Add ANTHROPIC_API_KEY to GitHub repo Secrets so the scheduled
     newsletter workflow can run

==============================================================================
EOF
