# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal website/blog built with [Zola](https://www.getzola.org/), a fast static site generator written in Rust. The site is hosted on GitHub Pages and automatically deploys when changes are pushed to the main branch.

## Architecture

- **Static Site Generator**: Zola v0.22.1
- **Theme**: Apollo (via git submodule at `themes/apollo` from https://github.com/not-matthias/apollo)
- **Development Environment**: Nix flakes with direnv integration
- **Content**: Markdown files in `content/` directory with TOML frontmatter
- **Templates**: Tera templates in `templates/` directory (extends/overrides theme templates)
- **Deployment**: GitHub Actions workflow deploys to GitHub Pages on push to main

## Key Commands

### Development
```bash
# Start local development server with live reload
zola serve

# Build the site (output to public/)
zola build

# Check links and validate site without rendering
zola check

# Spell check content (requires codebook)
codebook check
```

### Nix Environment
```bash
# Enter development shell (if direnv not active)
nix develop

# The dev shell provides: zola, codebook, claude-code
```

## Content Structure

Content lives in `content/` with the following organization:
- `content/posts/` - Blog posts with tags taxonomy
- `content/projects/` - Project pages (currently commented out in nav)
- `content/about.md` - About page
- `content/_index.md` - Homepage

### Post Frontmatter Format
```toml
+++
title = "Post Title"
date = "2025-08-29"

[taxonomies]
tags = ["tag1", "tag2"]

[extra]
repo_view = true
comment = true  # Enables Giscus comments
+++
```

## Configuration

- **Site config**: `config.toml` - Main Zola configuration
  - Base URL: https://milanmueller.de
  - Theme: apollo
  - Features: search index, syntax highlighting, MathJax support
- **Spell check**: `codebook.toml` - Custom word dictionary for spell checking
- **Theme**: Uses Apollo theme from submodule, with local template overrides in `templates/`

## Git Submodules

The Apollo theme is included as a git submodule. When cloning or updating:
```bash
git submodule update --init --recursive
```

## Deployment

GitHub Actions workflow (`.github/workflows/main.yml`) automatically builds and deploys to GitHub Pages on every push to main branch using `shalzz/zola-deploy-action@v0.20.0`.

## Custom Features

- Theme toggle support (light/dark mode via `theme = "toggle"` in config)
- MathJax enabled with dollar sign inline math support
- Table of contents enabled globally
- Giscus comments integration (per-page via frontmatter)
- Search functionality with elasticlunr
