---
title: Code style
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [SwiftStyleGuide.md, NamingConventions.md, DocumentationStyleGuide.md]
---

# Code style

The umbrella entry point for how code and prose are written in this repository. It does not restate the rules; it points to the canonical documents so there is one source for each.

## Swift

All Swift code follows [SwiftStyleGuide.md](SwiftStyleGuide.md). That document is canonical for language use, concurrency, state, safety, structure, and idioms.

## Naming

All names follow [NamingConventions.md](NamingConventions.md), across code, files, branches, and commits.

## Documentation prose

All Markdown follows [DocumentationStyleGuide.md](DocumentationStyleGuide.md) for writing style and [DocumentationStandards.md](DocumentationStandards.md) for structure and metadata.

## Formatting

Swift is formatted with the project's `swift-format` configuration before commit. Formatting is mechanical and not a matter of review opinion; the configuration is the authority. The config lives at the repository root and its rules are not duplicated here.

## Why this document exists

A contributor or agent looking for "the style guide" finds this page and is routed to the right canonical document, rather than finding several overlapping ones. When a new style domain appears, add a pointer here, not a second copy of the rules.
