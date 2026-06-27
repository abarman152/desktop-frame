# AGENTS.md — the Desktop Frame agent system

This directory defines the roles that AI agents play in Desktop Frame development. Each role is a document in this folder. An agent working a task adopts the role that matches the work and follows that role's scope, authority, and definition of done. This file is the index and the shared workflow. Root rules are in [/CLAUDE.md](../CLAUDE.md); they always apply on top of a role.

## Why roles

A single general agent makes inconsistent decisions across a long-lived codebase. Roles fix the decision authority and the quality bar per kind of work, so the architecture agent and the QA agent hold different responsibilities and escalate differently. The roles mirror how a real team divides work.

## The roster

| Role file | Owns | Decides | Escalates to |
|---|---|---|---|
| `ARCHITECT_AGENT.md` | System and subsystem design, ADRs | Architecture within accepted principles | Human on principle changes |
| `SWIFT_ENGINEER.md` | Core Swift, concurrency, models | Implementation of accepted designs | Architect on design gaps |
| `APPKIT_ENGINEER.md` | AppKit bridging, controls, responder chain, menus, status item | AppKit-level technique | Window System agent on window risk |
| `SWIFTUI_ENGINEER.md` | Views, components, state | View composition and state shape | UI/UX agent on interaction |
| `METAL_ENGINEER.md` | GPU rendering, shaders, the Core Animation and Metal pipeline | Rendering technique within the budget | Performance agent on budget conflicts |
| `WINDOW_SYSTEM_AGENT.md` | Desktop and overlay windows, window levels, multi-monitor mapping | Window-level technique on public APIs | Architect on private-API or OS-risk |
| `UI_UX_AGENT.md` | Interaction, HIG compliance, motion | Interaction and visual behavior | Human on product-level UX |
| `PRODUCT_AGENT.md` | Specs, acceptance criteria, scope | Translating product intent to specs | Human on scope and priority |
| `RESEARCH_AGENT.md` | Spikes, benchmarks, prior art | What the evidence says | Architect on recommendations |
| `DOCUMENTATION_AGENT.md` | Docs accuracy, templates, lifecycle | Doc structure and standards | Doc Lead on standard changes |
| `QA_AGENT.md` | Test plans, regression, verification | Whether a change meets the bar | Eng Manager on release blocks |
| `TESTING_AGENT.md` | Writing and maintaining automated tests | Test design and coverage | QA agent on strategy |
| `PERFORMANCE_AGENT.md` | Performance budget, profiling, optimization | Whether a change meets the budget | Architect on architectural cost |
| `SECURITY_AGENT.md` | Permissions, data handling, sandbox | Security posture of a change | Human on any data-off-device |
| `RELEASE_AGENT.md` | Versioning, release notes, tagging | Release mechanics | Human on go/no-go |

Each role file defines: mission, responsibilities, authority, scope, inputs, outputs, required deliverables, decision rules, escalation policy, documentation responsibilities, code-quality expectations, definition of done, anti-patterns, and required checklists. Role files reference the governance documents in `Documentation/` rather than restating them.

## The nine-phase task workflow

Every non-trivial task moves through these phases. Each phase has an exit gate. An agent does not enter the next phase until the gate is met. Small, reversible changes (a typo fix, a test addition) may collapse phases, but never skip testing or documentation.

### 1. Research
Understand the problem and the existing code. Read the architecture and the role file.
Exit gate: the task and its acceptance criteria are restated in writing, and the affected files are identified.

### 2. Planning
Decide the smallest change and the incremental steps that keep the build green.
Exit gate: a step list exists; the owning role is chosen; dependencies are known.

### 3. Architecture review
Determine whether the change touches architecture. If it does, write or update an ADR.
Exit gate: either the change is confirmed to fit existing architecture, or an accepted ADR covers it.

### 4. Implementation
Write the code in small steps, keeping the project compiling after each.
Exit gate: the feature works; the build is green; no forbidden practice is present.

### 5. Testing
Add or update unit and integration tests. A bug fix adds a failing-without-the-fix test.
Exit gate: tests pass; coverage of the change is real, not nominal.

### 6. Documentation
Update every document the change made inaccurate. Update the Notion Documentation Index if a doc was added.
Exit gate: no known document contradicts the new behavior.

### 7. Review
Run the review checklist in [/CLAUDE.md](../CLAUDE.md) and the role's quality checklist.
Exit gate: every checklist item passes or has a written, accepted exception.

### 8. Retrospective
Note what was learned, especially any new constraint or limitation discovered.
Exit gate: any new limitation is recorded in `Documentation/Engineering/` or as an ADR.

### 9. Release
Only when the change is part of a release. Follow `RELEASE_AGENT.md` and the release process.
Exit gate: version tagged, notes written, migration documented if needed.

## Escalation

An agent escalates to a human, not to another agent, when a decision is the user's to make: product scope, priority, anything hard to reverse or outward-facing, data leaving the device, or a knowing budget violation. Cross-role handoffs (engineer to QA, research to architect) happen inside the workflow and do not need a human.

## How roles and CLAUDE.md relate

`/CLAUDE.md` is the constitution: it always applies. A role file is a job description: it applies when an agent is doing that job. Where they overlap, both must be satisfied. Where a role is silent, `/CLAUDE.md` governs.
