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

## Autonomous loop
This loop runs itself — do not stop and wait for the user between rounds.

1. If gaps are found, invoke `build` yourself right now with the specific corrections. Do not ask the user to run `/build` — call it directly and continue.
2. As soon as `build` reports back, immediately re-run this review's checklist again. Do not pause for confirmation.
3. Repeat automatically. Announce the round number each time (`Round 3/15`) so progress is visible even mid-loop.
4. Default cap: **15 rounds**. If the user specified a different number (in this request or an earlier one in the conversation), use that instead of 15.
5. Stop and hand control back to the user when — and only when — one of these three things happens:
   - **Approved** — every requirement is met.
   - **Cap reached** — report the round count, the requirements still failing, and what was tried each round.
   - **Stalled** — the same requirement fails two rounds in a row with no change in the diagnosis. Stop immediately rather than burning the rest of the cap on a loop that isn't converging.

### Cost discipline (this is the token guardrail — see note below)
- Each round, re-check only the requirements that previously failed plus anything the new build touched. Don't re-read the whole codebase or restate the full spec every round.
- Keep each round's report to the delta (what changed, what still fails) — not a full re-summary of prior rounds.
- The round cap is the hard backstop: worst case this loop costs ~15 build+review round-trips, never unbounded.

**Why this is the guardrail, not a token counter:** a skill is just instructions loaded into the conversation — there's no tool here that reports "tokens spent so far" for a plain skill to check mid-loop. The round cap plus stall detection plus per-round scoping is what actually bounds the cost; treat 15 as a hard ceiling, not a suggestion. (If real token-budget accounting is needed — an actual `budget.remaining()` check — that requires running this as a Workflow script instead of a skill; ask for that explicitly if you want it.)

## Common mistakes
- Reviewing "vibes" instead of the spec — every finding must trace to a specific spec requirement.
- Approving with known gaps because "it's close enough."
- Vague corrections ("improve error handling") instead of actionable ones tied to the failing requirement.
- Stopping to ask "should I proceed with the fix?" after finding a gap — don't; invoke `build` yourself and keep going.
- Letting a stalled loop run to the full cap instead of recognizing two identical failures in a row and stopping early.
