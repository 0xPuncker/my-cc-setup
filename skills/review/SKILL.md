---
name: review
description: Use after build has produced an implementation for a specs/<name>.md spec — checks the build against the spec requirement by requirement, lists every gap or bug with the exact spec item it fails, and only approves when all requirements are fully met.
---

# /review

Checks a build against its `specs/<name>.md` specification, requirement by requirement, and sends corrections back to `build`. Step 3 of the spec → build → review loop (see also `spec`, `build`).

This is distinct from Claude Code's built-in diff-review `/review` command: this one verifies the build against a written spec, not general git-diff code quality.

## Usage
```
/review <name>           # check the current build against specs/<name>.md
```

## What to do

1. Open `specs/<name>.md` and go through it **requirement by requirement** — not a general impression pass.
2. For each requirement, verify it against the actual current state of the code (read the code directly; don't rely solely on `build`'s self-reported checklist).
3. List every gap, bug, or missing item found, each one citing the **exact spec item** it fails (quote or reference the requirement).
4. If anything fails, write the specific corrections needed — concrete enough that `build` can implement them without re-interpreting the spec.
5. Only declare the build approved when every requirement in the spec is fully met. Partial credit is not approval — state clearly whether it's approved, and why.

## Loop back
If corrections are needed, hand them to `build` to implement, then re-run `review`. Repeat until approved.

## Common mistakes
- Reviewing "vibes" instead of the spec — every finding must trace to a specific spec requirement.
- Approving with known gaps because "it's close enough."
- Vague corrections ("improve error handling") instead of actionable ones tied to the failing requirement.
