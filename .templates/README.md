# .templates

Non-document scaffolding: the boilerplate that new code and modules start from. This is distinct from `Documentation/Templates/`, which holds the Markdown document templates.

## What belongs here

- Source-file headers (the standard comment block for a new Swift file).
- New-module or new-feature skeletons (the folder and file layout a new `Features/` slice starts with).
- Any reusable code scaffold that is copied, not imported.

## What does not belong here

- Document templates. Those live in `Documentation/Templates/`.
- GitHub issue and PR templates. Those live in `.github/`.
- Anything that should be compiled as part of the app. Scaffolds here are inert until copied.

## Usage

Copy a scaffold into place, rename, and fill it in. Scaffolds follow the same standards as the code they become: [SwiftStyleGuide](../Documentation/Standards/SwiftStyleGuide.md) and [NamingConventions](../Documentation/Standards/NamingConventions.md).
