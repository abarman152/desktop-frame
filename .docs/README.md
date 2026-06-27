# .docs

Tooling configuration for the documentation system. The documentation itself lives in `Documentation/`; this folder holds the machinery that keeps it healthy.

## What belongs here

- Markdown lint configuration (heading case, line rules) enforcing [DocumentationStandards](../Documentation/Standards/DocumentationStandards.md).
- Link-check configuration for the internal-link verification run in CI and the quarterly audit.
- Any documentation-site or generator configuration, should the project publish its docs.

## What does not belong here

- Documentation content. That is `Documentation/`.
- Build or app tooling. That is `Scripts/`.

## Purpose

These tools turn the documentation standards from rules people remember into checks that run automatically. A Markdown file that violates the heading or link rules should fail a check here, not slip through review.
