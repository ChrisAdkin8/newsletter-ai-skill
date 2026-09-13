"""Tests for scripts/check_issue.py, run against the two published issues."""

import re
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CHECKER = ROOT / "scripts" / "check_issue.py"
FIXTURES = ROOT / "tests" / "fixtures"
FINDING = re.compile(r"^(?P<path>.+):(?P<line>\d+): (?P<rule>[a-z]+): ")

CLEAN = """\
---
title: "Agentic AI & LLM Weekly — 2026-W37"
date: 2026-09-18T09:00:00Z
draft: false
---

# Agentic AI & LLM Weekly
**Issue — 11 Sep – 18 Sep 2026**

### A story from this week
`[Community]`

Two sentences about it.

[Source: [The Register](https://www.theregister.com/ai-ml/2026/09/14/a-story-from-this-week/123)]

---

### A paper from this month
`[Research]`

Two sentences about it.

[Source: [arXiv](https://arxiv.org/abs/2609.01234)]

---

### A thread
`[Community]`

[Source: [Hacker News](https://news.ycombinator.com/item?id=48000000)]

- [Further reading](https://example.com/2026/09/reading.html)
"""


def run(post, *args):
    proc = subprocess.run(
        [sys.executable, str(CHECKER), str(post), *args],
        capture_output=True,
        text=True,
    )
    findings = []
    for line in proc.stdout.splitlines():
        m = FINDING.match(line)
        if not m:
            raise AssertionError(f"unparseable output line: {line!r}")
        findings.append((m["rule"], int(m["line"])))
    return proc.returncode, sorted(findings)


def expect(**rules):
    return sorted((rule, line) for rule, lines in rules.items() for line in lines)


class PublishedIssues(unittest.TestCase):
    def test_2026_05_15_against_2026_05_14(self):
        code, found = run(FIXTURES / "2026-05-15.md")
        self.assertEqual(code, 1)
        self.assertEqual(
            found,
            expect(
                repeat=[56, 116, 158, 167, 179, 188, 38, 302],
                homepage=[116, 230],
                stale=[86, 128, 137, 179, 197, 272],
                wire=[281],
                label=[302],
                week=[2],
            ),
        )

    def test_2026_05_14_on_its_own(self):
        with tempfile.TemporaryDirectory() as d:
            post = Path(shutil.copy(FIXTURES / "2026-05-14.md", d))
            code, found = run(post)
        self.assertEqual(code, 1)
        self.assertEqual(
            found,
            expect(
                label=[38],
                repeat=[116, 248],
                homepage=[116, 239, 248, 311],
                stale=[77, 146, 227, 320],
            ),
        )

    def test_later_posts_are_not_previous(self):
        _, found = run(FIXTURES / "2026-05-14.md")
        self.assertNotIn("week", {rule for rule, _ in found})
        self.assertEqual([line for rule, line in found if rule == "repeat"], [116, 248])

    def test_week_argument_mismatch(self):
        _, found = run(FIXTURES / "2026-05-15.md", "--week", "2026-W21")
        self.assertIn(("meta", 2), found)

    def test_week_argument_match(self):
        _, found = run(FIXTURES / "2026-05-15.md", "--week", "2026-W20")
        self.assertNotIn("meta", {rule for rule, _ in found})


class CleanIssue(unittest.TestCase):
    def setUp(self):
        self.dir = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, self.dir)
        for name in ("2026-05-14.md", "2026-05-15.md"):
            shutil.copy(FIXTURES / name, self.dir)

    def write(self, name, text=CLEAN):
        path = self.dir / name
        path.write_text(text)
        return path

    def test_clean_post_passes(self):
        code, found = run(self.write("2026-09-18.md"), "--week", "2026-W37")
        self.assertEqual((code, found), (0, []))

    def test_clean_post_under_another_date(self):
        code, found = run(self.write("2026-09-11.md"))
        self.assertEqual(code, 1)
        self.assertIn("meta", {rule for rule, _ in found})

    def test_posts_dir_option(self):
        other = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, other)
        post = other / "2026-09-18.md"
        post.write_text(CLEAN.replace("2026-W37", "2026-W20"))
        _, found = run(post)
        self.assertEqual(found, [])
        _, found = run(post, "--posts-dir", str(FIXTURES))
        self.assertEqual(found, [("week", 2)])

    def test_only_four_previous_posts(self):
        url = "https://example.com/2026/09/an-old-story.html"
        self.write(
            "2026-08-14.md",
            f'---\ntitle: "x 2026-W32"\ndate: 2026-08-14\n---\n[a]({url})\n',
        )
        for day in ("2026-08-21", "2026-08-28", "2026-09-04", "2026-09-11"):
            self.write(f"{day}.md", f'---\ntitle: "x"\ndate: {day}\n---\n')
        post = self.write("2026-09-18.md", CLEAN + f"- [again]({url})\n")
        _, found = run(post)
        self.assertEqual(found, [])

    def test_stale_month_forms(self):
        text = CLEAN + (
            "- [a](https://example.com/2026/08/whole-month-before.html)\n"
            "- [b](https://example.com/2026/09/same-month.html)\n"
            "- [c](https://arxiv.org/pdf/2608.00001)\n"
            "- [d](https://example.com/news/2026-09-10-day-before.html)\n"
            "- [e](https://example.com/news/2026-09-11-start-day.html)\n"
        )
        _, found = run(self.write("2026-09-18.md", text))
        self.assertEqual(found, [("stale", 34), ("stale", 36), ("stale", 37)])

    def test_label_rules(self):
        text = CLEAN + (
            "[Source: [The Hacker News](https://thehackernews.com/2026/09/x.html)]\n"
            "[Source: [HN](https://news.ycombinator.com/item?id=1)]\n"
            "[Source: [GitHub](https://github.blog/2026-09-15-x/)]\n"
            "[Source: [Reddit r/LocalLLaMA](https://old.reddit.com/r/LocalLLaMA/comments/x)]\n"
            "[Source: [X / Twitter](https://nitter.net/someone/status/1)]\n"
            "[Source: [Redditch Standard](https://example.com/x)]\n"
            "[Source: [arXiv](https://huggingface.co/papers/2609.01234)]\n"
        )
        _, found = run(self.write("2026-09-18.md", text))
        self.assertEqual(found, [("label", 38), ("label", 40)])

    def test_wire_subdomain(self):
        text = (
            CLEAN + "[Source: [PR](https://www.prnewswire.co.uk/x)]\n"
            "[Source: [PR](https://ir.prnewswire.com/news/x)]\n"
        )
        _, found = run(self.write("2026-09-18.md", text))
        self.assertEqual(found, [("wire", 35)])

    def test_repeat_ignores_fragment_and_trailing_slash(self):
        text = (
            CLEAN
            + "- [again](https://www.theregister.com/ai-ml/2026/09/14/a-story-from-this-week/123/#top)\n"
        )
        _, found = run(self.write("2026-09-18.md", text))
        self.assertEqual(found, [("repeat", 15), ("repeat", 34)])


if __name__ == "__main__":
    unittest.main()
