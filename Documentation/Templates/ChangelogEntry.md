---
title: Changelog entry guidance
status: Active
owner: Release
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Changelog entry. The project keeps a single CHANGELOG following the
Keep a Changelog convention. This file is the guidance and the per-entry shape.
Add entries as you merge, not at release time.
-->

# Changelog entry guidance

Entries are grouped under an unreleased heading until a version ships, then moved under the version and date. Use these categories, in this order, omitting empty ones:

```
## [Unreleased]

### Added
- New user-facing capability.

### Changed
- Change to existing behavior.

### Deprecated
- Soon-to-be-removed capability, with the removal version.

### Removed
- Removed capability.

### Fixed
- Bug fix.

### Security
- Security-relevant change.
```

Writing guidance: one line per change, user-facing language, imperative mood. Link the issue or PR. A breaking change is marked and linked to the migration guide.

## Completion checklist
- [ ] Entry under the correct category.
- [ ] User-facing, one line, issue linked.
- [ ] Breaking changes marked.

## Review checklist
- [ ] Reads clearly to a user.
- [ ] Matches what shipped.
