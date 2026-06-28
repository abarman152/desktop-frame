---
title: Marketplace
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, README.md, ../Architecture/PluginSDK.md, ../Design/Iconography.md, StatesAndFeedback.md]
---

# Marketplace

The components for discovering, installing, and managing third-party widgets and themes: the Plugin Card (an installed/manageable item) and the Marketplace Card (a discoverable item in the catalogue). They are the surface of the platform ambition, so they must make third-party content feel native and trustworthy ([PluginSDK](../Architecture/PluginSDK.md)). Shared state/variant meaning is in [ComponentArchitecture](ComponentArchitecture.md).

## Purpose and scope

In scope: the Plugin Card and Marketplace Card. Out of scope: the plugin runtime, sandbox, and review pipeline ([PluginSDK](../Architecture/PluginSDK.md), [ADR-0007](../Decisions/ADR-0007-out-of-process-plugin-isolation.md)) and the gallery container ([Navigation](Navigation.md)).

## Marketplace Card

- **Purpose.** A discoverable widget/theme in the catalogue: identity, value, trust signals.
- **Anatomy.** Author icon ([Iconography](../Design/Iconography.md)) · name · one-line description · author · trust badges (verified, permissions summary) · price/free · install action.
- **Variants.** Widget · Theme · Featured (larger) · Compact (list).
- **States.** Rest · Hover (lift) · Focused · Installing (progress) · Installed · Update-available · Incompatible (disabled + reason).
- **Sizing.** Adaptive gallery cell ([LayoutAndSpacing](../Design/LayoutAndSpacing.md)); featured spans more.
- **Accessibility.** Name/author/description as text; trust badges labelled, not icon-only; install is keyboard-reachable; price exposed.
- **Animation.** Hover lift `motion.fast`; install shows determinate progress ([Overlays](Overlays.md)).
- **Performance.** Lazy thumbnails, cached; gallery virtualised for large catalogues ([EngineeringHandoff](../Design/EngineeringHandoff.md)).
- **Guidelines.** Lead with what it does and who made it; surface the permissions it will request *before* install (honest, not buried); incompatible items say why.

## Plugin Card

- **Purpose.** A manageable installed widget/theme in Settings → Plugins ([UX/SettingsUX](../UX/SettingsUX.md)).
- **Anatomy.** Icon · name/version · status (enabled/disabled/needs-permission/error) · permissions granted · actions (enable, configure, update, remove).
- **Variants.** Widget plugin · Theme plugin · Built-in (non-removable, marked).
- **States.** Enabled · Disabled · Update-available · Permission-needed · Error/quarantined · Removing.
- **Sizing.** List row or card in the plugins pane.
- **Accessibility.** Status announced (not colour-only); each action labelled and keyboard-reachable; destructive remove confirms ([Overlays](Overlays.md)).
- **Animation.** State changes `motion.fast`; remove animates out and is undoable.
- **Performance.** Reflects plugin state via observation; no polling.
- **Guidelines.** Make permissions and status legible and honest; a misbehaving/quarantined plugin is clearly marked with a safe action; removal is reversible where possible. Third-party identity stays within the icon spec so the list looks coherent ([Iconography](../Design/Iconography.md)).

## Trust and safety in the design

The cards are where trust is earned: permissions are shown before install and visible after; an out-of-process or quarantined plugin is clearly flagged ([ADR-0007](../Decisions/ADR-0007-out-of-process-plugin-isolation.md)); verified authors carry a labelled badge. The design never hides what a plugin can access — that honesty is a feature, aligned with the privacy stance ([SecurityStandards](../Standards/SecurityStandards.md)).

## Accessibility

All trust/status signals are text or labelled icons, never colour or badge shape alone; install/manage actions are fully keyboard and VoiceOver operable; empty/no-results and offline states use the shared patterns ([StatesAndFeedback](StatesAndFeedback.md)).

## Trade-offs

- Surfacing permissions prominently may lower install conversion versus hiding them; accepted — trust is the platform's moat.
- Constraining third-party identity to the icon spec limits author branding in exchange for a coherent, trustworthy catalogue.

## Future evolution

Ratings, collections, and richer detail pages as the marketplace matures; the cards are the entry points to those. Theme distribution reuses the same cards once third-party theming opens ([ThemeArchitecture](../Design/ThemeArchitecture.md)).

## Open questions

- How much permission detail to show on the card versus a detail sheet before install.

## References

1. [PluginSDK](../Architecture/PluginSDK.md) · [ADR-0007](../Decisions/ADR-0007-out-of-process-plugin-isolation.md) · [SecurityStandards](../Standards/SecurityStandards.md) · [StatesAndFeedback](StatesAndFeedback.md).
2. Apple, "HIG — Managing accounts / In-app purchase patterns." https://developer.apple.com/design/human-interface-guidelines/

## Completion checklist
- [x] Plugin and Marketplace cards specified against the schema.
- [x] Permissions-before-install and trust signals stated.
- [x] Accessibility of status/trust signals covered.

## Review checklist
- [ ] Reconciled with PluginSDK permission and review model.
- [ ] Trust signals verified non-colour-dependent.
- [ ] Meets DocumentationStandards.
