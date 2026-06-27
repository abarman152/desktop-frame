---
title: UX research — desktop customisation prior art
status: Active
owner: UI/UX
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [MacOSPlatformResearch.md, ../UX/InteractionModel.md, ../UX/InformationArchitecture.md, ../UX/UserFlows.md, ../Design/DesignPhilosophy.md]
---

# UX research — desktop customisation prior art

What existing desktop-customisation tools teach about the experience Desktop Frame should offer, and the mental models users already hold. This is the evidence behind the [interaction model](../UX/InteractionModel.md), [IA](../UX/InformationArchitecture.md), and [flows](../UX/UserFlows.md). It complements the platform-behaviour evidence in [MacOSPlatformResearch](MacOSPlatformResearch.md): that doc covers *what macOS does*; this covers *what users expect and where prior tools fall short*. Findings are labelled **observation** (from public docs/reviews/forums) vs **inference**.

## Question

What interaction model, information architecture, and onboarding will make a deeply customisable desktop feel native, calm, and learnable on macOS — and which failure modes of existing tools must Desktop Frame avoid?

## Method

Comparative analysis of widely-used macOS and cross-platform desktop-customisation tools, drawing on their public documentation, App Store / community reviews, and forum discussion; triangulated with Apple's HIG and the macOS widget/Notification-Centre conventions ([MacOSPlatformResearch](MacOSPlatformResearch.md)). This is **prior-art synthesis, not primary usability testing** — its conclusions are hypotheses to validate with real users during the surface milestones (limitation noted below). Sample is the prominent tools in the category; it is not exhaustive.

## Prior art surveyed

| Tool | Category | What it does well (observation) | Where it falls short (observation/inference) |
|---|---|---|---|
| Übersicht | HTML/JS desktop widgets | Powerful, fully scriptable widgets | Requires writing code/config; not "configurable without code"; non-native look |
| Rainmeter (Windows) | Skins/widgets | Deep customisation, large community | Steep learning curve; config-file driven; inconsistent visual language across skins |
| Plash | Web-page-as-wallpaper | Simple, focused, Mac-native feel | Narrow scope (one web view), not a widget system |
| Notification Centre / macOS widgets | First-party widgets | Native, calm, trusted, familiar | Confined to a panel; not arrangeable freely on the desktop; limited interactivity |
| Stage Manager / Spaces | Window/space management | System-level, predictable | Not a customisation surface; sets coexistence expectations Desktop Frame must respect |
| Wallpaper engines (video/shader) | Animated wallpaper | Visual richness | Frequent performance/battery complaints; little power-awareness |

## Findings

1. **The biggest barrier is "you must configure with code."** (observation) Übersicht and Rainmeter are powerful but gate customisation behind scripting/config files; reviews repeatedly cite the learning curve. → Validates "configurable without code" as a differentiator ([principle 5](../Design/DesignPhilosophy.md)).
2. **Inconsistent visual language is the cost of open theming done naively.** (observation) Rainmeter skins look wildly different; the desktop becomes incoherent. → Validates a token-driven shared language so third-party widgets still look native ([DesignSystem](../Design/DesignSystem.md), [ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md)).
3. **Users already understand "objects arranged on my desktop."** (inference, from icon/sticky/widget conventions) The desktop-as-canvas with direct manipulation matches an existing mental model, lowering the learning curve. → Validates direct-manipulation-first ([ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md)) and the "it's my desktop" model ([InformationArchitecture](../UX/InformationArchitecture.md)).
4. **First-party widgets win on trust and calm, lose on freedom.** (observation) macOS widgets are loved for being native and quiet but constrained to a panel. → Desktop Frame's opportunity is native-and-calm *plus* free arrangement and interactivity ([UserFlows](../UX/UserFlows.md)).
5. **Animated wallpaper without power-awareness is a top complaint.** (observation) Wallpaper-engine reviews frequently cite battery drain and fan noise. → Validates cost disclosure and the power-aware lifecycle ([WallpaperUX](../UX/WallpaperUX.md), [ADR-0006](../Decisions/ADR-0006-tiered-rendering-strategy.md)).
6. **Coexistence with the OS matters.** (inference) Tools that fight Mission Control/Stage Manager feel broken. → Validates designing for desktop-environment coexistence explicitly ([InteractionModel](../UX/InteractionModel.md)).
7. **Accessibility is largely absent in the category.** (observation) Customisation tools rarely advertise VoiceOver/keyboard support. → An accessible customisation surface is both a differentiator and a requirement ([AccessibilityDesign](../Design/AccessibilityDesign.md)).

## Implications

- Lead with no-code, direct-manipulation customisation; make scripting/authoring an *advanced, optional* path, not the price of entry.
- Make the token-driven shared language non-negotiable so coherence survives third-party widgets.
- Lean on existing mental models (desktop objects, System Settings, familiar widgets) to keep onboarding brief.
- Treat performance/power-awareness and accessibility as features, since the category neglects both.

## Recommendations

1. Adopt direct-manipulation-first as the core interaction model — routed to [ADR-0014](../Decisions/ADR-0014-direct-manipulation-widget-interaction-model.md).
2. Enforce semantic tokens for all widgets including third-party — routed to [ADR-0012](../Decisions/ADR-0012-semantic-design-token-architecture.md).
3. Keep Settings to the standard macOS pattern with progressive disclosure — routed to [ADR-0015](../Decisions/ADR-0015-settings-information-architecture.md).
4. Disclose wallpaper cost and enforce power-awareness in the UX — routed to [WallpaperUX](../UX/WallpaperUX.md).
5. Validate these hypotheses with real usability sessions during the surface milestones (close the primary-research gap).

## Limitations

Prior-art synthesis, not primary user testing; conclusions are hypotheses. Public reviews skew toward dissatisfied users. No quantitative data on relative tool usage. Re-test against real Desktop Frame users before treating any finding as settled.

## References

1. [MacOSPlatformResearch](MacOSPlatformResearch.md) · [DesignPhilosophy](../Design/DesignPhilosophy.md) · [UX/InteractionModel](../UX/InteractionModel.md).
2. Apple, "HIG — macOS / Widgets." https://developer.apple.com/design/human-interface-guidelines/
3. Tool documentation (public): Übersicht (tracesof.github.io/uebersicht), Rainmeter (rainmeter.net), Plash (App Store). Accessed 2026-06.

## Completion checklist
- [x] Method and sample stated, with limits.
- [x] Observation separated from inference; sources named.
- [x] Recommendations specific and routed to ADRs/UX docs.

## Review checklist
- [ ] Conclusions revisited after primary usability testing.
- [ ] Mirrored to the Notion Research DB.
- [ ] Meets DocumentationStandards.
