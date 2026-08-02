# Dear Power

An open letter to power — honest feedback to those in power. Static blog
(Jekyll), published from git.

## Publish a dispatch

Add a markdown file under `_posts/`:

```
_posts/YYYY-MM-DD-slug.md
```

with front matter:

```yaml
---
layout: post
title: "Your title"
to: "The addressee (e.g. a minister, a party, an institution)"   # optional
---

Body in markdown.
```

Then `git push`. GitHub Pages builds and deploys automatically (native Jekyll,
deploy-from-branch). No build step to run locally.

## Local preview (optional)

```
gem install bundler jekyll
jekyll serve
```

## Handles

- **en:** Dear Power

Per-language handles are epistolary and resonance-matched, never translated
(the anchor is the address *to* power). Add a language by coining its handle.
