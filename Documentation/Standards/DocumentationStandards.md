---
title: Documentation standards
status: Active
owner: Documentation Lead
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [README.md, ../Templates, ../../CLAUDE.md]
---

# Documentation standards

These rules govern every Markdown file in the repository. They are enforceable in review. A document that violates them does not merge.

## File naming

- Use `PascalCase.md` for standalone documents: `WindowSystem.md`, `RenderingEngine.md`.
- Use the `ADR-NNNN-kebab-title.md` form only for decision records: `ADR-0007-actor-isolated-services.md`.
- Use `UPPER_SNAKE.md` only for agent and root convention files: `CLAUDE.md`, `SWIFT_ENGINEER.md`.
- No spaces, no dates in filenames. Dates live in frontmatter.

## Folder placement

Every document goes in exactly one folder, chosen by the table in [README.md](../README.md). If a document seems to fit two folders, it belongs in the one matching its primary owner. Cross-reference from the other folder with a link, never a copy.

## Required frontmatter

Every document opens with YAML frontmatter:

```yaml
---
title: Human-readable title
status: Draft | Active | Deprecated | Superseded
owner: Role or name accountable for accuracy
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: [list, of, linked, documents]
---
```

`status` drives the lifecycle in [../Processes/DocumentationLifecycle.md](../Processes/DocumentationLifecycle.md). `review_by` is set to ninety days out by default and is how stale documents are found.

## Heading hierarchy

- One `#` H1 per file, matching the frontmatter title.
- Sections use `##`, subsections `###`. Do not skip levels.
- Headings are sentence case: "How the scoring works", not "How The Scoring Works".
- Headings describe content, not importance. No "Important notes" or "Overview of the critical system".

## Required sections

The minimum sections depend on document type and are defined by the matching template in `Templates/`. Every document, whatever its type, ends with no summary section. End on the last useful content. A document that needs a recap is too long or badly ordered.

## Cross-linking

- Link to other documents by relative path, not absolute URL.
- The first time a document mentions a concept defined elsewhere, link it.
- Link to the canonical source, never to a copy.
- When a document is superseded, the new document links back to the old, and the old sets `status: Superseded` with a forward link.

## References

- External claims that matter carry a numbered reference with a URL in a `## References` section.
- Tag non-obvious claims as verified, inference, or judgment, the same convention the Product documentation uses.
- Never cite "experts say" or "studies show" without naming the source.

## Code blocks

- Fence every code block with its language: ```swift, ```bash, ```yaml.
- Code in documentation must compile or run as shown, or be marked with a comment that it is illustrative.
- Keep examples minimal. Show the pattern, not a whole file.

## Diagrams

- Prefer text-describable diagrams (ASCII or Mermaid) so they version and diff in Git.
- Every diagram has a one-line caption stating what it shows.
- A diagram that cannot be expressed in text (a rendered mockup) is linked, with the source file committed under the relevant folder.

## Update frequency and review

- A document is updated in the same pull request as the code change that makes it inaccurate. See [../Processes/DocumentationLifecycle.md](../Processes/DocumentationLifecycle.md).
- `review_by` is checked in a quarterly documentation review. Anything past its date is re-verified or deprecated.
- Standards and ADRs are reviewed by the Principal Engineer. Process docs by the Engineering Manager.

## Version history

Documents do not keep an inline changelog. Git history is the version history. The `updated` field records the last substantive change. ADRs are the exception: they are immutable after acceptance, and change only via a superseding ADR.

## Ownership

Every document has one `owner`. The owner is accountable for accuracy, not necessarily the author. Ownership transfers explicitly by editing the frontmatter in a reviewed change.

## Example

A minimal valid document:

```markdown
---
title: Storage architecture
status: Active
owner: Principal Engineer
created: 2026-07-01
updated: 2026-07-01
review_by: 2026-10-01
related: [DataFlow.md]
---

# Storage architecture

Desktop Frame persists three kinds of state: settings, layouts, and caches.

## Settings

Settings live in a dedicated UserDefaults suite ...

## References

1. Apple, "UserDefaults." https://developer.apple.com/documentation/foundation/userdefaults
```
