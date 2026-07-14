# Spec -> Build -> Review Example

Walkthrough of installing and using the `spec`, `build`, and `review` skills for a small, concrete feature.

## 1. Install

```bash
npx github:0xPuncker/my-cc-setup
```

This copies `spec/`, `build/`, `review/` into `~/.claude/skills`. Restart Claude Code (or start a new session) so it picks them up.

## 2. Run `/spec`

```
You: /spec

Claude: What feature or app do you want to build?
You: A CLI command that counts words in a text file.

Claude: What should the command be called, and how does the user pass it a file?
You: `wordcount <file>` - takes one file path as an argument.

Claude: Should it count words only, or also lines and characters?
You: Just words for now.

Claude: What should happen if the file doesn't exist or is empty?
You: Missing file -> print an error and exit non-zero. Empty file -> print 0.

Claude: Got it - I have enough to write the spec.
```

Result: `specs/wordcount.md`

```markdown
# wordcount

## Objective
A CLI command that counts the words in a text file.

## Requirements
- `wordcount <file>` prints the word count of `<file>` to stdout
- Words are separated by whitespace
- Missing file: print an error message to stderr, exit code 1
- Empty file: print `0`, exit code 0

## Edge cases
- File path does not exist
- Empty file
- File with only whitespace (counts as 0 words)

## Definition of done
- `wordcount tests/fixtures/hello.txt` (containing "hello world") prints `2`
- `wordcount tests/fixtures/empty.txt` prints `0`
- `wordcount tests/fixtures/missing.txt` prints an error to stderr and exits 1
```

## 3. Run `/build`

```
You: /build wordcount
```

Claude reads `specs/wordcount.md`, implements `wordcount`, and reports:

```
Implemented:
- [x] wordcount <file> prints word count to stdout
- [x] words split on whitespace
- [x] empty file prints 0, exit 0
- [ ] missing file: currently throws an unhandled exception instead of a clean error + exit 1
```

Note the honest checklist - it flags the one requirement it didn't fully meet, rather than silently glossing over it.

## 4. Run `/review`

```
You: /review wordcount
```

Claude checks the code against every requirement in `specs/wordcount.md`:

```
Result: NOT APPROVED

Gaps found:
1. Fails "Missing file: print an error message to stderr, exit code 1"
   - Current behavior: unhandled exception + stack trace, exit code 1 only by accident
   - Fix: catch the file-read error explicitly, print "Error: file not found" to stderr, exit(1)

All other requirements pass.
```

## 5. Back to `/build` with the correction

```
You: /build wordcount
```

Claude applies just the flagged fix (catches the missing-file case cleanly) - no unrelated changes.

## 6. Run `/review` again

```
You: /review wordcount

Claude: Result: APPROVED - all requirements in specs/wordcount.md are met.
```

Loop `/build` <-> `/review` until you see `APPROVED`.
