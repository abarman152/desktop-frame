---
title: ADR-0010 Widget configuration schema and versioning
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [../Architecture/WidgetEngine.md, ADR-0008-persistence-strategy.md, ../Processes/VersioningStrategy.md]
---

# ADR-0010: Widget configuration schema and versioning

## Status

Accepted — 2026-06-27.

## Context

Widgets are configurable (a clock's timezone, a CPU graph's window, a calendar's source set) and their configuration is persisted as part of a layout document ([ADR-0008](ADR-0008-persistence-strategy.md)). Once third parties ship widgets through the marketplace, a widget's configuration schema becomes a contract between three independently versioned things: the host app, the installed plugin, and the user's saved data. [VersioningStrategy](../Processes/VersioningStrategy.md) already establishes independent SemVer for app, plugin API, and data format. Without a defined config schema and migration rule, a widget update or an app update silently corrupts or discards user configuration.

## Problem

How is a widget's configuration described, validated, persisted, and migrated across widget and app versions, so an update never silently loses or breaks a user's widget settings?

## Alternatives considered

1. **Free-form dictionary, no schema.** Maximum flexibility, no safety: the host cannot validate, migrate, or render a settings UI, and a typo becomes silent data loss.
2. **Host-defined fixed schema per widget type.** Safe for first-party widgets, but cannot accommodate third-party widgets the host does not know at build time.
3. **A typed, declarative, versioned config schema each widget publishes**, validated by the host, with a per-widget migration hook between schema versions.

## Decision

Each widget declares a **typed, versioned configuration schema**: a set of named, typed fields (with defaults, ranges, and display metadata) and a `configSchemaVersion`. The host validates persisted configuration against the declared schema on load, applies defaults for missing fields, and invokes the widget's migration hook when the persisted `configSchemaVersion` is older than the installed widget's. Configuration is `Codable` and persists inside the layout document. The schema also drives an auto-generated settings UI, so a widget gets a configuration panel without shipping bespoke UI. Decided by the founding engineering team.

## Trade-offs

A declarative schema is less flexible than an open dictionary and asks widget authors to describe their fields and write migrations. We accept that constraint because it is the only way the host can validate, migrate, and render configuration for widgets it did not author, which is exactly the marketplace case. The auto-generated settings UI repays much of the authoring cost.

## Consequences

- The [WidgetEngine](../Architecture/WidgetEngine.md) owns schema validation, default application, and migration invocation on load.
- A widget update that changes its schema bumps `configSchemaVersion` and ships a migration; an un-migratable change is a breaking change handled per [VersioningStrategy](../Processes/VersioningStrategy.md).
- Invalid or unmigratable configuration falls back to defaults and surfaces a non-destructive notice; it never crashes the widget or drops the layout. Named invariant.
- The plugin SDK exposes the schema type as part of its public, versioned contract ([PluginSDK](../Architecture/PluginSDK.md)).

## References

1. Apple, "Codable." https://developer.apple.com/documentation/swift/codable
2. [VersioningStrategy](../Processes/VersioningStrategy.md).
