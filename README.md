# Claude Code Setup Template

![Claude Code Template](https://img.shields.io/badge/Claude_Code_Template-v1.0.0-blue?style=flat-square)
![License](https://img.shields.io/badge/License-Apache_2.0-green?style=flat-square)
![Last Updated](https://img.shields.io/badge/Updated-2026-05-05-yellow?style=flat-square)
![Maintained](https://img.shields.io/badge/Maintained-@0xPuncker-brightgreen?style=flat-square)

Personal template repository for consistent Claude Code configuration across projects. Includes security controls, permission management, and development guidelines.

## Quick Start

**Option 1: Automated Setup (Recommended)**

Run the setup script from your new project directory:

```bash
# From the template repository
./setup.sh /path/to/project "Project Name" "TechStack"

# Or with PowerShell (Windows)
.\setup.ps1 -ProjectPath "C:\path\to\project" -ProjectName "My API Project" -TechStack "Node.js, Express, TypeScript"
```

**Option 2: Manual Setup (5 minutes)**

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

**Detailed instructions:** See [docs/SETUP.md](docs/SETUP.md) | **Checklist:** See [docs/CHECKLIST.md](docs/CHECKLIST.md)

## Spec → Build → Review Skills (npx)

Installs three Claude Code skills implementing a spec-driven development loop, globally to `~/.claude/skills`:

```bash
npx github:0xPuncker/my-cc-setup
```

| Skill | Command | Does |
| --- | --- | --- |
| `spec` | `/spec` | Interviews you one question at a time, writes `specs/<name>.md` |
| `build` | `/build` | Reads the spec, implements exactly what it describes |
| `review` | `/review` | Checks the build against the spec requirement-by-requirement, sends corrections back to `/build` |

Run `/spec` to start; loop `/build` → `/review` until review approves.

**Full walkthrough:** See [docs/SPEC_BUILD_REVIEW_EXAMPLE.md](docs/SPEC_BUILD_REVIEW_EXAMPLE.md)

## What This Provides

### Security by Default

- **Protected files**: `.env*`, secrets, keys cannot be read/written
- **Approval prompts**: Asks before destructive operations (edit, delete, git push)
- **File access restrictions**: Automatic protection for sensitive patterns

### Consistent Conventions

- **Semantic Versioning**: MAJOR.MINOR.PATCH versioning
- **Git Flow**: Branching strategy (main, develop, feature/\*)
- **Conventional Commits**: Standardized commit message format
- **Single-author commits**: No CoAuthored commits

### Quality Guidelines

Based on [Andrej Karpathy's LLM coding principles](https://github.com/karpathy/llm.internals):

1. **Think Before Coding** - State assumptions, surface tradeoffs
2. **Simplicity First** - Minimum code, no speculative features
3. **Surgical Changes** - Touch only what you must
4. **Goal-Driven Execution** - Define success criteria, verify results

### Permission Modes

| Mode                | Behavior                                       | Best For                              |
| ------------------- | ---------------------------------------------- | ------------------------------------- |
| `default`           | Prompts for writes/shell, no prompts for reads | **Most projects** (recommended)       |
| `acceptEdits`       | Auto-approves file edits, prompts for shell    | High-volume editing, trusted projects |
| `auto`              | Auto-approves most operations                  | Trusted projects, rapid prototyping   |
| `bypassPermissions` | No prompts                                     | **Use with extreme caution**          |

## Repository Structure

```
my-cc-setup/
├── CLAUDE.md                 # Main configuration + development guidelines
├── .claude/
│   └── settings.json         # Permission controls and modes
├── .gitignore.template       # Template .gitignore with security rules
├── setup.sh                  # Unix/Linux/macOS setup script
├── setup.ps1                 # Windows PowerShell setup script
├── docs/                     # Documentation
│   ├── SETUP.md              # Detailed setup instructions
│   ├── CHECKLIST.md          # New project checklist
│   ├── GLOBAL_SETUP.md       # Global configuration guide
│   ├── PROJECT_OVERRIDE.md   # Project-specific override guide
│   └── GITHUB_ABOUT.md       # GitHub repository setup
├── examples/                 # Tech stack examples
│   ├── CLAUDE.nodejs.md      # Node.js/Express/TypeScript example
│   ├── CLAUDE.python.md      # Django/Python example
│   └── CLAUDE.golang.md      # Go/Clean Architecture example
└── README.md                 # This file
```

## Core Guidelines

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

## Permission Examples

### No Prompt Needed

- Reading source code
- Searching with Grep/Glob
- Git status/log
- Read-only file operations

### Approval Required

- Editing files (Edit/Write tools)
- Running shell commands
- Git commits/pushes/merges
- Installing dependencies
- File deletion operations

### Never Allowed

- Reading `.env` files
- Writing to `secrets/` directories
- Accessing private keys (`*.pem`, `*.key`)
- Modifying `.ssh/` directories
- Reading `.aws/` configurations

## Documentation

| File                                                 | Purpose                                          |
| ---------------------------------------------------- | ------------------------------------------------ |
| [docs/SETUP.md](docs/SETUP.md)                       | Detailed setup instructions with troubleshooting |
| [docs/CHECKLIST.md](docs/CHECKLIST.md)               | Step-by-step checklist for new projects          |
| [docs/GLOBAL_SETUP.md](docs/GLOBAL_SETUP.md)         | Global configuration guide                       |
| [docs/PROJECT_OVERRIDE.md](docs/PROJECT_OVERRIDE.md) | Project-specific override guide                  |
| [docs/GITHUB_ABOUT.md](docs/GITHUB_ABOUT.md)         | GitHub repository setup                          |
| [docs/SPEC_BUILD_REVIEW_EXAMPLE.md](docs/SPEC_BUILD_REVIEW_EXAMPLE.md) | Spec -> build -> review loop walkthrough example |
| [CLAUDE.md](CLAUDE.md)                               | Full development guidelines and conventions      |
| [examples/](examples/)                               | Tech stack-specific templates                    |

## How to Use This Template

### Automated Setup (Recommended)

#### Windows (PowerShell)

```powershell
# Basic setup
.\setup.ps1 -ProjectPath "C:\Dev\my-new-project"

# With project details
.\setup.ps1 -ProjectPath "C:\Dev\my-api" -ProjectName "My REST API" -TechStack "Node.js, Express, TypeScript"

# Force overwrite existing files
.\setup.ps1 -ProjectPath "C:\Dev\my-api" -Force
```

#### Unix/Linux/macOS (Bash)

```bash
# Basic setup
./setup.sh /path/to/project

# With project details
./setup.sh /path/to/project "My REST API" "Node.js, Express, TypeScript"

# Force overwrite existing files
./setup.sh /path/to/project "My REST API" "Node.js, Express, TypeScript" --force
```

### Script Parameters

- **`ProjectPath`**: Target project directory (default: current directory)
- **`ProjectName`**: Your project name (replaces placeholders in CLAUDE.md)
- **`TechStack`**: Technologies used (replaces placeholders in CLAUDE.md)
- **`-SkipGit`**: Skip git initialization
- **`-Force/--force`**: Overwrite existing files without prompting

### Manual Setup

For more control, copy files manually:

```bash
# Copy core configuration
cp CLAUDE.md /path/to/project/
cp -r .claude /path/to/project/
cp .gitignore.template /path/to/project/.gitignore
```

Then edit `CLAUDE.md` to customize for your project.

## Customization Examples

### Add Development Commands

Edit CLAUDE.md to include your project's commands:

```markdown
## Development Commands

### Building
```bash
npm run build        # Node.js
cargo build          # Rust
go build             # Go
```

### Testing
```bash
npm test             # Node.js
cargo test           # Rust
go test ./...        # Go
```

### Linting
```bash
npm run lint         # Node.js
cargo clippy         # Rust
golangci-lint run    # Go
```
```

### Add Architecture Documentation

For complex projects, add to CLAUDE.md:

```markdown
## Architecture

### Directory Structure
```
src/
├── core/           # Core business logic
├── api/            # API handlers and routing
├── models/         # Data models and schemas
└── utils/          # Shared utilities
```

### Key Patterns
- **Fat Models, Thin Views**: Business logic in models
- **Dependency Injection**: Used throughout
- **Repository Pattern**: Data access abstraction
```


## Learn More

### Key Concepts

- [Semantic Versioning](https://semver.org/)
- [Git Flow](https://danielkummer.github.io/git-flow-cheatsheet/)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [Karpathy's LLM Observations](https://github.com/karpathy/llm.internals)

### Claude Code Resources

- [Claude Code Documentation](https://claude.ai/code)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)
- [Claude Code Issues](https://github.com/anthropics/claude-code/issues)

## Troubleshooting

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

## License

Apache License 2.0 - Feel free to use and modify for your needs.

## Contributing

This is a personal template. Feel free to fork and customize for your own workflow.

---

**Version:** 1.0.0 | **Last Updated:** 2026-05-05 | **Maintained:** [0xPuncker](https://github.com/0xPuncker)
