# Contributing to Desktop Frame

Thank you for wanting to help build Desktop Frame. This guide gets you from idea to merged change. It points to the governance documents rather than repeating them, so there is one source for each rule.

## Before you start

- Read [/CLAUDE.md](../CLAUDE.md). It is the operating constitution for everyone, human and AI.
- Read the [documentation map](../Documentation/README.md) to find your way around.
- For a code change, read the matching role in [.agents/](../.agents/AGENTS.md) and the relevant [standards](../Documentation/Standards).

## The workflow

Desktop Frame follows the nine-phase task workflow in [.agents/AGENTS.md](../.agents/AGENTS.md): research, plan, architecture review, implement, test, document, review, retrospect, release. The short version for a typical change:

1. Find or open an issue describing the work.
2. Branch from `main` per [BranchingStrategy.md](../Documentation/Standards/BranchingStrategy.md).
3. If the change touches architecture, write an ADR first ([Decisions](../Documentation/Decisions/README.md)).
4. Implement in small steps, keeping the build green. Follow the [Swift style guide](../Documentation/Standards/SwiftStyleGuide.md).
5. Add tests. A bug fix adds a test that fails without the fix.
6. Update any documentation the change affects, in the same PR.
7. Open a pull request using the template; run the [review checklist](../Documentation/Standards/ReviewChecklist.md).

## Commits and branches

Commits follow [CommitConvention.md](../Documentation/Standards/CommitConvention.md). Branches follow [BranchingStrategy.md](../Documentation/Standards/BranchingStrategy.md). One logical change per commit; small, single-purpose pull requests.

## Quality bar

Every change clears the [quality gates](../Documentation/Processes/QualityGates.md): architecture, code quality, testing, performance, security, accessibility, UX, documentation, maintainability, and consistency. The performance and security budgets are release gates, not aspirations.

## What we will not accept

The forbidden practices in [/CLAUDE.md](../CLAUDE.md): non-native UI toolkits, private Apple APIs, force unwraps without an invariant, silent error swallowing, massive one-shot refactors, placeholder code, and committed TODOs presented as finished work.

## Reporting bugs and requesting features

Use the issue templates. Bugs follow [BugManagement.md](../Documentation/Processes/BugManagement.md). Ideas can start in Discussions before becoming a feature request.

## Code of conduct

Participation is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). Be respectful and constructive.
