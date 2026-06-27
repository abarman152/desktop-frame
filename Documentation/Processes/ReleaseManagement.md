---
title: Release management
status: Active
owner: Release Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [VersioningStrategy.md, GitWorkflow.md, QualityGates.md, ../Templates/ReleaseNotes.md, ../Templates/MigrationGuide.md, ../Templates/ChangelogEntry.md]
---

# Release management

How a verified set of changes becomes a signed, notarized, documented release. Versioning rules are in [VersioningStrategy.md](VersioningStrategy.md); git mechanics in [GitWorkflow.md](GitWorkflow.md).

## Purpose

Ship releases that are stable, signed, reproducible, and documented, so users upgrade with confidence and the team can support what it shipped.

## Scope

Every public build: alpha, beta, release candidate, and stable. Internal development builds are out of scope.

## Ownership

The Release Manager (the `RELEASE_AGENT.md` role for AI-driven work) owns the process and the go/no-go recommendation. The final go/no-go on a stable release is a human decision.

## Inputs

- A `main` that has passed the [QualityGates.md](QualityGates.md) for every included change.
- The target version from [VersioningStrategy.md](VersioningStrategy.md).
- An Apple Developer ID and notarization credentials.

## Outputs

- A tagged, signed, notarized build.
- Release notes ([../Templates/ReleaseNotes.md](../Templates/ReleaseNotes.md)).
- A migration guide when there are breaking changes ([../Templates/MigrationGuide.md](../Templates/MigrationGuide.md)).
- An updated changelog and Notion Release History entry.

## Workflow

1. Decide the version per [VersioningStrategy.md](VersioningStrategy.md).
2. Stabilize. For a significant release, cut a `release/x.y` branch and allow only fixes onto it.
3. Run the release checklist (below).
4. Build a Release configuration; sign with Developer ID; notarize with Apple; staple the ticket.
5. Tag `vX.Y.Z` on the merge commit, annotated.
6. Write release notes and, if needed, the migration guide.
7. Update the changelog and the Notion Release History.
8. Publish, then verify the published artifact downloads and launches clean.

### Release checklist

- [ ] All planned changes merged and passing the quality gates.
- [ ] No open Critical or High bugs.
- [ ] Regression checklist passed.
- [ ] Performance budget verified with Instruments.
- [ ] Version and build numbers bumped.
- [ ] Signed, notarized, stapled.
- [ ] Release notes and, if needed, migration guide written.
- [ ] Changelog and Notion Release History updated.
- [ ] Published artifact verified after upload.

### Hotfix release

A production-affecting defect follows the hotfix flow in [GitWorkflow.md](GitWorkflow.md): branch from the release tag, fix with a regression test, tag a PATCH, merge back to `main`. A hotfix for a user-facing incident also runs [IncidentManagement.md](IncidentManagement.md).

## Required templates

[../Templates/ReleaseNotes.md](../Templates/ReleaseNotes.md), [../Templates/MigrationGuide.md](../Templates/MigrationGuide.md), [../Templates/ChangelogEntry.md](../Templates/ChangelogEntry.md).

## Required reviews

The Release Manager confirms the checklist. A human approves go/no-go for stable releases. Breaking changes require Principal Engineer sign-off on the migration guide.

## Success criteria

A release installs and runs clean on the supported matrix, its notes match what shipped, and no Critical regression reaches users.

## KPIs

- Release frequency and predictability against plan.
- Rollback or hotfix rate within the first week of a release.
- Notarization and signing failures caught before publish, not after.

## Common failure cases

- Shipping with an open High bug "to be fixed next release," which becomes a support burden.
- Release notes that describe intent rather than what actually shipped.
- Skipping the post-publish verification, so a broken upload reaches users.

## Best practices

- Keep `main` releasable so a release is a tag and a checklist, not a scramble.
- Automate signing and notarization in CI to remove manual error.
- Write the changelog as you merge, not at release time.
