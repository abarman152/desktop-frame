# CLAUDE.md — operating rules for AI agents in this repository

This file governs how Claude Code and any AI agent works in the Desktop Frame repository. It is read before every task. Human contributors follow it too. When this file and a more specific document conflict, the more specific document wins for its domain (for example, `Documentation/Standards/SwiftStyleGuide.md` for Swift style), and this file wins for workflow and process.

## Project overview

Desktop Frame is a native macOS desktop customization platform: a transparent desktop-layer window system that renders live wallpaper, interactive widgets, and system information, built to Apple's quality bar. The long-term goal is a platform with a plugin SDK and marketplace. Product strategy lives in Notion; engineering truth lives in `Documentation/`.

Stack: Swift 6, SwiftUI, AppKit where the window system requires it, Swift Concurrency, Core Animation, EventKit, Network.framework, IOKit, OSLog. Target macOS 15+, Apple Silicon first. Xcode 16.

## Architecture principles

1. Native first. SwiftUI and AppKit only. No Electron, no cross-platform UI toolkits.
2. Protocol-oriented. Every engine has a protocol before a concrete type, so it can be tested and replaced.
3. Actors for system data, `@MainActor` for UI. Services that read CPU, memory, battery, network, calendar are `actor` types. Managers that touch AppKit or SwiftUI are `@MainActor`.
4. `@Observable`, not `ObservableObject`.
5. Composition over inheritance. Small, single-responsibility types in small files.
6. Dependency injection through initializers. No global service locator. `AppDelegate` composes the graph.

The full picture is in `Documentation/Architecture/`. Do not invent architecture that contradicts it; propose a change through an ADR instead.

## Folder responsibilities

- `desktop-frame/App/` — app lifecycle, `AppDelegate`, object-graph composition.
- `desktop-frame/Core/Engine/` — `DesktopEngine`, `WidgetEngine`, `LayoutEngine`, `WallpaperEngine`, `RenderingEngine`.
- `desktop-frame/Core/Managers/` — `@MainActor` coordinators that touch AppKit/SwiftUI.
- `desktop-frame/Core/Services/` — `actor` system-data providers.
- `desktop-frame/Core/Window/` — `NSWindow` subclasses and controllers.
- `desktop-frame/Core/Utilities/`, `Core/Extensions/` — logging, constants, config, type extensions.
- `desktop-frame/Features/` — vertical feature slices; features never import each other.
- `desktop-frame/Models/` — `Sendable` value types.
- `Documentation/` — version-controlled docs. See `Documentation/README.md`.
- `.agents/` — agent role definitions. See `.agents/AGENTS.md`.

## Coding standards

Swift specifics live in `Documentation/Standards/SwiftStyleGuide.md`. The rules that matter most to an agent:

- Strict concurrency complete. No data races, no `nonisolated(unsafe)` without a written reason.
- No force unwraps without a documented invariant.
- No `DispatchQueue.main.async`. Use `@MainActor` and `await`.
- One type per file. MARK sections. `///` doc comments on public and internal declarations.
- No magic numbers. Use `AppConstants`.
- No placeholder implementations and no committed `TODO`. Open an issue instead.

## Naming conventions

- Types `UpperCamelCase`; functions and properties `lowerCamelCase`.
- Constants in case-less enums: `AppConstants.Widget.snapGrid`.
- Protocols are nouns or `-able`/`-Protocol`.
- Notifications are reverse-DNS strings under `AppConstants.Notifications`.

## Documentation rules

- Update documentation in the same change as the code that makes it inaccurate. Never in a follow-up.
- New documents copy from `Documentation/Templates/` and follow `Documentation/Standards/DocumentationStandards.md`.
- Architecture or engineering decisions are recorded as ADRs in `Documentation/Decisions/`. A decision that exists only in a commit message or a Notion page is not recorded.
- When you change architecture, write or update the ADR first, then implement.

## Commit rules

Conventional Commits, defined in `Documentation/Processes/GitWorkflow.md`:

```
type(scope): summary in imperative mood

body explaining why, not what

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
```

