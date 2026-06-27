---
title: Performance report — <change>
status: Draft
owner: Performance
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
related: []
---

<!--
TEMPLATE: Performance report. Required for hot-path and rendering changes. Follows
../Standards/PerformanceStandards.md. Measure with Instruments; never estimate.
-->

# Performance report — <change>

## Change under test

What was measured and why.

## Method

The Instruments templates used, the hardware and displays, and the scenario. Reproducible.

## Results

Before and after numbers for the relevant budget metrics: idle and active CPU, memory, frame and render time, energy. A table is clearest.

## Budget check

Whether each metric is within the budget in ../Standards/PerformanceStandards.md. Pass or fail per metric.

## Findings

What the data shows, including any regression and its cause.

## Completion checklist
- [ ] Measured in Instruments, not estimated.
- [ ] Before and after numbers for each relevant metric.
- [ ] Budget pass/fail stated per metric.
- [ ] Hardware and scenario recorded for reproducibility.

## Review checklist
- [ ] Numbers support the conclusion.
- [ ] No metric regressed without justification.
- [ ] Meets DocumentationStandards.
