# Claude Code Setup Template

Personal template repository for consistent Claude Code configuration across projects. Includes security controls, permission management, and development guidelines.

## 🚀 Quick Start

**5-minute setup for new projects:**

1. Copy template files to your project:
   ```bash
   cp CLAUDE.md /path/to/project/
   cp -r .claude /path/to/project/
   cp .gitignore.template /path/to/project/.gitignore
   ```

2. Customize `CLAUDE.md` with your project's:
   - Purpose and tech stack
   - Development commands (build, test, lint)
   - Architecture (if complex)

3. Test it: Ask Claude Code to do a simple task

**Detailed instructions:** See [SETUP.md](SETUP.md) | **Checklist:** See [CHECKLIST.md](CHECKLIST.md)

## 📋 What This Provides

### 🔒 Security by Default
- **Protected files**: `.env*`, secrets, keys cannot be read/written
- **Approval prompts**: Asks before destructive operations (edit, delete, git push)
- **File access restrictions**: Automatic protection for sensitive patterns

### 📝 Consistent Conventions
- **Semantic Versioning**: MAJOR.MINOR.PATCH versioning
- **Git Flow**: Branching strategy (main, develop, feature/*)
- **Conventional Commits**: Standardized commit message format
- **Single-author commits**: No CoAuthored commits

### 🎯 Quality Guidelines
Based on [Andrej Karpathy's LLM coding principles](https://github.com/karpathy/llm.internals):

1. **Think Before Coding** - State assumptions, surface tradeoffs
2. **Simplicity First** - Minimum code, no speculative features
3. **Surgical Changes** - Touch only what you must
4. **Goal-Driven Execution** - Define success criteria, verify results

### ⚙️ Permission Modes

| Mode | Behavior | Best For |
|------|----------|----------|
| `default` | Prompts for writes/shell, no prompts for reads | **Most projects** (recommended) |
| `acceptEdits` | Auto-approves file edits, prompts for shell | High-volume editing, trusted projects |
| `auto` | Auto-approves most operations | Trusted projects, rapid prototyping |
| `bypassPermissions` | No prompts | **Use with extreme caution** |

## 📁 Repository Structure

```
my-cc-setup/
├── CLAUDE.md                 # Main configuration + development guidelines
├── .claude/
│   └── settings.json         # Permission controls and modes
├── .gitignore.template       # Template .gitignore with security rules
├── SETUP.md                  # Detailed setup instructions
├── CHECKLIST.md              # New project checklist
├── examples/                 # Tech stack examples
│   ├── CLAUDE.nodejs.md      # Node.js/Express/TypeScript example
│   ├── CLAUDE.python.md      # Django/Python example
│   └── CLAUDE.golang.md      # Go/Clean Architecture example
└── README.md                 # This file
```

## 🎯 Core Guidelines

### Think Before Coding
- State assumptions explicitly
- Present multiple interpretations
- Push back when simpler approaches exist
- Stop when confused and ask questions

### Simplicity First
- No features beyond what was asked
- No abstractions for single-use code
- If 200 lines could be 50, rewrite it

### Surgical Changes
- Touch only what you must
- Don't improve unrelated code
- Clean up only your own mess

### Goal-Driven Execution
- Define success criteria
- Loop until verified
- Write tests that reproduce bugs

## 🔐 Permission Examples

### ✅ No Prompt Needed
- Reading source code
- Searching with Grep/Glob
- Git status/log
- Read-only file operations

### ⚠️ Approval Required
- Editing files (Edit/Write tools)
- Running shell commands
- Git commits/pushes/merges
- Installing dependencies
- File deletion operations

### 🛡️ Never Allowed
- Reading `.env` files
- Writing to `secrets/` directories
- Accessing private keys (`*.pem`, `*.key`)
- Modifying `.ssh/` directories
- Reading `.aws/` configurations

## 📖 Documentation

| File | Purpose |
|------|---------|
| [SETUP.md](SETUP.md) | Detailed setup instructions with troubleshooting |
| [CHECKLIST.md](CHECKLIST.md) | Step-by-step checklist for new projects |
| [CLAUDE.md](CLAUDE.md) | Full development guidelines and conventions |
| [examples/](examples/) | Tech stack-specific templates |

## 🛠 How to Use This Template

### For New Projects

1. **Copy template files**:
   ```bash
   # Copy core configuration
   cp CLAUDE.md /path/to/project/
   cp -r .claude /path/to/project/
   cp .gitignore.template /path/to/project/.gitignore
   ```

2. **Customize CLAUDE.md**:
   - Edit "Project Purpose" section
   - Add tech stack
   - Add development commands (build, test, lint)
   - Add architecture if complex

3. **Verify settings**:
   ```bash
   # Check .claude/settings.json
   cat .claude/settings.json
   # Should show: "defaultMode": "auto", "permissionMode": "default"
   ```

4. **Test it**:
   - Ask Claude to read a file (no prompt)
   - Ask Claude to edit a file (prompts for approval)
   - Ask Claude to run a command (prompts for approval)

### For Existing Projects

Same steps, but be careful not to overwrite existing configuration:
- Review CLAUDE.md content before copying
- Merge settings with existing `.claude/settings.json`
- Add new rules to existing `.gitignore`

## 🎨 Customization Examples

### Add Development Commands

Edit CLAUDE.md to include your project's commands:

\`\`\`markdown
## Development Commands

### Building
\`\`\`bash
npm run build        # Node.js
cargo build          # Rust
go build             # Go
\`\`\`

### Testing
\`\`\`bash
npm test             # Node.js
cargo test           # Rust
go test ./...        # Go
\`\`\`

### Linting
\`\`\`bash
npm run lint         # Node.js
cargo clippy         # Rust
golangci-lint run    # Go
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
- **Fat Models, Thin Views**: Business logic in models
- **Dependency Injection**: Used throughout
- **Repository Pattern**: Data access abstraction
\`\`\`
\`\`\`

## 🎓 Learn More

### Key Concepts
- [Semantic Versioning](https://semver.org/)
- [Git Flow](https://danielkummer.github.io/git-flow-cheatsheet/)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [Karpathy's LLM Observations](https://github.com/karpathy/llm.internals)

### Claude Code Resources
- [Claude Code Documentation](https://claude.ai/code)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)
- [Claude Code Issues](https://github.com/anthropics/claude-code/issues)

## 🔍 Troubleshooting

### "Too many prompts"
- Change permission mode to `acceptEdits` in `.claude/settings.json`
- Auto-approves file edits, still prompts for shell commands

### "Claude can't read my config"
- Check if file is in protected list (CLAUDE.md Security section)
- Move non-sensitive config to unprotected location
- Update CLAUDE.md security rules if needed

### "Not enough prompts"
- Set permission mode to `default`
- Remove `alwaysAllowShell: true` if present

## 📦 License

Apache License 2.0 - Feel free to use and modify for your needs.

## 🤝 Contributing

This is a personal template. Feel free to fork and customize for your own workflow.

---

**Version:** 1.0.0 | **Last Updated:** 2025-05-05 | **Maintained:** @0xPuncker