Types: feat, fix, refactor, perf, docs, test, build, chore. One logical change per commit. Never commit unless the user asks.

## Branching rules

- Never commit to `main` directly. Branch first.
- Branch names: `feature/<short-desc>`, `fix/<short-desc>`, `docs/<short-desc>`, `refactor/<short-desc>`.
- One branch per issue or logical unit.

## Testing requirements

- Services get unit tests with mocked clocks and inputs.
- Managers get integration tests against real AppKit on macOS.
- A change that fixes a bug adds a test that fails without the fix.
- The build must stay green. Strict-concurrency warnings are errors.

## Refactoring rules

- Never mix a refactor and a behavior change in one commit.
- Never perform a massive one-shot refactor. Keep the project compiling after every logical step.
- A refactor that touches architecture needs an ADR.

## Performance expectations

The budget in `Documentation/Standards/` is a release gate, not an aspiration:

- Idle CPU under 0.5% per core.
- Memory under 80 MB resident.
- Widget render under 8 ms on 120 Hz displays.
- Negligible battery impact from live wallpaper, achieved with hardware decode.

A change that regresses the budget does not ship. Measure with Instruments; do not estimate.

## Security requirements

- Public Apple APIs only. No private API usage that risks breakage or App Review rejection.
- All user data stays on device unless the user explicitly opts in. No telemetry without consent.
- Permissions (Calendar, Reminders, Accessibility, Screen Recording) are requested at point of use with a clear purpose string, and the app degrades gracefully when denied.

## Review checklist

Before proposing a change as done, confirm every item:

- [ ] Builds with zero new warnings under strict concurrency.
- [ ] Tests added or updated and passing.
- [ ] No force unwraps, no `DispatchQueue.main.async`, no committed TODO.
- [ ] Public and internal declarations documented.
- [ ] Performance budget not regressed (measured if the change is in a hot path).
- [ ] Accessibility: new interactive elements have labels; Reduce Motion and Reduce Transparency respected.
- [ ] Documentation updated in the same change; ADR written if architecture changed.
- [ ] Conforms to the matching `.agents/` role definition.

## Pull request expectations

A pull request follows `.github/PULL_REQUEST_TEMPLATE.md`. It states what changed and why, links the issue, lists tests, notes any performance or security impact, and names the documentation it updated. PRs are small and single-purpose.

## Forbidden practices

- Committing to `main`, or committing or pushing without being asked.
- Electron, Catalyst-as-a-shortcut, or any non-native UI.
- Private Apple APIs.
- Force unwraps without an invariant; silent error swallowing.
- Massive one-shot refactors.
- Placeholder code, fake data, or committed TODOs presented as finished work.
- Editing an accepted ADR. Supersede it with a new one instead.

## Expected development workflow

The full nine-phase workflow with exit criteria is in `.agents/AGENTS.md`. In short: research, plan, architecture review, implement incrementally, test, document, review, retrospect, release. Each phase has an explicit exit gate. Do not skip phases.

## How to think before making changes

1. Read the relevant `Documentation/Architecture/` and the matching `.agents/` role file.
2. Restate the task and the acceptance criteria in your own words.
3. Identify the smallest change that satisfies it.
4. Check whether it touches architecture. If it does, write an ADR before coding.
5. Plan the incremental steps that keep the build green.
6. Only then write code.

## How to update documentation

When a change makes a document inaccurate, fix the document in the same change. When you add a feature, update the feature's design doc and the Notion Documentation Index. When you make a decision, record an ADR. Treat an out-of-date document as a bug.

## When to stop and ask

Stop and ask the user when:

- The task requires a product or scope decision not already settled in Notion or an ADR.
- Two requirements conflict and no principle resolves it.
- A change would touch architecture in a way no ADR covers.
- An action is hard to reverse or outward-facing (publishing, deleting, force-pushing, sending data off device).
- The performance or security budget would be knowingly violated.

## When to proceed automatically

Proceed without asking when the task is well-specified, fits existing architecture, stays within the budgets, and is reversible: implementing an accepted spec, fixing a bug with a clear repro, writing tests, updating documentation, or a localized refactor that keeps behavior and the build intact.
