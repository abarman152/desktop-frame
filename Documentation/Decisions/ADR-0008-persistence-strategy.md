---
title: ADR-0008 Persistence strategy
status: Accepted
owner: Principal Engineer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-12-27
related: [../Architecture/DataFlow.md, ../Standards/SecurityStandards.md]
---

# ADR-0008: Persistence strategy

## Status

Accepted — 2026-06-27.

## Context

Desktop Frame persists several distinct kinds of state with different shapes and access patterns: small scalar preferences (already in a `UserDefaults` suite via `AppConfiguration`), structured layout documents (widget placement per monitor, themes, wallpaper configuration — keys are already reserved in `AppConstants.Storage`), transient caches (rendered thumbnails, decoded frames, fetched calendar snapshots), and secrets (future cloud-sync tokens). Treating these uniformly forces the wrong trade-off on at least one of them. [SecurityStandards](../Standards/SecurityStandards.md) requires data stay on device by default and that only what is needed is stored.

## Problem

Which storage mechanism owns each class of persisted state, so each gets the right durability, query, and migration characteristics without over-engineering the simple cases?

## Alternatives considered

1. **Everything in `UserDefaults`.** Trivial, but wrong for large layout documents and caches (it loads wholesale into memory and is not meant for blobs), and it has no schema/migration story.
2. **Everything in SwiftData/Core Data.** One model and migration story, but heavyweight for scalar prefs and for caches that should be disposable, and it couples disposable data to the durable store.
3. **A bespoke file format for layouts.** Full control, but re-implements serialization, versioning, and atomic writes that the platform already provides.
4. **A tiered split by data class.** Each class uses the mechanism built for it.

## Decision

Persist by data class:

- **Preferences (scalars, toggles):** `UserDefaults` suite (`com.desktopframe.preferences`), via `AppConfiguration`. Already in place.
- **Layout documents (widget layouts, themes, wallpaper config, monitor map):** `Codable` value types written as JSON files under Application Support, atomic writes, an explicit `schemaVersion` field per document for migration. Keys/identifiers stay coordinated with `AppConstants.Storage`.
- **Caches (thumbnails, decoded assets, fetched snapshots):** the system `Caches` directory, treated as disposable and rebuildable; never the source of truth.
- **Secrets (future sync tokens, credentials):** Keychain only, never `UserDefaults` or files.

SwiftData is reserved for a future feature that needs relational queries over a large item set (e.g., a marketplace library); it is not adopted for v1 layout persistence. Decided by the founding engineering team.

## Trade-offs

Four mechanisms mean four code paths and a rule for which to use, rather than one store. We accept that because forcing scalar prefs, large documents, disposable caches, and secrets into one mechanism mis-serves at least three of them, and the boundaries here are stable and easy to state.

## Consequences

- Layout documents carry `schemaVersion`; a load path that meets an older version migrates forward (see [DataFlow](../Architecture/DataFlow.md)); the migration is tested.
- The invariant **caches are never the source of truth** is owned here; losing the cache directory must degrade gracefully, never lose user layout.
- Anything leaving the device (sync) is escalated to a human per [SecurityStandards](../Standards/SecurityStandards.md) and gets its own ADR.
- A document version bump that is not backward-compatible is a migration with a [MigrationGuide](../Templates/MigrationGuide.md) if it ships in a MAJOR release.

## References

1. Apple, "UserDefaults." https://developer.apple.com/documentation/foundation/userdefaults
2. Apple, "Keychain services." https://developer.apple.com/documentation/security/keychain-services
3. Apple, "File system programming — the Caches directory." https://developer.apple.com/documentation/foundation/filemanager
