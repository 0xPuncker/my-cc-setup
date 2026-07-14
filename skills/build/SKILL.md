---
name: build
description: Use when a specs/<name>.md file already exists and it's time to implement it — reads the spec and builds exactly what it describes, nothing more, nothing invented.
---

# /build

Reads a specification written by `spec` and implements exactly what it describes. Step 2 of the spec → build → review loop (see also `spec`, `review`).

## Usage
```
/build <name>            # build specs/<name>.md
/build                   # if only one spec exists; otherwise ask which one
```

`build` is invoked either directly by the user, or automatically by `review` as part of its autonomous loop — in the latter case, just do the work and report back; don't ask the user "should I proceed with this fix?" (that's not the same as asking when the spec is genuinely ambiguous, which is still fine).

## What to do

1. Read `specs/<name>.md` in full before writing any code.
2. Build exactly what the spec describes:
   - No extra features beyond what's written
   - No refactoring of unrelated/irrelevant code
   - No invented requirements that aren't in the spec — if something is genuinely ambiguous or missing, ask rather than guess
3. When corrections come back from `review`, treat them as scoped patches against the existing build — implement only what was flagged, re-checking each item it lists.
4. On completion, list the requirements from the spec that this build satisfies, item by item, so `review` can verify each one directly against the list.

## Common mistakes
- Adding functionality the spec didn't ask for ("while I'm here...") — flag it as a follow-up idea instead of building it.
- Silently interpreting an ambiguous requirement instead of asking.
- Reporting completion without an explicit per-requirement checklist — `review` needs that list to do its job.
