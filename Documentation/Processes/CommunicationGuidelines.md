---
title: Communication guidelines
status: Active
owner: Engineering Manager
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [NotionOperatingSystem.md, ../README.md, DocumentationLifecycle.md]
---

# Communication guidelines

Where information goes and how it is written, so that humans and AI agents working across Git and Notion can find what they need and trust what they read.

## Purpose

Make communication legible and durable. The right information in the right place, written plainly, so a contributor or agent arriving cold can orient themselves.

## Scope

All project communication that should persist: decisions, specifications, status, research, and discussion. Ephemeral chatter is out of scope and should not carry decisions.

## Ownership

The Engineering Manager owns these guidelines. Every contributor owns putting their information in the right place.

## Where information lives

| Information | Home | Why |
|---|---|---|
| Architecture, standards, decisions, specs | Git (`Documentation/`) | Versioned with the code, reviewed |
| Tasks, sprints, roadmap, ideas, meeting notes | Notion | Living project management |
| Defects and feature requests from outside | GitHub Issues | Public, linkable, triable |
| Decisions | ADRs in Git, mirrored in Notion index | Durable and discoverable |
| Day-to-day progress | Notion Daily Development Log | Lightweight, time-ordered |

The split is defined in [../README.md](../README.md) and [NotionOperatingSystem.md](NotionOperatingSystem.md). A decision recorded only in chat does not exist.

## Writing standards

- Write for a reader who lacks your context. State the situation before the conclusion.
- Be specific. "Reduced idle CPU from 1.2% to 0.4%" beats "improved performance."
- Distinguish verified fact, inference, and opinion, the same convention the documentation uses.
- Prefer plain sentences over jargon and decoration. The [anti-AI writing standard](../Standards/DocumentationStyleGuide.md) applies to all written artifacts.

## Status communication

- Progress and blockers go in the Daily Development Log, asynchronously.
- A blocker older than a day is escalated, not left in the log.
- Sprint status is the Sprint Tracker, not a separate report.

## Inputs and outputs

Input: information produced anywhere in the workflow. Output: that information placed in its correct home, written to the standard, and linked from where people will look.

## Required templates

[../Templates/MeetingNotes.md](../Templates/MeetingNotes.md) for any meeting that produces decisions or actions.

## Required reviews

Documents that live in Git are reviewed in their pull request. Notion content is reviewed in the weekly and monthly cycles per [NotionOperatingSystem.md](NotionOperatingSystem.md).

## Success criteria

A contributor or agent can find any decision, spec, or status in the place these guidelines predict, written clearly enough to act on.

## KPIs

- Findability: information located in its predicted home rather than reconstructed from chat.
- Decisions captured as ADRs versus lost in conversation.

## Common failure cases

- Decisions made in chat and never written down.
- The same information duplicated in Git and Notion, drifting out of sync. Link, do not copy.
- Status scattered across channels instead of the one log.

## Best practices

- Decide where information belongs before writing it, using the table above.
- Link to the canonical source instead of pasting a copy.
- Write meeting outcomes as decisions and actions with owners, not as a transcript.
