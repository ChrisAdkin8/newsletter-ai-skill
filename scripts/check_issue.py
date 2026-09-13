#!/usr/bin/env python3
"""Check a newsletter post for the defects the published issues had.

Usage: check_issue.py <post> [--posts-dir DIR] [--week YYYY-Www]

Prints `path:line: RULE: message` for each finding and exits 1 if there are
any. Standard library only.
"""

import argparse
import datetime as dt
import re
import sys
from pathlib import Path
from urllib.parse import urlsplit

PREVIOUS_POSTS = 4
WINDOW_DAYS = 7

# A markdown link target, allowing one level of balanced parentheses.
LINK = re.compile(r"\]\((https?://[^()\s]*(?:\([^()\s]*\)[^()\s]*)*)\)")
SOURCE_LINK = re.compile(
    r"\[([^\]]+)\]\((https?://[^()\s]*(?:\([^()\s]*\)[^()\s]*)*)\)"
)
POST_NAME = re.compile(r"^\d{4}-\d{2}-\d{2}\.md$")
WEEK = re.compile(r"\b(\d{4}-W\d{2})\b")

DAY_IN_URL = re.compile(r"(?<!\d)(\d{4})([/-])(\d{2})\2(\d{2})(?!\d)")
MONTH_IN_URL = re.compile(r"/(\d{4})/(\d{2})/(?!\d{2}(?!\d))")
ARXIV_ID = re.compile(r"arxiv\.org/(?:abs|html|pdf)/(\d{2})(\d{2})\.\d{4,5}")

WIRES = (
    "globenewswire.com",
    "prnewswire.com",
    "businesswire.com",
    "einpresswire.com",
    "accesswire.com",
)

LABEL_DOMAINS = {
    "Reddit": ("reddit.com", "redd.it"),
    "Hacker News": ("news.ycombinator.com",),
    "HN": ("news.ycombinator.com",),
    "arXiv": ("arxiv.org",),
    "Microsoft Research": ("microsoft.com",),
    "X": ("x.com", "twitter.com"),
    "Twitter": ("x.com", "twitter.com"),
    "GitHub": ("github.com", "github.blog"),
}


class Post:
    """A post: its lines, and the title and date from its frontmatter."""
    def __init__(self, path):
        """Read the post at `path`."""
        self.path = path
        self.lines = path.read_text(encoding="utf-8").splitlines()
        self.title, self.title_line = None, 1
        self.date, self.date_line = None, 1
        self._read_frontmatter()

    def _read_frontmatter(self):
        """Set title and date, with their line numbers, from the YAML frontmatter."""
        if not self.lines or self.lines[0].strip() != "---":
            return
        for n, line in enumerate(self.lines[1:], start=2):
            if line.strip() == "---":
                return
            key, _, value = line.partition(":")
            value = value.strip().strip("\"'")
            if key == "title":
                self.title, self.title_line = value, n
            elif key == "date":
                self.date_line = n
                try:
                    self.date = dt.date.fromisoformat(value[:10])
                except ValueError:
                    pass

    @property
    def week(self):
        """The YYYY-Www week in the title, or None."""
        m = WEEK.search(self.title or "")
        return m[1] if m else None

    def links(self):
        """Yield (line number, url) for every markdown link."""
        for n, line in enumerate(self.lines, start=1):
            for m in LINK.finditer(line):
                yield n, m[1]

    def sources(self):
        """Yield (line number, label, url) for every link inside [Source: ...]."""
        for n, line in enumerate(self.lines, start=1):
            _, found, rest = line.partition("[Source:")
            if found:
                for m in SOURCE_LINK.finditer(rest):
                    yield n, m[1].strip(), m[2]


def normalise(url):
    """The URL as compared for repeats: host lowercased, no fragment or trailing slash."""
    parts = urlsplit(url)
    return f"{parts.scheme}://{parts.netloc.lower()}{parts.path.rstrip('/')}" + (
        f"?{parts.query}" if parts.query else ""
    )


def host(url):
    """The URL's lowercased hostname."""
    return (urlsplit(url).hostname or "").lower()


def on_domain(url, domains):
    """Whether the URL's host is one of `domains` or a subdomain of one."""
    h = host(url)
    return any(h == d or h.endswith("." + d) for d in domains)


def month_end(year, month):
    """The last day of the month."""
    if month == 12:
        return dt.date(year, 12, 31)
    return dt.date(year, month + 1, 1) - dt.timedelta(days=1)


