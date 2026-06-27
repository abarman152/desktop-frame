---
title: Naming conventions
status: Active
owner: Principal Engineer
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [SwiftStyleGuide.md, FolderStructure.md]
---

# Naming conventions

How things are named across code, files, and the repository. Consistent names lower the cost of reading code nobody on the current team wrote.

## Swift

- Types, protocols, enums: `UpperCamelCase`. `DesktopEngine`, `WidgetPosition`.
- Functions, methods, properties, cases: `lowerCamelCase`. `startEngine()`, `currentLayout`.
- Protocols are nouns or capability adjectives: `WidgetRenderable`, or `DesktopEngineProtocol` when it names the interface to a concrete type.
- Constants live in case-less enums: `AppConstants.Widget.snapGrid`. No free-floating globals.
- Booleans read as assertions: `isVisible`, `hasShadow`, `shouldAnimate`.
- Acronyms are uppercased as a unit in type names (`CPUService`) and lowercased when leading a property (`cpuUsage`).

## Notifications and keys

- Notification names are reverse-DNS strings under `AppConstants.Notifications`: `"DesktopFrame.themeDidChange"`.
- Persistence keys are namespaced and defined in one place, never inline string literals.

## Files

- Swift files are named for their primary type: `DesktopWindow.swift`.
- Extensions are named `Type+Purpose.swift`: `Color+Hex.swift`.
- Documentation files follow [DocumentationStandards.md](DocumentationStandards.md): `PascalCase.md`, `ADR-NNNN-kebab.md`, and `UPPER_SNAKE.md` only for agent and root convention files.

## Git

- Branches: `feature/`, `fix/`, `docs/`, `refactor/`, `perf/`, `hotfix/` followed by a short kebab description, per [BranchingStrategy.md](BranchingStrategy.md).
- Commits follow [CommitConvention.md](CommitConvention.md).

## Test names

- Test methods describe the behavior under test: `test_sample_returnsZeroWhenIdle`. The name states the condition and the expectation.

## Completion and review

Names are reviewed as part of every change. A name that needs a comment to be understood is usually the wrong name.
