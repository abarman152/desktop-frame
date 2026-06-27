---
title: <plugin or capability> specification
status: Draft
owner: Staff Engineer
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Plugin specification. For a plugin SDK capability or a sample plugin.
Follows ../Standards/DocumentationStandards.md. The plugin platform is a later-
stage goal; specs written now must respect the public-API and sandbox rules.
-->

# <plugin or capability> specification

## Purpose

What the plugin or capability does and the user value.

## Plugin surface

The API the plugin uses, the API version required, and the lifecycle (load, update, teardown).

## Sandbox and permissions

What the plugin may and may not access. Plugins run under the same on-device, least-privilege, public-API rules as the app per ../Standards/SecurityStandards.md.

## Performance constraints

The budget a plugin must stay within so it cannot make the Mac feel slow. A misbehaving plugin is contained.

## Distribution

How the plugin is packaged, versioned, and distributed through the marketplace.

## Completion checklist
- [ ] Plugin surface and required API version stated.
- [ ] Sandbox, permissions, and performance limits defined.
- [ ] Distribution and versioning described.

## Review checklist
- [ ] Respects the public-API and sandbox rules.
- [ ] Performance containment is enforceable.
- [ ] Meets DocumentationStandards.
