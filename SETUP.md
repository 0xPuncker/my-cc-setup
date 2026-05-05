# Project Setup Guide

This guide helps you set up a new project using this Claude Code configuration template.

## Quick Start (Manual Copy-Paste)

### Step 1: Copy Template Files

Copy these files to your new project root:
```
CLAUDE.md          # Claude Code configuration and guidelines
.claude/settings.json  # Claude Code permissions and settings
```

### Step 2: Customize CLAUDE.md

Edit the `CLAUDE.md` header to match your project:

```markdown
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

[Your project name and purpose here]

## Tech Stack

[Main technologies, frameworks, and tools]

## Development Commands

[Add build, test, lint commands here]
```

### Step 3: Verify Settings

Check that `.claude/settings.json` has the right permission mode:
- `"defaultMode": "auto"` - Claude asks before running commands
- `"permissionMode": "default"` - Standard permission prompts
- `"alwaysAllowReadOnly": true` - Allows read operations without prompts

## What Gets Configured

### ✅ Automatic Permissions (No Prompt)
- Reading files (Read tool)
- Searching code (Grep, Glob)
- Read-only git operations (git status, git log)

### ⚠️ Approval Required (Prompts)
- Writing/editing files (Edit, Write tools)
- Running shell commands (Bash tool)
- Git operations that modify state (commit, push, merge)
- Installing packages or dependencies
- File deletion operations

### 🛡️ Protected Files (Cannot Read/Write)
- `.env*` files (environment variables)
- `.dev.vars*` files (development secrets)
- `*.pem`, `*.key` files (private keys)
- `secrets/`, `credentials/` directories
- `.aws/`, `.ssh/` directories
- Database configuration files

## Customizing for Your Project

### Add Development Commands

Edit CLAUDE.md to include your project's commands:

\`\`\`markdown
## Development Commands

### Building
\`\`\`bash
npm run build
# or
cargo build
# or
go build
\`\`\`

### Testing
\`\`\`bash
npm test
# or
cargo test
# or
go test ./...
\`\`\`

### Linting
\`\`\`bash
npm run lint
# or
cargo clippy
\`\`\`

### Running the Application
\`\`\`bash
npm start
# or
cargo run
\`\`\`
\`\`\`

### Add Architecture Documentation

For complex projects, add to CLAUDE.md:

\`\`\`markdown
## Architecture

### Directory Structure
\`\`\`
src/
├── core/           # Core business logic
├── api/            # API handlers and routing
├── models/         # Data models and schemas
└── utils/          # Shared utilities
\`\`\`

### Key Patterns
- **Dependency Injection**: Used in src/core/
- **Repository Pattern**: Data access in src/models/
- **Middleware Stack**: Request processing in src/api/
\`\`\`

## Permission Levels

You can adjust the permission mode in `.claude/settings.json`:

### `"permissionMode": "default"` (Recommended)
- Prompts for write operations
- Prompts for shell commands
- No prompts for read operations

### `"permissionMode": "acceptEdits"`
- Auto-approves file edits/writes
- Still prompts for shell commands
- Good for trusted projects with frequent edits

### `"permissionMode": "auto"`
- Auto-approves most operations
- Use with caution on trusted projects only

### `"permissionMode": "bypassPermissions"`
- No prompts for anything
- **Use with extreme caution only**

## File Access Rules

The security rules in CLAUDE.md define what Claude Code can access:

### Reading
- Can read: Source code, documentation, config files
- Cannot read: `.env*`, secrets, private keys, credentials

### Writing
- Can write: Source code, docs, non-sensitive config
- Cannot write: `.env*`, secrets/, .ssh/

### When Claude Needs Access
If Claude needs environment values:
1. It will ask you to provide them
2. It will suggest creating `.env.example` templates
3. It will use placeholders in examples

## Verification Checklist

After setting up a new project, verify:

- [ ] CLAUDE.md exists in project root
- [ ] .claude/settings.json exists
- [ ] CLAUDE.md customized with project purpose
- [ ] Development commands added to CLAUDE.md
- [ ] Architecture documented (if complex)
- [ ] .gitignore includes sensitive files
- [ ] Tested Claude Code with a simple task

## Example .gitignore Entries

Add these to protect sensitive files:

\`\`\`gitignore
# Environment variables
.env
.env.local
.env.*.local

# Secrets
secrets/
credentials/
*.pem
*.key

# IDE
.vscode/
.idea/
*.swp
\`\`\`

## Troubleshooting

### Claude Can't Read Config Files
- Check if file is in protected list (CLAUDE.md Security section)
- Move non-sensitive config to unprotected location
- Update CLAUDE.md if needed

### Too Many Prompts
- Consider changing permission mode to `"acceptEdits"`
- Add project-specific trusted patterns

### Not Enough Prompts
- Set permission mode to `"default"`
- Remove `"alwaysAllowShell": true` if present

## Next Steps

1. Copy template files to your new project
2. Customize CLAUDE.md with project-specific info
3. Test with a simple Claude Code task
4. Adjust permissions based on your comfort level
5. Commit the configuration to your repo

## Need Help?

- Check [Claude Code Documentation](https://claude.ai/code)
- Review the main CLAUDE.md file for detailed guidelines
- Adjust permission mode in `.claude/settings.json`
