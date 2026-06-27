---
title: Repository folder structure
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../README.md, ../Architecture/FolderStructure.md, NamingConventions.md]
---

# Repository folder structure

Where things live in the repository and the rule for placing a new file. This standard governs the whole repository. The source-tree layout inside `desktop-frame/` is documented separately in the architecture folder structure document; this document covers the top level and the governance folders.

## Top level

| Path | Holds | Canonical reference |
|---|---|---|
| `desktop-frame/` | Application source (Swift, assets) | `Documentation/Architecture/FolderStructure.md` |
| `desktop-frame.xcodeproj/` | Xcode project | — |
| `Documentation/` | Version-controlled docs | [../README.md](../README.md) |
| `Tests/` | Test targets | [SwiftStyleGuide.md](SwiftStyleGuide.md) |
| `Scripts/` | Build and tooling scripts | — |
| `.agents/` | AI agent role definitions | `.agents/AGENTS.md` |
| `.github/` | GitHub community and template files | `.github/` |
| `.templates/` | Non-document scaffolding (file headers, module skeletons) | `.templates/README.md` |
| `.docs/` | Documentation tooling config (lint, link check) | `.docs/README.md` |
| `CLAUDE.md` | Root AI operating rules | [/CLAUDE.md](../../CLAUDE.md) |

## The placement rule

A new file goes in exactly one place, chosen by what it is:

- Source code: under `desktop-frame/` in the folder matching its layer, per the architecture folder structure and [/CLAUDE.md](../../CLAUDE.md) folder responsibilities.
- A document: under `Documentation/` in the folder matching its category, per [../README.md](../README.md).
- An agent role: `.agents/`.
- A GitHub template or community file: `.github/`.
- A document template: `Documentation/Templates/`, never `.templates/`.

If a file seems to fit two places, it belongs with its primary owner; cross-reference from the other place with a link, never a copy.

## Documentation subfolders

The thirteen `Documentation/` subfolders and their purposes are defined once, in [../README.md](../README.md). This document does not repeat them; it points there to keep a single source of truth.

## Review

Folder placement is checked in review and in the quarterly governance audit. A misplaced file is moved, and any link to it updated in the same change.
