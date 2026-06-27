---
title: Documentation style guide
status: Active
owner: Documentation Lead
created: 2026-06-26
updated: 2026-06-26
review_by: 2026-09-26
related: [DocumentationStandards.md, ../Processes/CommunicationGuidelines.md]
---

# Documentation style guide

How documentation is written, as distinct from how it is structured. Structure, naming, frontmatter, and placement are in [DocumentationStandards.md](DocumentationStandards.md). This document governs the prose itself.

## The standard

Write the way a competent engineer writes when they know the subject and respect the reader's time. Plain, specific, and honest. The project applies the anti-AI writing doctrine to every written artifact, which forbids the patterns that make text read as machine-generated.

## Rules that matter most

- Use plain verbs. A subsystem is a hub; it does not "serve as" one. A type has properties; it does not "boast" them.
- Be specific. "Reduced idle CPU from 1.2% to 0.4%" beats "improved performance significantly."
- Headings are sentence case and describe content, not importance.
- No padding by rule of three, no em dash used for drama, no "not just X but Y" constructions.
- No conclusion that restates the document. End on the last useful sentence.
- No vague attributions. Name the source or cut the claim.
- Distinguish verified fact, inference, and opinion, the same convention the Product and Engineering documentation use.
- Minimal bold. Bold is for the first definition of a term, not for emphasis scattered through prose.

## Claim tagging

Consequential claims are tagged verified, inference, or judgment, and the verified ones carry a numbered reference. This convention runs through the whole knowledge base so a reader always knows whether they are reading a fact or a recommendation.

## Code and examples

Fence code with its language. Examples compile or are marked illustrative. Keep examples minimal, showing the pattern rather than a whole file.

## Review

Documentation prose is reviewed in the pull request that contains it. A reviewer who spots a machine-tell (a banned construction, a vague attribution, a restated conclusion) sends it back, the same as a code-style violation.
