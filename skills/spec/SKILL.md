---
name: spec
description: Use at the start of a new feature or app idea, before any code is written or planned in detail — interviews the user one question at a time until the goal, requirements, constraints, and definition of "done" are fully understood, then writes the result to specs/<name>.md for build and review to consume.
---

# /spec

Turns a vague idea into a written specification other skills can build and verify against. Step 1 of the spec → build → review loop (see also `build`, `review`).

## Usage
```
/spec                    # interview about a new feature/app, then write specs/<name>.md
```

## What to do

1. Interview the user about the feature or app they want to build. Ask **one specific question at a time** — do not batch multiple questions, do not move to the next question until the current answer is understood.
2. Keep asking until you fully understand:
   - The objective (what problem this solves, for whom)
   - The exact requirements (what must be true when it's done)
   - The constraints (tech stack, performance, compatibility, and anything it must NOT do)
   - What "done" means concretely — criteria someone else could use to verify the build
3. Do not start building, do not propose code, do not sketch architecture during the interview. This step produces a spec, nothing else.
4. Once there is enough information, write a clear, detailed specification and save it to `specs/<name>.md` (derive `<name>` from the feature; create the `specs/` directory if it doesn't exist).

The spec file must include:
- **Objective** — what this is and why
- **Requirements** — the exact, testable requirements
- **Edge cases** — the specific edge cases to handle
- **Definition of done** — concrete, verifiable criteria (this is what `review` will check against)

## Common mistakes
- Asking several questions in one message — slows convergence and lets ambiguity slide through unnoticed. One question at a time.
- Writing the spec before constraints and "done" criteria are pinned down.
- Starting to implement or design during the interview — that belongs to `build`.
