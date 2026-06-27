<!--
Pull requests are small and single-purpose. Follow Documentation/Processes/GitWorkflow.md.
Fill every section. The reviewer runs Documentation/Standards/ReviewChecklist.md.
-->

## What and why

What this change does, and the reason for it. Link the issue: Closes #.

## Type

- [ ] feat
- [ ] fix
- [ ] refactor
- [ ] perf
- [ ] docs
- [ ] test
- [ ] build
- [ ] chore

## Changes

A short list of the substantive changes.

## Testing

What tests were added or updated, and how this was verified. For a bug fix, confirm a test fails without the fix.

## Impact

- Performance: any effect on the budget, with measurement if in a hot path.
- Security: any change to data handling, permissions, or APIs.
- Accessibility: any new or changed interactive element.
- Plugin API or data format: any breaking change, with a link to the migration guide.

## Documentation

Which documents were updated. An architecture change links its ADR. A new doc updates the Notion Documentation Index.

## Review checklist

- [ ] I ran [Documentation/Standards/ReviewChecklist.md](../Documentation/Standards/ReviewChecklist.md) and every item passes or has a noted exception.
- [ ] This PR is single-purpose and follows the commit convention.
