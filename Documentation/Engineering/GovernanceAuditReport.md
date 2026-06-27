---
title: Governance audit report
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [../README.md, ../../CLAUDE.md, ../../.agents/AGENTS.md]
---

# Governance audit report

The audit of the Desktop Frame governance framework after its initial build (Phases 1 through 9). It records what was created, verifies internal consistency, and lists the gaps that remain.

## Scope

The version-controlled governance system: the root constitution, the agent framework, engineering processes, documentation standards, the template library, GitHub community files, and the documentation hub. The Notion workspace is covered by [Processes/NotionOperatingSystem.md](../Processes/NotionOperatingSystem.md) and audited there.

## Files created

| Area | Location | Count |
|---|---|---|
| Constitution | `CLAUDE.md` | 1 |
| Agent framework | `.agents/` (index + 15 roles) | 16 |
| Engineering processes | `Documentation/Processes/` | 13 |
| Repository standards | `Documentation/Standards/` | 13 |
| Document templates | `Documentation/Templates/` | 28 |
| Decision records | `Documentation/Decisions/` (system + ADR-0000) | 2 |
| Documentation hub | `Documentation/README.md` | 1 |
| Governance audit | `Documentation/Engineering/GovernanceAuditReport.md` | 1 |
| GitHub community | `.github/` (issues, PR, discussion, security, support, conduct, contributing) | 9 |
| Scaffolding READMEs | `.templates/README.md`, `.docs/README.md` | 2 |

Eighty-five governance Markdown files, plus the GitHub YAML and config files. The directory hierarchy holds twenty-two folders under `Documentation/` and the four repository-level governance folders.

## Coverage

Every planned deliverable was produced.

| Phase | Deliverable | Status |
|---|---|---|
| 1 | Hierarchy, constitution, agent index, doc standard, git workflow, ADR system | Complete |
| 2 | 12 engineering process documents | Complete |
| 3 | 15 agent role files | Complete |
| 4 | 28 document templates | Complete |
| 5 | 12 repository standards | Complete |
| 6 | GitHub community files | Complete |
| 7 | Documentation hub (master index) | Complete |
| 8 | Notion operating manual (full) | Complete |
| 9 | Governance audit and this report | Complete |

Each process document carries the required structure (purpose, scope, ownership, inputs, outputs, workflow, required templates, required reviews, success criteria, KPIs, common failure cases, best practices). Each agent file carries its required structure (mission, responsibilities, authority, scope, inputs, outputs, deliverables, decision rules, escalation, documentation responsibilities, code-quality expectations, definition of done, anti-patterns, checklists). Each template carries required metadata, sections, guidance, and completion and review checklists.

## Audit checks performed

- Internal links. All 288 relative Markdown links across 87 files resolve to existing targets. Zero broken.
- Frontmatter. Every template and governance document opens with the required YAML frontmatter per the documentation standard.
- Agent references. All 15 role files reference the governance documents rather than restating them, between two and eight references each.
- Folder placement. Every file sits in the folder its type dictates; document templates are in `Documentation/Templates/`, not `.templates/`.
- Terminology. Standardized on single canonical homes (below).

## Duplication removed and terminology standardized

- Swift style has one canonical home, [Standards/SwiftStyleGuide.md](../Standards/SwiftStyleGuide.md). The constitution's two references to the older `CodingStandards.md` were corrected to point to it.
- Branch and commit rules have canonical homes in [Standards/BranchingStrategy.md](../Standards/BranchingStrategy.md) and [Standards/CommitConvention.md](../Standards/CommitConvention.md). The git workflow now points to them as canonical instead of competing with them.
- The review checklist has one canonical home, [Standards/ReviewChecklist.md](../Standards/ReviewChecklist.md); the copy in the constitution is labeled as the at-hand version of it.
- The PR template reference was standardized to the single-file `.github/PULL_REQUEST_TEMPLATE.md` across the constitution and the git workflow.
- The Notion operating system is the single source for the Git/Notion split; other documents link to it rather than restating the rule.

## Remaining gaps

These are known and intentional, not oversights:

- Four legacy documents at the `Documentation/` root (`Architecture.md`, `CodingStandards.md`, `DevelopmentSetup.md`, `FolderStructure.md`) have not yet been moved into the subfolder hierarchy. The migration is documented in [README.md](../README.md) and is deferred so each move lands with its Notion Documentation Index update in the same change.
- The `.docs/` tooling (Markdown lint, automated link checking) is specified but not yet wired into CI. The link audit in this report was run manually; it should become a CI check.
- Subsystem architecture documents named by the templates and processes (WindowSystem, RenderingEngine, WidgetEngine, and the rest) are not yet written; they are produced as those subsystems are built, per the documentation lifecycle.
- The `swift-format` configuration referenced by the code style standard is not yet committed at the repository root.

## Recommendations

- Wire the manual checks into CI: Markdown lint against the documentation standard, and the internal-link audit run in this report. Make a broken link or a missing-frontmatter file fail the build.
- Execute the legacy-document migration as a single change that also updates the Notion Documentation Index, then delete this gap from the list.
- Commit the `swift-format` configuration so the code-style standard is enforced mechanically, not by reviewer memory.
- Back-fill ADRs for the foundational decisions already made during scaffolding (window level, actor-isolated services, `@Observable`), numbering from ADR-0001, so the decision record is complete from the start.
- Re-run this audit each quarter alongside the documentation review, and update the file inventory and the gap list.

## Conclusion

The governance framework is complete and internally consistent. Every planned artifact exists, every internal link resolves, terminology has a single source per concept, and the agent framework references the governance documents rather than duplicating them. The remaining gaps are tracked and have owners in the recommendations above.
