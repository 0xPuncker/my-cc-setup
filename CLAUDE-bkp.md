# Claude Code Configuration for Scratch Setups

## Karpathy-Inspired Development Guidelines

> Based on Andrej Karpathy's observations on LLM coding pitfalls to improve Claude Code behavior.

### The Four Core Principles

| Principle | Purpose |
|-----------|---------|
| **Think Before Coding** | Avoid wrong assumptions, hidden confusion, missing tradeoffs |
| **Simplicity First** | Prevent overcomplication and bloated abstractions |
| **Surgical Changes** | Minimize orthogonal edits and unnecessary changes |
| **Goal-Driven Execution** | Ensure verifiable success criteria |

#### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

- State assumptions explicitly — If uncertain, ask rather than guess
- Present multiple interpretations — Don't pick silently when ambiguity exists
- Push back when warranted — If a simpler approach exists, say so
- Stop when confused — Name what's unclear and ask for clarification

#### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked
- No abstractions for single-use code
- No "flexibility" or "configurability" that wasn't requested
- No error handling for impossible scenarios
- If 200 lines could be 50, rewrite it

**The test:** Would a senior engineer say this is overcomplicated? If yes, simplify.

#### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting
- Don't refactor things that aren't broken
- Match existing style, even if you'd do it differently
- If you notice unrelated dead code, mention it — don't delete it

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused
- Don't remove pre-existing dead code unless asked

**The test:** Every changed line should trace directly to the user's request.

#### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform imperative tasks into verifiable goals:

| Instead of... | Transform to... |
|---------------|-----------------|
| "Add validation" | "Write tests for invalid inputs, then make them pass" |
| "Fix the bug" | "Write a test that reproduces it, then make it pass" |
| "Refactor X" | "Ensure tests pass before and after" |

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

## Project-Specific Configuration

### Default Mode
```json
{
  "defaultMode": "auto"
}
```

### Commit Conventions

Follow strict commit standards:

1. **Semantic Versioning** (https://semver.org/)
   - MAJOR: Incompatible API changes
   - MINOR: Backwards-compatible functionality additions
   - PATCH: Backwards-compatible bug fixes

2. **Git Flow** (https://danielkummer.github.io/git-flow-cheatsheet/)
   - Use `main` for production releases
   - Use `develop` for integration
   - Use feature branches (`feature/`, `bugfix/`)
   - Use release branches (`release/`)
   - Use hotfix branches (`hotfix/`)
   - Use support branches (`support/`)

3. **Conventional Commits** (https://www.conventionalcommits.org/en/v1.0.0/)
   ```
   <type>[optional scope]: <description>

   [optional body]

   [optional footer(s)]
   ```

   **Types:**
   - `feat:` New feature
   - `fix:` Bug fix
   - `docs:` Documentation changes
   - `style:` Code style changes (formatting, etc.)
   - `refactor:` Code refactoring
   - `perf:` Performance improvements
   - `test:` Adding or updating tests
   - `build:` Build system or dependencies
   - `ci:` CI/CD changes
   - `chore:` Maintenance tasks
   - `revert:` Revert a previous commit

   **Examples:**
   - `feat: add user authentication`
   - `fix(api): resolve race condition in request handler`
   - `docs: update README with installation instructions`
   - `refactor(core): simplify error handling logic`

### Commit Guidelines

- **NO CoAuthored commits** — Single author commits only
- Write clear, descriptive commit messages
- Keep subject lines under 72 characters
- Use imperative mood ("add" not "added" or "adds")
- Reference issues in commit body or footer

## Security and Permissions

### Environment Protection

The following files and patterns are **protected** from read/write operations:

**Protected from Reading:**
- `.env*` files (all environment files)
- `.dev.vars*` files (development variables)
- `*.pem` files (private keys)
- `*.key` files (key files)
- `secrets/` directories
- `credentials/` directories
- `.aws/` directories (AWS configuration)
- `.ssh/` directories (SSH keys)
- `config/database.yml` (database configuration)
- `config/credentials.json` (credential files)
- `.npmrc` (NPM configuration)
- `.pypirc` (Python configuration)

**Protected from Writing:**
- `.env*` files
- `secrets/` directories
- `.ssh/` directories

**When environment access is needed:**
1. Ask the user to provide the specific value or configuration needed
2. Suggest creating template files (e.g., `.env.example`)
3. Document required environment variables without requesting sensitive values
4. Use placeholder values in examples

## Working Style

### Task Execution
1. Understand the goal before coding
2. Ask clarifying questions when uncertain
3. Present tradeoffs for significant decisions
4. Implement with simplicity in mind
5. Verify outcomes before claiming completion

### Code Quality
- Prefer straightforward solutions over clever ones
- Write code that's easy to delete, not easy to extend
- Don't add "flexibility" for hypothetical future needs
- Remove dead code you create, not pre-existing dead code
- Match existing patterns and conventions

### Testing Approach
- Write tests first when feasible (TDD)
- Ensure tests cover the happy path and error cases
- Run tests before committing
- Don't skip tests for "temporary" solutions

### When to Apply These Guidelines

**Full rigor for:**
- New features
- Bug fixes
- Refactoring
- Multi-step tasks
- Non-trivial changes

**Lighter touch for:**
- Typo fixes
- Simple one-liners
- Obvious corrections
- Documentation updates

## Key Insight

> "LLMs are exceptionally good at looping until they meet specific goals... Don't tell it what to do, give it success criteria and watch it go."

Use goal-driven execution with verification loops rather than imperative instructions.

## How to Know It's Working

These guidelines are effective when you see:
- Fewer unnecessary changes in diffs
- Fewer rewrites due to overcomplication
- Clarifying questions come before implementation
- Clean, minimal commits
- No drive-by refactoring or "improvements"

## Tradeoff Note

These guidelines bias toward **caution over speed**. For trivial tasks, use judgment — not every change needs full rigor. The goal is reducing costly mistakes on non-trivial work, not slowing down simple operations.
