---
title: Versioning strategy
status: Active
owner: Release Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [ReleaseManagement.md, GitWorkflow.md, ../Standards/DependencyPolicy.md]
---

# Versioning strategy

How Desktop Frame numbers its releases and its plugin API. The release process that applies these numbers is in [ReleaseManagement.md](ReleaseManagement.md).

## Purpose

Give users and plugin developers a number that tells them, at a glance, whether an upgrade is safe, additive, or breaking.

## Scope

The application version, the plugin API version, and saved-data format versions. Marketing names are out of scope.

## Ownership

The Release Manager assigns versions. A MAJOR bump is a Principal Engineer decision because it implies breaking changes.

## The scheme

Semantic Versioning, `MAJOR.MINOR.PATCH`.

| Part | Increment when |
|---|---|
| MAJOR | A breaking change to the plugin API or a saved-data format that older versions cannot read |
| MINOR | A backward-compatible feature is added |
| PATCH | A backward-compatible bug fix |

Pre-1.0 the same rules apply, with the understanding that the surface is still moving. Pre-release builds carry a suffix: `1.0.0-alpha.1`, `1.0.0-beta.2`, `1.0.0-rc.1`.

## Inputs

- The set of changes since the last release and whether any is breaking.
- The current version.

## Outputs

- The next version number.
- A `vX.Y.Z` git tag at release time.

## Workflow

1. Classify the release: does it break the plugin API or a data format (MAJOR), add features (MINOR), or only fix (PATCH).
2. Compute the next number.
3. Tag at release per [GitWorkflow.md](GitWorkflow.md).

### Plugin API versioning

The plugin API carries its own SemVer, independent of the app version, because a plugin developer cares about API compatibility, not app features. A plugin declares the minimum API version it needs. The app refuses to load a plugin requiring a newer API and warns for a plugin built against a removed API. Deprecations are announced one MINOR before removal and removed only at a MAJOR.

### Data format versioning

Saved layouts, themes, and settings carry a format version. A reader upgrades older formats forward on load. A MAJOR app release may drop support for formats older than a stated floor, documented in the migration guide.

## Required templates

A MAJOR release requires a [../Templates/MigrationGuide.md](../Templates/MigrationGuide.md).

## Required reviews

A MAJOR bump is reviewed and approved by the Principal Engineer. The Release Manager confirms MINOR and PATCH classification.

## Success criteria

A version number correctly predicts upgrade safety. No upgrade that bumped only PATCH or MINOR breaks a user or a plugin.

## KPIs

- Mis-classified releases: a "PATCH" that in fact broke something.
- Plugin breakage across MINOR upgrades, which should be zero.

## Common failure cases

- Shipping a breaking change under a MINOR bump because a MAJOR felt too heavy.
- Versioning the plugin API to the app version, so plugin developers cannot reason about compatibility.
- Forgetting to bump the data format version, so an old reader silently misreads new data.

## Best practices

- Decide MAJOR/MINOR/PATCH at design time, not release time; it tells you whether you are about to break someone.
- Treat the plugin API contract as a promise with a deprecation runway, not a moving target.
