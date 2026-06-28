# CLAUDE.md — the Desktop Frame Constitution

This is the constitution of the Desktop Frame project: the primary operating manual for every contributor, human or AI. **Read it before making any change.** It coordinates the whole system — repository, documentation, Notion, AI agents, product, engineering, design, QA, releases, and sprint planning — and tells you where every artifact lives and how work flows from idea to release.

It is deliberately a *coordination layer*, not a textbook. It states the rules that must be obeyed and **links to the canonical document** for the detail. It does not restate Swift style, the git workflow, or the performance budget; it points to where each is owned. When you need depth, follow the link.

## How precedence works

1. **The constitution governs workflow, process, and coordination.** When a process question is unclear, this file decides.
2. **The most specific document wins inside its own domain.** `Documentation/Standards/SwiftStyleGuide.md` wins on Swift style; `Documentation/Processes/GitWorkflow.md` wins on git mechanics; an accepted ADR wins on the architecture it covers.
3. **A role file (`.agents/`) applies on top of the constitution when you are doing that job.** Where they overlap, satisfy both.
4. **If two documents still conflict, the constitution breaks the tie**, and the conflict is logged in [Product Decisions](https://app.notion.com/p/38bc634e2df681d0b31eeb1112f3741c) or an ADR so it does not recur.

**The prime directive:** never invent rules this file or its linked documents already answer; never duplicate a rule — reference its source; never leave the documentation, the repository, and Notion inconsistent with each other after your change.

---

## 1. Project overview

Desktop Frame is a native macOS desktop-customization platform: a transparent desktop-layer window system rendering live wallpaper, interactive widgets, and system information, built to Apple's quality bar, on a path to a plugin SDK and marketplace. Stack: Swift 6, SwiftUI, AppKit where the window system requires it, Swift Concurrency, Core Animation/Metal, EventKit, Network.framework, IOKit, OSLog. Target macOS 15+, Apple Silicon first, Xcode 16.

The identity is owned in Notion and must not be re-derived here:

- **Purpose & problem** — [Pain Points](https://app.notion.com/p/38bc634e2df68194a95fdbb6524f0934), [Target Users](https://app.notion.com/p/38bc634e2df6815aafcdda6c36914cf0), [Core Personas](https://app.notion.com/p/38cc634e2df681f2b925ea0b0381681b), [User Personas](https://app.notion.com/p/38bc634e2df681fc9e16ee4d5800bd82)
- **Vision / Mission** — [Vision](https://app.notion.com/p/38bc634e2df68173bce0e8b75284a83b) · [Mission](https://app.notion.com/p/38bc634e2df68120913bde5796ee47a3) (surface → system → platform)
- **Philosophy & principles** — [Product Philosophy](https://app.notion.com/p/38bc634e2df681e79944c1d1ec5cd45f) · [Core Principles](https://app.notion.com/p/38bc634e2df681e5a2daf9407923d8c0) (conflict-ordered: the Mac comes first; quality gates scope; default to less; configurable without code; public APIs only; performance is a release gate; earn the platform; decide with evidence)
- **Architecture & engineering philosophy** — `Documentation/Architecture.md` (layered, protocol-first, actors for system data, `@MainActor` for UI, `@Observable`, DI via initializer)
- **Long-term goals** — [Goals](https://app.notion.com/p/38bc634e2df6814cb804c87fee6ec0aa) · [Roadmap](https://app.notion.com/p/38bc634e2df68112952cf63c7c9b4206) · [Success Metrics](https://app.notion.com/p/38bc634e2df6812e84b0d939a5dde0dd) (North Star: Active Retained Desktops)

**Documentation philosophy:** an out-of-date document is a bug, fixed in the same change as the code that broke it. **Repository philosophy:** one home per artifact, cross-referenced by link, never copied; the build stays green; small reversible steps over big-bang changes.

---

## 2. The two systems: Git and Notion

Desktop Frame's knowledge lives in two systems with a strict boundary, defined canonically in [`Documentation/Processes/NotionOperatingSystem.md`](Documentation/Processes/NotionOperatingSystem.md) and the [Documentation hub](Documentation/README.md):

- **Git holds engineering truth** — anything that must be reviewed, versioned, and kept in lockstep with the code: architecture, ADRs, standards, processes, templates, API docs, source.
- **Notion holds living project management** — anything that changes daily and does not need code review: vision/strategy, roadmap, sprints, tasks, meetings, research, ideas, decisions index, metrics.
- **The rule that prevents drift:** no architecture or engineering decision exists *only* in Notion. Every such decision is an ADR in git, mirrored in the Notion Engineering section. The full split is the [Repository vs Notion matrix](#5-repository-vs-notion-matrix) below.

---

## 3. Repository operating system

The repository's layout, ownership, and placement rule are owned by [`Documentation/Standards/FolderStructure.md`](Documentation/Standards/FolderStructure.md) and the source-tree layout by [`Documentation/Architecture.md`](Documentation/Architecture.md). The essentials:

- **Folder responsibilities** — `desktop-frame/App/` (lifecycle, object-graph composition), `Core/Engine`, `Core/Managers` (`@MainActor` coordinators), `Core/Services` (`actor` providers), `Core/Window` (`NSWindow` subclasses), `Core/Utilities` & `Core/Extensions`, `Features/` (vertical slices that never import each other), `Models/` (`Sendable` value types).
- **Module boundaries** — features never import features; managers touch AppKit/SwiftUI; services are actor-isolated; dependencies flow downward (App → Features → Core → Foundation), never sideways.
- **Naming conventions** — owned by [`Documentation/Standards/NamingConventions.md`](Documentation/Standards/NamingConventions.md): types `UpperCamelCase`; members `lowerCamelCase`; constants in case-less enums (`AppConstants.Widget.snapGrid`); notifications reverse-DNS under `AppConstants.Notifications`.
- **The placement rule** — a new file goes in exactly one place chosen by what it is: source under `desktop-frame/`, a versioned doc under `Documentation/`, an agent role under `.agents/`, a GitHub/community file under `.github/`. If it seems to fit two places, it belongs with its primary owner and is linked from the other.
- **How the repository evolves** — structural change is proposed via an ADR; a misplaced file is moved (with its links updated) in the same change; the quarterly governance audit checks placement.

### Repository structure

```
desktop-frame/
├── desktop-frame/              App source (owner: Engineering)
│   ├── App/                    AppDelegate, app entry, object-graph composition
│   ├── Core/
│   │   ├── Engine/             DesktopEngine, WidgetEngine, … (planned)
│   │   ├── Managers/           @MainActor coordinators (planned)
│   │   ├── Services/           actor system-data providers (planned)
│   │   ├── Window/             NSWindow subclasses & controllers (planned)
│   │   ├── Utilities/          Logger, Constants, AppConfiguration
│   │   └── Extensions/         type extensions
│   ├── Features/               vertical feature slices (planned)
│   ├── Models/                 Sendable value types (planned)
│   └── Assets.xcassets/
├── desktop-frame.xcodeproj/    Xcode project
├── Tests/                      test targets (owner: QA/Testing)
├── Scripts/                    build & tooling scripts
├── Documentation/              versioned docs (owner: per-doc frontmatter) — see §4
│   ├── Architecture.md · Standards/ · Processes/ · Decisions/ · Templates/ · README.md (hub)
├── .agents/                    AI agent roles + nine-phase workflow (AGENTS.md)
├── .github/                    community & template files (CONTRIBUTING, SECURITY, …)
├── .templates/ · .docs/        code scaffolding · doc tooling config
├── CLAUDE.md                   this constitution
└── README.md · ROADMAP.md · CHANGELOG.md · LICENSE · .gitignore
```

Folders marked *planned* exist in the architecture and will be created as the surface is built; do not invent alternative locations for them.

---

## 4. Documentation rules

Documentation standards, lifecycle, and style are owned by [`Documentation/Standards/DocumentationStandards.md`](Documentation/Standards/DocumentationStandards.md), [`DocumentationStyleGuide.md`](Documentation/Standards/DocumentationStyleGuide.md), and [`Processes/DocumentationLifecycle.md`](Documentation/Processes/DocumentationLifecycle.md). The constitutional rules:

- **Hierarchy** — the [Documentation hub](Documentation/README.md) (`Documentation/README.md`) is the map; it defines the thirteen subfolders and their owners. Do not duplicate that map elsewhere.
- **Ownership & metadata** — every document carries frontmatter (`title`, `status`, `owner`, `created`, `updated`, `review_by`, `related`). The named owner is accountable for accuracy.
- **Markdown standards & naming** — per the style guide; ADRs are `ADR-NNNN-kebab-title.md`; new docs copy from `Documentation/Templates/`.
- **Cross-linking** — every doc links its related docs; no orphan documents. A doc added to git is added to the Notion [Documentation Index](https://app.notion.com/p/38bc634e2df6810a91bad630b5d3e48c) in the same change.
- **When documentation must be updated** — in the *same change* that makes it inaccurate, never in a follow-up. See the [Documentation Update Matrix](#11-documentation-update-matrix).
- **When review is mandatory** — any architecture/standard/process change; the quarterly review by the Documentation Lead; any doc past its `review_by`.
- **Documentation quality checklist** — frontmatter complete · placed correctly · cross-linked both ways · no duplication · claims labeled (verified/research/decision/recommendation) · examples accurate · Index updated.

---

## 5. Notion operating rules & Repository vs Notion matrix

Canonical: `Documentation/Processes/NotionOperatingSystem.md`. The decision matrix for every major artifact:

| Artifact | Lives in | Canonical home | Note |
|---|---|---|---|
| Vision, Mission, Goals, Philosophy, Principles | Notion | Notion | strategy, changes without a PR |
| Target Users, Core/User Personas, JTBD, Pain Points | Notion | Notion | the Product Identity system |
| Roadmap, Milestones | Notion | Notion | living plan |
| Product Requirements (PRD) | Notion | Notion | links to ADRs for technical depth |
| Feature Matrix / Feature Catalog | Notion (DB) | Notion | portfolio lens over PRD F-items |
| Feature Requests, Ideas | Notion (DB) | Notion | intake |
| User Stories | Notion (DB) | Notion | |
| Product Decisions (Decision Log) | Notion (DB) | Notion | product/strategy decisions; links to ADRs |
| Success Metrics / KPI Register | Notion (DB) | Notion | North Star + KPIs |
| Sprints, Tasks, Epics | Notion (DB) | Notion | execution |
| Meeting Notes | Notion (DB) | Notion | |
| Research, spikes, benchmarks | **Both** | Notion summary + git write-up | finding in Notion Research DB; durable write-up in `Documentation/Research/` |
| Bug Reports | Notion (DB) | Notion | tracking; root-cause/postmortem may also be a git RCA |
| Risk Register, Dependency Registry | Notion (DB) | Notion | mirrors policy in git Standards |
| **Architecture** | Markdown | git `Documentation/Architecture.md` | Notion Engineering mirrors index |
| **ADRs (Architecture Decisions)** | Markdown | git `Documentation/Decisions/` | immutable; supersede, don't edit |
| **Coding/Swift standards, naming, style** | Markdown | git `Documentation/Standards/` | |
| **Processes** (git, sprint, bug, release, QA, versioning) | Markdown | git `Documentation/Processes/` | |
| **Templates** | Markdown | git `Documentation/Templates/` | |
| **API / Plugin SDK docs** | Markdown | git `Documentation/API/` | |
| **Performance / Security / Testing reports** | Markdown | git (from templates) | |
| **Release Notes / Changelog** | Markdown | git `CHANGELOG.md` + `Documentation/Releases/` | Notion Release History mirrors |
| Source code, tests, scripts, config | Markdown/code | git | |

**Required Notion sections:** Home, Product, Design, Engineering, Development, QA & Testing, Sprint Planning, Roadmap, Meeting Notes, Ideas, Analytics, Releases, References, Documentation Index. **Required Notion databases:** Task / Epic / Feature / Bug / Technical-Debt / Sprint / Risk / Dependency / Meeting-Notes / Ideas / Research / Release-History trackers, plus **Feature Catalog**, **KPI Register**, and **Decision Log**.

**Synchronization & archiving:** when a decision changes a requirement, update the PRD/Feature Matrix and log it in the Decision Log in the same pass; when an ADR is accepted in git, mirror its index row in the Notion Engineering section; nothing is deleted — archive by status; the Documentation Lead reconciles the Documentation Index quarterly.

### Notion structure

The workspace root is **Desktop Frame** → the fourteen sections above. Product holds the identity, PRD, Feature Matrix, Success Metrics, and Decision Log; Development holds the Feature/Task/Sprint trackers; Engineering mirrors the ADR index; Roadmap holds the milestone pages; Documentation Index maps every git `.md` to its purpose. Page and data-source IDs are recorded in the agent's project memory, not here (IDs are operational state, not constitution).

---

## 6. AI agent workflow

How a Claude session operates, end to end. The role definitions and the canonical nine-phase workflow are owned by [`.agents/AGENTS.md`](.agents/AGENTS.md); adopt the role matching your work.

- **Think** — read this constitution, the relevant `Documentation/Architecture.md` / Standards, and the matching `.agents/` role. Restate the task and acceptance criteria in your own words. Identify the smallest change.
- **Plan** — list incremental steps that keep the build green; choose the owning role; identify dependencies and affected files.
- **Research** — prefer evidence over assumption; label claims (verified/research/inference/judgment); record durable findings in `Documentation/Research/` and the Notion Research DB.
- **Implement** — small steps, compiling after each; no forbidden practice (§ below); reference existing standards rather than inventing.
- **Document** — update every doc the change made inaccurate, in the same change; update the Notion Documentation Index if a doc was added.
- **Test** — services get unit tests with mocked clocks; managers get integration tests on real AppKit; a bug fix adds a failing-without-the-fix test.
- **Review** — run the relevant [checklists](#10-checklists) and the role's quality checklist.
- **Summarize** — end every session with the [closing protocol](#14-end-of-every-session).
- **Update Notion / Markdown** — keep both systems consistent per the matrix; never leave one updated and the other stale.

**When Claude must stop and ask a human:** a product or scope decision not settled in Notion or an ADR; two requirements conflict with no principle to resolve them; a change touches architecture no ADR covers; an action is hard to reverse or outward-facing (publishing, deleting, force-pushing, sending data off device); a performance or security budget would be knowingly violated. **When Claude may proceed automatically:** the task is well-specified, fits existing architecture, stays within budgets, and is reversible — implementing an accepted spec, fixing a bug with a clear repro, writing tests, updating docs, a localized refactor that preserves behavior. Escalate to a *human*, not another agent, for the decisions above; cross-role handoffs happen inside the workflow.

---

## 7. Development workflow

The canonical nine phases with exit gates are in [`.agents/AGENTS.md`](.agents/AGENTS.md). Each phase enters only when the previous gate is met; small reversible changes may collapse phases but never skip testing or documentation.

| Phase | Exit gate |
|---|---|
| 1. Research | Task & acceptance criteria restated; affected files identified |
| 2. Planning | Step list exists; owning role chosen; dependencies known |
| 3. Architecture review | Change fits existing architecture, or an accepted ADR covers it |
| 4. Implementation | Feature works; build green; no forbidden practice |
| 5. Testing | Tests pass; coverage of the change is real |
| 6. Documentation | No known document contradicts the new behavior; Index updated |
| 7. Review | Every checklist item passes or has a written, accepted exception |
| 8. Retrospective | Any new limitation recorded in `Documentation/Engineering/` or an ADR |
| 9. Release | Version tagged, notes written, migration documented if needed |

---

## 8. Feature, bug, sprint, and release workflows

These are owned by `Documentation/Processes/` (`ProjectLifecycle`, `BugManagement`, `SprintManagement`, `ReleaseManagement`). The constitution fixes the stages and *which documents each stage updates*.

### Feature workflow
Idea → Research → Validation → Feature Request → Product Review → User Story → PRD update → Architecture review → Sprint planning → Implementation → QA → Documentation → Release → Post-release review.
Updates by stage: Idea/Research → Notion [Ideas](https://app.notion.com/p/38bc634e2df681fa9aa1c54ede407d8a) + Research DB; Feature Request → [Feature Requests](https://app.notion.com/p/38bc634e2df681fb97dded917bece4ba); Validation → [Feature Matrix](https://app.notion.com/p/38bc634e2df681e29bc5f601fccb27a2) (Validated) + [Decision Log](https://app.notion.com/p/38bc634e2df681d0b31eeb1112f3741c); User Story → [User Stories](https://app.notion.com/p/38bc634e2df6813bb212cd692d2b4539); PRD update → [PRD](https://app.notion.com/p/38bc634e2df681a2a78ae52d4a5c06b6); Architecture → ADR in git; Sprint → Sprint/Task trackers; Implementation/QA → code + Tests; Documentation → affected `Documentation/` + Index; Release → `CHANGELOG.md` + Release History; Post-release → [Success Metrics](https://app.notion.com/p/38bc634e2df6812e84b0d939a5dde0dd).

### Bug workflow
Discovery → Reproduction → Severity → Investigation → Root cause → Fix → Regression test → Documentation → Release → Postmortem → Archive.
Required docs: Bug Tracker entry (Notion) using `Templates/BugReport.md`; a failing-then-passing regression test; for High severity, an RCA from `Templates/RootCauseAnalysis.md` in `Documentation/Engineering/`; `CHANGELOG.md` on release; an Incident record if it was a security or data incident ([`Processes/IncidentManagement.md`](Documentation/Processes/IncidentManagement.md)).

### Sprint workflow
Backlog → Planning → Execution → Standup → Review → Retrospective → Release → Documentation update → Knowledge capture. Owned by `Processes/SprintManagement.md`; artifacts in the Sprint Planning section using the `SprintPlanning/Review/Retrospective` templates; knowledge capture lands in Research or Engineering docs.

### Release workflow
Milestone → Release candidate → QA → Documentation freeze → Release → Postmortem → Lessons learned → Version history. Owned by `Processes/ReleaseManagement.md` + `VersioningStrategy.md`; SemVer with independent app / plugin-API / data-format versions; `CHANGELOG.md` and `Documentation/Releases/` updated; a MAJOR release requires a `Templates/MigrationGuide.md`.

---

## 9. Commit, branch, and PR rules

Owned by `Documentation/Processes/GitWorkflow.md`, `Standards/BranchingStrategy.md`, `Standards/CommitConvention.md`.

- **Never commit to `main`.** Branch first: `feature/…`, `fix/…`, `docs/…`, `refactor/…`. One branch per logical unit.
- **Never commit or push unless the user asks.**
- **Conventional Commits**, imperative mood, body explaining *why*. End commit messages with:
  `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`
- **One logical change per commit; never mix a refactor with a behavior change.**
- **Pull requests** follow `.github/PULL_REQUEST_TEMPLATE.md`: what changed and why, linked issue, tests, performance/security impact, docs updated. Small and single-purpose. End PR bodies with the Claude Code generation line.

---

## 10. Documentation update matrix

For each event, update exactly these. (Notion = the relevant DB/page; Markdown = `Documentation/…`.)

| Event | Notion | Markdown / git | Decision/Changelog |
|---|---|---|---|
| New feature | Feature Matrix, User Stories, Roadmap, Success Metrics | feature design doc, API docs if public | Decision Log if a choice was made; CHANGELOG on release |
| Bug fix | Bug Tracker | regression test; RCA if High | CHANGELOG |
| Architecture change | Engineering ADR-index mirror | **ADR (canonical)** + Architecture.md | Decision Log row linking the ADR |
| Performance improvement | Success Metrics (KPI) | PerformanceReport (`Templates`) | CHANGELOG |
| UI / UX change | — | Design notes / UISpecification | Decision Log if a UX decision |
| Research | Research DB | `Documentation/Research/` write-up | Decision Log if it drives a choice |
| Sprint / Meeting | Sprint trackers / Meeting Notes | — | — |
| Release | Release History | CHANGELOG + Releases/ + tag | Migration guide if MAJOR |
| Security issue | Bug Tracker (private), Incident | SecurityReview; RCA | CHANGELOG (Security) |
| Dependency change | Dependency Registry | DependencyPolicy compliance note | CHANGELOG |
| Plugin / Theme / Widget / Wallpaper | Feature Matrix | feature doc; PluginSpecification for SDK | Decision Log if architectural |
| Accessibility | Success Metrics (a11y) | AccessibilityStandards conformance note | — |
| Privacy change | Decision Log | SecurityStandards | CHANGELOG; **stop & ask if data leaves device** |

---

## 11. Templates

Do not write a document type from scratch; copy its template from `Documentation/Templates/` and follow `DocumentationStandards.md`. Available: Architecture, TechnicalSpecification, ProductRequirementDocument, FeatureSpecification, Epic, UserStory, BugReport, SprintPlanning/Review/Retrospective, DailyDevelopmentLog, DecisionRecord (ADR), ReleaseNotes, MeetingNotes, ResearchReport, CompetitiveAnalysis, PerformanceReport, SecurityReview, RootCauseAnalysis, IncidentReport, MigrationGuide, APIDocumentation, PluginSpecification, UISpecification, UXResearch, TestingReport, ChangelogEntry, DesignProposal. The full index is in the [Documentation hub](Documentation/README.md).

---

## 12. Checklists

These are mandatory; the canonical master is `Documentation/Standards/ReviewChecklist.md` and the per-role checklists in `.agents/`. Before calling work done, pass the checklist for the work type: Feature, Bug, PR, Release, Documentation, Architecture, Testing, Security, Accessibility, Performance, Research, Sprint. Do not restate them here — run them from their source.

---

## 13. AI rules, quality gates, and forbidden practices

**Claude must always:** read this constitution first; think before coding; reference existing standards rather than inventing; update all related documentation and cross-links; preserve consistency between code, docs, and Notion; explain architectural decisions (and write the ADR); recommend improvements; finish with the closing protocol.

**Claude must never:** invent requirements; skip documentation or testing; create orphan or duplicate documents; let docs, repo, and Notion drift; commit to `main` or commit/push unasked; use Electron/Catalyst-shortcuts/non-native UI; use private Apple APIs; force-unwrap without a documented invariant; swallow errors silently; perform a massive one-shot refactor; ship placeholder code, fake data, or committed TODOs presented as finished; edit an accepted ADR (supersede it instead).

**Quality gates — every implementation passes all before completion** (canonical: `Documentation/Processes/QualityGates.md`): Architecture · Performance (a release gate, measured with Instruments) · Accessibility (a release gate) · Security & Privacy (a release gate; data stays on device without consent) · Testing · Documentation · Product · UX. A change that regresses the performance or security budget does not ship.

---

## 14. End of every session

Every session closes with this summary, so the next contributor — human or AI — inherits a clear state:

1. **Summary of work** — what changed and why.
2. **Files changed** — the concrete diff surface.
3. **Notion pages requiring updates** — what still needs editing in Notion, with links.
4. **Markdown documents updated** — which `Documentation/` files changed.
5. **Architecture impacts** — any ADR written or needed.
6. **Technical debt** — anything deferred, with a pointer to where it is tracked.
7. **Recommended next tasks** — the obvious follow-ups.
8. **Open questions** — decisions awaiting a human.
9. **Risks** — what could go wrong, linked to the Risk Register.
10. **Future improvements** — ideas worth capturing in [Ideas](https://app.notion.com/p/38bc634e2df681fa9aa1c54ede407d8a).

---

## Governance audit — gaps & recommendations

This rewrite turns CLAUDE.md from a coding-guideline into the project's operating system: it now coordinates repository, documentation, Notion, agents, and the full delivery lifecycle, and it references canonical sources instead of duplicating them. Known gaps to close, in priority order:

1. **Xcode project drift.** The project file declares `SWIFT_VERSION = 5.0` and a high deployment target while this constitution and `DevelopmentSetup.md` mandate **Swift 6 / macOS 15**. Reconcile the build settings (set Swift 6, strict concurrency complete) and record it in the Decision Log.
2. **ADR back-fill.** Several architecture decisions are recorded in the Notion Decision Log marked "to back-fill as ADR-000X." Write those ADRs in `Documentation/Decisions/` so the canonical technical record exists in git.
3. **Planned source folders don't exist yet.** `Core/Engine`, `Managers`, `Services`, `Window`, `Features`, `Models`, `Plugins` are referenced by the architecture but not created. Create them with the surface build; until then they are aspirational.
4. **No CI yet.** The performance, accessibility, and reliability quality gates are policy but not automated. Add `.github/workflows/ci.yml` (build + test + perf/a11y checks) so the gates are enforced, not just asserted.
5. **Notion IDs live only in agent memory.** That is intentional (IDs are operational state), but a human-readable index page in the Notion Documentation Index should mirror the database list so the mapping survives independently of any agent.
6. **`.swift-format` is referenced but absent.** Add it at the repo root so formatting is reproducible.

Maintenance: review this constitution at every milestone boundary and whenever a process document it references changes. Change it by editing in place (it is living, unlike ADRs), and log any material governance change in the Decision Log.
