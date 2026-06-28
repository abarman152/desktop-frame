---
title: Testing strategy
status: Active
owner: QA
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [../Architecture/DependencyInjection.md, ../Processes/QualityGates.md, ../Standards/PerformanceStandards.md, ../Templates/TestingReport.md, ../../.agents/TESTING_AGENT.md]
---

# Testing strategy

How Desktop Frame is tested, and why each layer is tested the way it is. The strategy follows the architecture: the same boundaries that make the system clean — actor services behind protocols, initializer injection, `Sendable` snapshots — are what make it testable. This document defines the test types, what each covers, and the rules that keep tests fast and meaningful. The quality gate that tests feed is owned by [QualityGates](../Processes/QualityGates.md).

## Purpose and scope

In scope: the test pyramid for this app, what to test at each level, the mocking and clock discipline, and the special cases (AppKit, rendering, accessibility, plugins). Out of scope: the release-gate policy ([QualityGates](../Processes/QualityGates.md)) and the per-change report format ([TestingReport](../Templates/TestingReport.md)).

## Context

A desktop-customization app has three testing hazards: time-based behaviour (polling cadences, debounced writes, animations) that makes naive tests slow and flaky; AppKit/window behaviour that needs a real run loop; and observed platform behaviour that cannot be unit-tested at all and must be verified manually per macOS release. The strategy isolates each so the fast tests stay fast and the slow/manual checks are explicit, not accidental.

## Design

### The test pyramid

```
        ┌───────────────────────────┐
        │  Manual platform checks   │  per release: Spaces, Mission Control,
        │  (window-server behaviour)│  Stage Manager, full-screen, hot-plug
        ├───────────────────────────┤
        │  UI / integration tests   │  few: real AppKit, real windows
        ├───────────────────────────┤
        │  Snapshot / a11y tests    │  per-widget rendering & a11y tree
        ├───────────────────────────┤
        │      Unit tests           │  many: services, engines, pure rules
        └───────────────────────────┘
```

The pyramid for Desktop Frame. Most coverage is fast unit tests over injected, isolated units; window-server behaviour that cannot be automated is an explicit manual checklist, not a gap.

### Test types and what they cover

- **Unit tests (the bulk).** Pure rules (grid snapping, layout validation, config-schema validation/migration), engines, and `actor` services. Services are tested with an **injected clock**, never wall-clock `sleep`, so a 60 s calendar cadence tests in microseconds. Every unit is constructed with mock collaborators via initializer injection ([DependencyInjection](../Architecture/DependencyInjection.md)) — no global state to reset. Swift Testing / XCTest; `swift-concurrency` discipline for actor and `@MainActor` tests.
- **Integration tests.** Managers against real AppKit on a real run loop: window creation/teardown, the display-reconcile algorithm with simulated screen-parameter changes, persistence round-trips (write a layout, reload, assert equality, including a forward migration from an older `schemaVersion`).
- **Snapshot tests.** Per-widget rendering across appearance (light/dark), Dynamic Type sizes, and theme tokens, to catch visual regressions deterministically. Reference images are committed and reviewed.
- **Accessibility tests.** Assert each widget exposes correct labels/traits/values and is reachable by VoiceOver and Full Keyboard Access, using the `ios-accessibility` discipline and the audit in [AccessibilityStandards](../Standards/AccessibilityStandards.md). A widget without an accessible representation fails.
- **Performance tests.** Instruments-based, against the [budget](../Standards/PerformanceStandards.md): idle CPU, widget render time, memory, launch-to-ready, live-wallpaper energy. A hot-path change attaches a [PerformanceReport](../Templates/PerformanceReport.md) with before/after numbers; a regression fails the gate.
- **Regression tests.** Every bug fix lands with a test that fails without the fix ([BugManagement](../Processes/BugManagement.md)) — the test is the proof the bug is fixed and the guard it stays fixed.
- **Plugin tests.** Plugins are tested against a host-provided mock host (the SDK test harness), and the host is tested against mock plugins, so the XPC contract is exercised from both sides; crash/restart supervision and capability enforcement are integration-tested ([PluginSDK](../Architecture/PluginSDK.md)).
- **UI tests (few).** End-to-end flows (add a widget, move it, persist, relaunch, see it restored) on a real surface. Kept few because they are the slowest and most brittle; the pyramid pushes coverage down.

### What is *not* automated

Observed window-server behaviour — appearance across Spaces, Mission Control, Stage Manager, full-screen overlay, multi-display hot-plug — cannot be reliably unit-tested. It is a **manual verification checklist run per macOS release** ([MacOSPlatformResearch](../Research/MacOSPlatformResearch.md)), owned by QA, not pretended to be automated. Treating it as an explicit checklist is the honest alternative to flaky automation.

## Invariants

1. **No test sleeps on the wall clock;** time is injected ([DependencyInjection](../Architecture/DependencyInjection.md)).
2. **Every bug fix includes a test that fails without it** ([BugManagement](../Processes/BugManagement.md)).
3. **A performance-sensitive change attaches measured before/after numbers** ([PerformanceStandards](../Standards/PerformanceStandards.md)).
4. **Unit tests have no shared global state;** each constructs its own graph with mocks.

## Known limitations

- Platform-behaviour checks are manual by necessity; their cost is bounded by keeping them a tight, prioritised checklist rather than exhaustive.
- Snapshot tests are sensitive to OS rendering changes; reference images are re-baselined deliberately, under review, when the OS changes them.

## Future evolution

As CI lands (a current gap, [GovernanceAuditReport](../Engineering/GovernanceAuditReport.md)), unit/integration/snapshot/a11y tests and the perf smoke checks run per PR; the manual platform checklist remains a release-gate human step. The plugin harness ships with the SDK so third parties test against the same contract.

## References

1. [QualityGates](../Processes/QualityGates.md) · [TestingReport](../Templates/TestingReport.md) · [TESTING_AGENT](../../.agents/TESTING_AGENT.md).
2. Apple, "Swift Testing." https://developer.apple.com/documentation/testing
3. Apple, "XCTest." https://developer.apple.com/documentation/xctest

## Completion checklist
- [x] Test types defined with what each covers.
- [x] Clock/mocking discipline stated.
- [x] Non-automatable behaviour made explicit.
- [x] Invariants named; gate linked.

## Review checklist
- [ ] Matches the test targets as they are created.
- [ ] Wired into CI when CI lands.
- [ ] Meets DocumentationStandards.