def url_dates(url):
    """Yield the latest date each date-like part of the URL could mean."""
    for m in DAY_IN_URL.finditer(url):
        try:
            yield dt.date(int(m[1]), int(m[3]), int(m[4]))
        except ValueError:
            pass
    for m in MONTH_IN_URL.finditer(url):
        if 1 <= int(m[2]) <= 12:
            yield month_end(int(m[1]), int(m[2]))
    for m in ARXIV_ID.finditer(url):
        if 1 <= int(m[2]) <= 12:
            yield month_end(2000 + int(m[1]), int(m[2]))


def own_date(post):
    """The post's date for ordering: its filename date, else its frontmatter date."""
    if POST_NAME.match(post.path.name):
        return post.path.stem
    return post.date.isoformat() if post.date else None


def earlier_posts(post, posts_dir):
    """Posts in `posts_dir` dated before `post`, oldest first."""
    mine = own_date(post)
    if mine is None:
        return []
    names = sorted(
        p
        for p in posts_dir.iterdir()
        if POST_NAME.match(p.name)
        and p.stem < mine
        and p.resolve() != post.path.resolve()
    )
    return [Post(p) for p in names]


def check(post, posts_dir, week=None):
    """Return (line, rule, message) findings for `post`, sorted by line.

    `posts_dir` holds the earlier posts; `week`, if given, is the week the
    title must carry.
    """
    findings = []

    def add(line, rule, message):
        if (line, rule, message) not in findings:
            findings.append((line, rule, message))

    earlier = earlier_posts(post, posts_dir)
    previous = earlier[-PREVIOUS_POSTS:]

    # meta
    if post.date is None:
        add(post.date_line, "meta", "frontmatter has no valid date")
    elif post.path.name != f"{post.date.isoformat()}.md":
        add(post.date_line, "meta", f"filename should be {post.date.isoformat()}.md")
    if week and post.week != week:
        add(
            post.title_line,
            "meta",
            f"title week is {post.week or 'missing'}, not {week}",
        )

    # week
    if post.week:
        for other in earlier:
            if other.week == post.week:
                add(
                    post.title_line,
                    "week",
                    f"{post.week} is also the title of {other.path.name}",
                )
                break

    # repeat
    links = list(post.links())
    counts = {}
    for _, url in links:
        counts[normalise(url)] = counts.get(normalise(url), 0) + 1
    used_before = {}
    for other in previous:
        for _, url in other.links():
            used_before.setdefault(normalise(url), other.path.name)
    for n, url in links:
        key = normalise(url)
        reasons = []
        if counts[key] > 1:
            reasons.append(f"used {counts[key]} times in this issue")
        if key in used_before:
            reasons.append(f"used in {used_before[key]}")
        if reasons:
            add(n, "repeat", f"{url} is {' and '.join(reasons)}")

    # stale
    if post.date:
        start = post.date - dt.timedelta(days=WINDOW_DAYS)
        for n, url in links:
            if any(d < start for d in url_dates(url)):
                add(n, "stale", f"{url} is dated before the window start {start}")

    # wire
    for n, url in links:
        if on_domain(url, WIRES):
            add(n, "wire", f"{url} is a press-release wire")

    for n, label, url in post.sources():
        # homepage
        if urlsplit(url).path in ("", "/"):
            add(n, "homepage", f"{url} is a homepage, not an article")
        # label
        for name, domains in LABEL_DOMAINS.items():
            if re.match(
                re.escape(name) + r"(?![\w])", label, re.IGNORECASE
            ) and not on_domain(url, domains):
                add(
                    n, "label", f"label {label!r} names {name} but links to {host(url)}"
                )
                break

    return sorted(findings, key=lambda f: (f[0], f[1]))


def main(argv=None):
    """Run the checker from the command line; return the exit status."""
    parser = argparse.ArgumentParser(description="Check a newsletter post.")
    parser.add_argument("post", type=Path)
    parser.add_argument("--posts-dir", type=Path)
    parser.add_argument("--week", help="the issue week the title must carry, YYYY-Www")
    args = parser.parse_args(argv)
    if args.week and not re.fullmatch(r"\d{4}-W\d{2}", args.week):
        parser.error(f"--week must be YYYY-Www, not {args.week!r}")

    post = Post(args.post)
    posts_dir = args.posts_dir or args.post.parent
    findings = check(post, posts_dir, args.week)
    for line, rule, message in findings:
        print(f"{args.post}:{line}: {rule}: {message}")
    return 1 if findings else 0


if __name__ == "__main__":
    sys.exit(main())
