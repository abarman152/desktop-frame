---
title: Documentation hub
status: Active
owner: Documentation Lead
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../CLAUDE.md, ../.agents/AGENTS.md, Standards/DocumentationStandards.md, Processes/NotionOperatingSystem.md]
---

# Desktop Frame documentation hub

This is the navigation hub for the entire repository's knowledge base. Everything that must evolve with the code lives here in Git. Living project management lives in Notion. This page explains the structure, the governance hierarchy, who owns what, and where to find every document.

## The rule: Git versus Notion

Git holds documentation that must be reviewed, versioned, and kept in lockstep with the code: architecture, standards, decisions, specifications. Notion holds documentation that changes daily and does not need code review: tasks, sprints, roadmap, ideas, meeting notes, research, progress. No architecture or engineering decision exists only in Notion. Every such decision is an ADR here, mirrored in the Notion Documentation Index. The full split and the synchronization rules are in [Processes/NotionOperatingSystem.md](Processes/NotionOperatingSystem.md).

## Governance hierarchy

When two documents conflict, the higher level wins, except that a more specific document wins within its own domain.

1. The constitution: [/CLAUDE.md](../CLAUDE.md). Always applies, to humans and AI agents.
2. Standards and processes: [Standards/](Standards) and [Processes/](Processes). The enforceable rules and the ways of working.
3. Templates: [Templates/](Templates). The shape every new document takes.
4. Agent roles: [/.agents/](../.agents/AGENTS.md). Job descriptions that apply on top of the constitution when an agent does that job.

## Directory map

### Documentation subfolders

| Folder | Holds | Owner |
|---|---|---|
| [Architecture/](Architecture) | System and subsystem design, data flow, the window and rendering architecture | Principal Engineer |
| [Product/](Product) | Product docs engineering depends on; source of truth for strategy is Notion | Product |
| [Engineering/](Engineering) | Engineering notes that are not standards or processes: known limitations, investigations | Principal Engineer |
| [Development/](Development) | Developer guides: setup, build, debugging, local workflows | Staff Engineer |
| [Design/](Design) | Design system, HIG working notes, UI specs that ship with code | Product Designer |
| [Decisions/](Decisions/README.md) | Architecture Decision Records, one immutable file per decision | Principal Engineer |
| [Processes/](Processes) | How we work: git, sprints, bugs, releases, quality, Notion | Engineering Manager |
| [Standards/](Standards) | Enforceable rules: documentation, code, naming, security, performance, accessibility | Principal Engineer |
| [Templates/](Templates) | Canonical Markdown templates every new document copies from | Documentation Lead |
| [API/](API) | Public plugin and SDK API reference | Staff Engineer |
| [Releases/](Releases) | Release notes, migration guides, version history | Release Manager |
| [Research/](Research) | Engineering research: spikes, benchmarks, prior-art write-ups | Principal Engineer |
| [References/](References) | Curated external references: Apple docs, WWDC notes, prior art | Anyone |

### Repository-level governance folders

| Folder | Holds | Entry point |
|---|---|---|
| [/.agents/](../.agents/AGENTS.md) | AI agent role definitions | `AGENTS.md` |
| [/.github/](../.github) | GitHub community and template files | issue/PR templates, `SECURITY.md`, `CONTRIBUTING.md` |
| [/.templates/](../.templates/README.md) | Non-document code scaffolding | `README.md` |
| [/.docs/](../.docs/README.md) | Documentation tooling config | `README.md` |
| [/CLAUDE.md](../CLAUDE.md) | Root AI operating rules | the constitution |

## Document index

### Processes

[GitWorkflow](Processes/GitWorkflow.md) · [SprintManagement](Processes/SprintManagement.md) · [BugManagement](Processes/BugManagement.md) · [DocumentationLifecycle](Processes/DocumentationLifecycle.md) · [QualityGates](Processes/QualityGates.md) · [ReleaseManagement](Processes/ReleaseManagement.md) · [VersioningStrategy](Processes/VersioningStrategy.md) · [NotionOperatingSystem](Processes/NotionOperatingSystem.md) · [ProjectLifecycle](Processes/ProjectLifecycle.md) · [RiskManagement](Processes/RiskManagement.md) · [ChangeManagement](Processes/ChangeManagement.md) · [IncidentManagement](Processes/IncidentManagement.md) · [CommunicationGuidelines](Processes/CommunicationGuidelines.md)

### Standards

[DocumentationStandards](Standards/DocumentationStandards.md) · [DocumentationStyleGuide](Standards/DocumentationStyleGuide.md) · [SwiftStyleGuide](Standards/SwiftStyleGuide.md) · [CodeStyle](Standards/CodeStyle.md) · [NamingConventions](Standards/NamingConventions.md) · [FolderStructure](Standards/FolderStructure.md) · [BranchingStrategy](Standards/BranchingStrategy.md) · [CommitConvention](Standards/CommitConvention.md) · [ReviewChecklist](Standards/ReviewChecklist.md) · [PerformanceStandards](Standards/PerformanceStandards.md) · [SecurityStandards](Standards/SecurityStandards.md) · [AccessibilityStandards](Standards/AccessibilityStandards.md) · [DependencyPolicy](Standards/DependencyPolicy.md)

### Decisions

[ADR system](Decisions/README.md) · [ADR-0000 Record architecture decisions](Decisions/ADR-0000-record-architecture-decisions.md)

### Templates

The template library in [Templates/](Templates) covers architecture, technical spec, PRD, feature spec, epic, user story, research report, competitive analysis, meeting notes, the sprint set, daily log, bug report, incident report, root cause analysis, performance report, security review, API doc, plugin spec, UI spec, UX research, testing report, release notes, migration guide, changelog entry, decision record, and design proposal.

### Agent roles

The fifteen roles are indexed in [/.agents/AGENTS.md](../.agents/AGENTS.md), which also defines the nine-phase task workflow with exit gates.

## Documentation update responsibilities

Documentation is updated by the change that makes it inaccurate, in the same pull request, never in a follow-up. The triggers (before implementation, during, after, before and after release, during refactoring, after architecture changes) and the status lifecycle are defined in [Processes/DocumentationLifecycle.md](Processes/DocumentationLifecycle.md). Each document names an `owner` in its frontmatter, accountable for its accuracy. The Documentation Lead runs the quarterly review and keeps the Notion Documentation Index in sync.

## How to add a document

1. Copy the matching file from [Templates/](Templates).
2. Fill the frontmatter and every required section per [Standards/DocumentationStandards.md](Standards/DocumentationStandards.md).
3. Place it in the correct folder from the map above.
4. Add a row to the Notion Documentation Index linking back to it.
5. Open a pull request. Documentation is reviewed like code, against [Standards/ReviewChecklist.md](Standards/ReviewChecklist.md).

## Migration note

Four documents predate this hierarchy and sit at the `Documentation/` root: `Architecture.md`, `CodingStandards.md`, `DevelopmentSetup.md`, and `FolderStructure.md`. They migrate to `Architecture/Architecture.md`, `Architecture/FolderStructure.md`, and `Development/DevelopmentSetup.md`. The Swift content of the old `CodingStandards.md` is superseded by [Standards/SwiftStyleGuide.md](Standards/SwiftStyleGuide.md). Because the Notion Documentation Index links to the current paths, each move and its Index update happen in the same change so no link breaks. Until a file is moved, its root copy is canonical.
