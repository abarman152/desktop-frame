---
title: Notion operating system
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../README.md, CommunicationGuidelines.md, SprintManagement.md, DocumentationLifecycle.md, ../Decisions/README.md]
---

# Notion operating system

The complete guide to running the Desktop Frame Notion workspace and keeping it in sync with the Git repository. Notion holds living project management; Git holds version-controlled engineering truth. This document defines how the two stay coherent.

## The governing rule

Notion contains work that changes daily and does not need code review: tasks, sprints, roadmap, ideas, meeting notes, research, progress. Git contains work that must be reviewed and versioned with the code: architecture, standards, decisions, specifications. No architecture or engineering decision exists only in Notion. Every such decision is an ADR in Git, mirrored in the Notion Engineering index. The split is summarized in [../README.md](../README.md) and [CommunicationGuidelines.md](CommunicationGuidelines.md).

## Workspace architecture

The workspace is one top-level page, Desktop Frame, with fourteen sections: Home, Product, Design, Engineering, Development, QA & Testing, Sprint Planning, Roadmap, Meeting Notes, Ideas, Analytics, Releases, References, and the Documentation Index. Home is the dashboard. The Documentation Index maps every Git `/Documentation` file to its purpose and is the bridge between the two systems.

## Databases and their relationships

Thirteen databases carry the structured work. Their identifiers are recorded in the project memory and the root page.

| Database | Section | Holds | Relates to |
|---|---|---|---|
| Epic Tracker | Development | Large bodies of work | Parents Features and Tasks |
| Feature Tracker | Development | Individual features | Belongs to an Epic; spawns Tasks |
| Task Tracker | Development | Day-to-day work items | Belongs to a Feature; pulled into a Sprint |
| Sprint Tracker | Sprint Planning | Two-week sprints | Contains Tasks |
| Bug Tracker | Development | Defects | May link to a Task and a Release |
| Architecture Decision Records | Engineering | Decision index | Mirrors Git ADRs |
| Risk Register | Engineering | Tracked risks | May spawn Incidents |
| Dependency Registry | Engineering | Dependencies | Governed by DependencyPolicy |
| Meeting Notes | Meeting Notes | Meeting outcomes | Links decisions and actions |
| Ideas | Ideas | Raw and explored ideas | Promotes to Feature or Research |
| Research | References | Research write-ups | Informs Decisions and Features |
| Release History | Releases | Releases | Aggregates Features and Bugs |
| Technical Debt | Development | Known debt | Links to Tasks |

The hierarchy of work:

```
Roadmap milestone
  └─ Epic
       └─ Feature
            └─ Task ── pulled into ── Sprint
                 └─ Bug (when a defect is found)
```

## Workflows

### Sprint workflow

Run per [SprintManagement.md](SprintManagement.md). In Notion: planning pulls Tasks from the backlog into the active Sprint; the Sprint Tracker records goal, capacity, and completed points; review and retrospective records are written at sprint close. Velocity is read from completed points across sprints.

### Roadmap management

The Roadmap section holds the milestone pages (MVP, v0.1, v0.2, v0.5, v1.0, future). Each Epic names its target version. Quarterly planning selects milestones; monthly review reconciles the roadmap against delivered work. The roadmap is reconciled with reality, not aspirational.

### Feature lifecycle

An idea in the Ideas database is validated through Research, specified as a Feature with acceptance criteria, broken into Tasks, built across Sprints, and shipped in a Release. The Feature's status moves Backlog, Planned, In Progress, Review, Testing, Completed, Released, matching the [ProjectLifecycle.md](ProjectLifecycle.md) stages.

### Bug lifecycle

Per [BugManagement.md](BugManagement.md). A Bug Tracker entry moves Reported, Confirmed, In Progress, Review, Testing, Fixed, Closed. Critical and High bugs link to a root cause analysis. A bug fixed in a release links to that Release History entry.

### Research workflow

A question becomes a Research entry with a source list and key takeaways. Research that supports a decision is linked from the ADR. Research informs Features; it does not authorize building on its own.

### Meeting workflow

Every meeting that produces a decision or an action is captured in the Meeting Notes database using the meeting-notes template: attendees, summary, decisions, actions with owners. Decisions of architectural weight are promoted to ADRs in Git.

### Decision workflow

A technical decision is written as an ADR in Git ([../Decisions/README.md](../Decisions/README.md)) and mirrored as a row in the Notion ADR database for visibility. The Git file is canonical; the Notion row links to it. Product decisions that are not architectural live in the Product section.

### Daily workflow

Each contributor records progress and blockers in the Daily Development Log. Blockers older than a day escalate. The log is lightweight and time-ordered, not a status report.

## Review cadence

```
Daily     → progress and blockers in the Daily Development Log
Weekly    → review open Tasks, blockers, and sprint burn; groom the backlog
Monthly   → reconcile roadmap vs delivery; review Risk Register and open actions
Quarterly → plan the next quarter's milestones from the Roadmap; review stale docs
```

- Weekly review: the team checks sprint progress, clears blockers, and refines the next sprint's candidates.
- Monthly review: roadmap accuracy, risks, technical debt, and prevention actions from incidents.
- Quarterly planning: select milestones, size against capacity, and run the documentation review from [DocumentationLifecycle.md](DocumentationLifecycle.md).

## Archive strategy

Completed and abandoned items are archived, not deleted, so history survives. A Task, Bug, or Sprint reaching a terminal state is set to its archived status and stays queryable. Ideas that are rejected keep a reason. Superseded research is marked, not removed. The archive is the project's memory; it is never purged.

## Synchronization with Git

```
Notion (living PM)                         Git (versioned truth)
─────────────────                          ────────────────────
Task / Feature / Epic    ── reference ──▶  branch, PR, commit (issue link)
ADR database row         ── mirrors  ──▶   Documentation/Decisions/ADR-*.md (canonical)
Documentation Index      ── maps     ──▶   Documentation/**/*.md
Release History          ── mirrors  ──▶   git tag + Releases notes
```

Rules of synchronization:

- Git is canonical for anything it holds. Notion links to the Git file; it never holds the only copy.
- When a repository document is added or moved, the Documentation Index row is updated in the same change.
- An ADR is written in Git first, then mirrored as a Notion row that links to it.
- A release is tagged in Git and recorded in Release History; the two must agree.

## Synchronization with GitHub Issues

External bug reports and feature requests arrive as GitHub Issues using the templates in `.github/`. Triage decides whether an Issue becomes a Notion Bug Tracker or Feature Tracker entry. The Notion entry links to the Issue; the Issue links back. GitHub is the public front door; Notion is the internal planning surface. A fix references the Issue in its commit and closes it on merge.

## Documentation ownership

Every Git document names an owner in frontmatter. Every Notion database has an owning role: Development databases by the Engineering Manager, Engineering databases by the Principal Engineer, Product by Product, Research and References by whoever curates them. The Documentation Lead owns the Index and the sync discipline.

## Common failure cases

- Information duplicated in Notion and Git, drifting apart. Link, do not copy.
- The Documentation Index going stale because a doc was added without updating it.
- Decisions captured in Notion only, where they are mutable and unreviewed.
- Archives purged to "tidy up," destroying the project's memory.

## Best practices

- Treat the Documentation Index as the single list of what repository documentation exists, and keep it current with every doc change.
- Run the weekly, monthly, and quarterly reviews on fixed dates so the workspace never rots.
- Keep Git canonical and Notion referential; the moment they disagree, Git wins and Notion is corrected.
