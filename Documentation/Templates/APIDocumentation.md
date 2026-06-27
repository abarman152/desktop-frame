---
title: <API name> reference
status: Draft
owner: Staff Engineer
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: API documentation. Copy to Documentation/API/. For the public plugin and
SDK surface. Follows ../Standards/DocumentationStandards.md. Every example must
compile or be marked illustrative.
-->

# <API name> reference

## Overview

What this API is for and who uses it. The API version it belongs to per ../Processes/VersioningStrategy.md.

## Concepts

The model a caller needs: the key types, their roles, and how they fit together.

## Reference

Each public type and member: signature, purpose, parameters, return, errors, and concurrency expectations (actor isolation, `Sendable`).

## Examples

Minimal, working examples of the common cases.

## Stability and deprecation

The compatibility promise, and any deprecated members with their removal version.

## Completion checklist
- [ ] Every public member documented with errors and concurrency.
- [ ] Examples compile or are marked illustrative.
- [ ] API version and stability stated.

## Review checklist
- [ ] Matches the shipped API surface.
- [ ] Deprecations carry a removal version.
- [ ] Meets DocumentationStandards.
