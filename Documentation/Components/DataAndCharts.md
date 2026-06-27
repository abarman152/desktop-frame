---
title: Data and charts
status: Active
owner: Product Designer
created: 2026-06-27
updated: 2026-06-27
review_by: 2026-09-27
related: [ComponentArchitecture.md, Surfaces.md, ../Design/ColorSystem.md, ../Architecture/SystemServices.md, ../Design/MotionSystem.md]
---

# Data and charts

The components that show live system data: the Metric Card and the CPU, memory, battery, and network graphs. They update frequently and run on the desktop indefinitely, so they are designed around **calm, legible, cheap** updates ([principle 3](../Design/DesignPhilosophy.md), [PerformanceStandards](../Standards/PerformanceStandards.md)). They build on the Widget Card ([Surfaces](Surfaces.md)) and read from the actor system services ([SystemServices](../Architecture/SystemServices.md)).

## Purpose and scope

In scope: the metric card and the four live graphs. Out of scope: the data providers and refresh model ([SystemServices](../Architecture/SystemServices.md)) and the information widgets ([Widgets](Widgets.md)).

## Shared behaviour

- **Source.** Data comes from the actor services at their defined refresh intervals — CPU 1 s, memory/network 2 s, battery 10 s, storage 30 s ([Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift) `RefreshInterval`). The component never polls hardware itself.
- **Legibility.** Numerics use monospaced digits so values do not jitter on update ([Typography](../Design/Typography.md)); units are always shown; values are formatted with `FormatStyle` (byte counts, percentages, rates).
- **Calm updates.** Updates cross-fade or interpolate over `motion.fast`, never flash; a metric crossing a threshold changes a paired icon/label, not just colour ([ColorSystem](../Design/ColorSystem.md)).
- **Thresholds.** Optional warning/critical thresholds map to `warning`/`danger` *plus* an icon, never colour alone.

## Metric Card

- **Purpose.** One system metric at a glance: current value, label, trend sparkline.
- **Variants.** Value-only · Value + sparkline · Value + delta.
- **States.** Rest · Loading (skeleton) · No-data/permission-needed (empty) · Error · Threshold-exceeded.
- **Sizing.** Size-class layouts: compact = value only; regular = value + sparkline; expanded = value + sparkline + min/max.
- **Spacing.** `m` padding; hero value uses `display`/`mono`.
- **Accessibility.** Label + value exposed as one element ("CPU, 42 percent"); sparkline summarised, not read point-by-point; threshold state announced.
- **Animation.** Value interpolates `motion.fast`; sparkline appends without full redraw.
- **Performance.** Sparkline keeps a bounded ring of samples; redraw only on new sample, only when visible.
- **Guidelines.** Show one metric well; for multiple, use multiple cards, not a crowded one.

## CPU / Memory / Battery / Network graphs

- **Purpose.** A live time-series of one metric.
- **Variants.** Line · Area · Bars (per metric default: CPU/network line, memory area, battery level/state).
- **States.** Rest · Loading · No-data/permission-needed · Error · Paused (off-screen/occluded).
- **Sizing.** Size-class: compact = sparkline; regular = labelled axes; expanded = legend + min/avg/max.
- **Spacing.** Axis labels `caption`; `m` plot insets.
- **Accessibility.** Exposes current value, range, and trend as text (an "audio chart"-style summary); axes labelled; not colour-dependent — series differ by label/position too.
- **Animation.** New samples slide in over `motion.fast`; the window scrolls smoothly; Reduce Motion → step updates without sliding.
- **Performance.** Fixed-length sample window (a ring buffer); draws only the visible window; pauses when occluded or the display sleeps; respects the metric's refresh interval rather than animating per frame. A graph is a frequent perf offender, so it is held to the [RenderingEngine](../Architecture/RenderingEngine.md) budget.
- **Guidelines.** Default to a calm, low-saturation series; one metric per graph; make the current value the most legible element.

### Per-metric notes

- **CPU** — per-core optional in expanded; 1 s cadence; spikes are smoothed lightly, never exaggerated.
- **Memory** — used/available; pressure state as a paired icon; 2 s cadence.
- **Battery** — level + charging/connected state (multicolor/variable symbol); time-remaining where available; 10 s cadence.
- **Network** — up/down rates with byte-count formatting; two series distinguished by label and position, not colour alone; 2 s cadence.

## Trade-offs

- Calm, smoothed updates trade real-time precision for legibility and lower cost; acceptable for ambient widgets, with an expanded mode for detail.
- Bounded sample windows limit historical depth on the surface; long history is out of scope for a desktop widget.

## Future evolution

User-configurable thresholds and ranges; an optional longer-history expanded view; additional metrics (GPU, disk I/O, sensors) as services are added ([SystemServices](../Architecture/SystemServices.md)). Third-party data widgets reuse the same card/graph primitives via the SDK.

## Open questions

- Whether to expose per-core CPU by default in the expanded size or keep it opt-in.

## References

1. [SystemServices](../Architecture/SystemServices.md) · [Surfaces](Surfaces.md) · [RenderingEngine](../Architecture/RenderingEngine.md) · [Constants.swift](../../desktop-frame/Core/Utilities/Constants.swift).
2. Apple, "HIG — Charting data." https://developer.apple.com/design/human-interface-guidelines/charts
3. Apple, "Swift Charts." https://developer.apple.com/documentation/charts

## Completion checklist
- [x] Metric card and four graphs specified against the schema.
- [x] Refresh cadence anchored to RefreshInterval constants.
- [x] Calm-update, accessibility, and performance rules stated.

## Review checklist
- [ ] Reconciled with SystemServices providers and refresh intervals.
- [ ] Accessibility "audio chart" summaries verified.
- [ ] Meets DocumentationStandards.
