# Project-Specific Configuration Guide

How to ensure project-specific `CLAUDE.md` files are properly applied and take precedence over global settings.

## Configuration Priority

Claude Code applies configuration in this order (highest to lowest priority):

1. **Project-level CLAUDE.md** (highest priority) → `./CLAUDE.md`
2. **Global CLAUDE.md** (fallback) → `~/.claude/CLAUDE.md`
3. **Default behavior** (lowest priority)

## Ensuring Project CLAUDE.md is Applied

### ✅ Automatic Application
Claude Code **automatically** detects and applies project-specific `CLAUDE.md` files when:
- The file exists in the project root directory
- You're working within that project directory
- The file is named exactly `CLAUDE.md` (case-sensitive)

### ✅ Project Settings Override
Project-level `.claude/settings.json` **always overrides** global settings:

\`\`\`bash
# Global settings
~/.claude/settings.json  # Fallback settings

# Project settings (takes precedence)
./project/.claude/settings.json  # Override settings
\`\`\`

## Setting Up Project-Specific Configuration

### Method 1: Template Copy (Recommended)
\`\`\`bash
# Navigate to your project
cd /path/to/project

# Copy template CLAUDE.md
cp D:/Dev/my-cc-setup/CLAUDE.md .

# Copy template settings
cp -r D:/Dev/my-cc-setup/.claude .

# Customize for your project
notepad CLAUDE.md  # Edit project purpose, commands, etc.
\`\`\`

### Method 2: Manual Creation
\`\`\`bash
# Create project CLAUDE.md
cat > CLAUDE.md << 'EOF'
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose
[Your project description]

## Project-Specific Settings
This project uses custom settings that override global defaults.

## Development Commands
[Your build, test, lint commands]

## Architecture
[Your project architecture]
EOF

# Create project settings (optional)
mkdir -p .claude
cat > .claude/settings.json << 'EOF'
{
  "permissions": {
    "defaultMode": "acceptEdits",
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": false
  }
}
EOF
\`\`\`

## Verifying Project Configuration is Applied

### Test 1: Check Project Detection
\`\`\`bash
# In your project directory, ask Claude:
"Read the CLAUDE.md file"
# Should read the project-specific CLAUDE.md, not global one
\`\`\`

### Test 2: Check Settings Priority
\`\`\`bash
# If project has .claude/settings.json with different mode:
"What permission mode is active?"
# Should report project-level settings
\`\`\`

### Test 3: Check Project Guidelines
\`\`\`bash
# Ask Claude about project-specific content:
"What are the development commands for this project?"
# Should reference project CLAUDE.md content
\`\`\`

## Common Override Scenarios

### Scenario 1: Trusted Project (Less Restrictive)
\`\`\`json
// .claude/settings.json
{
  "permissions": {
    "defaultMode": "acceptEdits",  // Auto-approve file edits
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": false      // Still prompt for shell
  }
}
\`\`\`

### Scenario 2: Security-Sensitive Project (More Restrictive)
\`\`\`json
// .claude/settings.json
{
  "permissions": {
    "defaultMode": "default",
    "alwaysAllowReadOnly": false,  // Prompt for reads too
    "alwaysAllowShell": false
  }
}
\`\`\`

### Scenario 3: Experimental Project (Permissive)
\`\`\`json
// .claude/settings.json
{
  "permissions": {
    "defaultMode": "auto",  // Most operations auto-approved
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": true
  }
}
\`\`\`

## Global vs Project Content Guidelines

### Keep in Global CLAUDE.md (~/claude/CLAUDE.md)
- General development principles
- Commit conventions
- Security best practices
- Working style guidelines
- Template repository references

### Keep in Project CLAUDE.md (./CLAUDE.md)
- Project-specific purpose
- Tech stack details
- Development commands (build, test, lint)
- Project architecture
- Environment configuration needs
- Testing strategies
- Project-specific patterns

## Troubleshooting Project Overrides

### "Project CLAUDE.md not being applied"
**Solutions:**
1. Ensure file is named exactly `CLAUDE.md` (not `claude.md` or `Claude.md`)
2. Check file is in project root directory
3. Verify file has proper markdown formatting
4. Restart Claude Code to ensure it picks up changes

### "Global settings overriding project settings"
**Solutions:**
1. Check project has `.claude/settings.json` (not just `settings.json`)
2. Verify JSON syntax is valid
3. Ensure project directory is recognized (try opening from project root)
4. Check for parent directory settings that might take precedence

### "Mixed behavior - some rules apply, some don't"
**Solutions:**
1. Content rules come from `CLAUDE.md` (project overrides global)
2. Permission settings come from `.claude/settings.json` (project overrides global)
3. Check both files exist and are properly formatted
4. Verify no conflicting rules between global and project

## Testing Project Override Setup

### Complete Test Sequence
\`\`\`bash
# 1. Start in project directory
cd /path/to/project

# 2. Verify project CLAUDE.md exists
ls CLAUDE.md

# 3. Ask Claude to read it
"Read the CLAUDE.md file and tell me the project purpose"
# Should report project-specific content

# 4. Test permissions
"Create a new file called test.txt with content 'hello'"
# Should follow project permission settings

# 5. Test project-specific commands
"How do I run tests for this project?"
# Should reference project CLAUDE.md commands
\`\`\`

## Best Practices

### ✅ DO
- Keep project CLAUDE.md focused on project-specific needs
- Reference global guidelines instead of duplicating
- Use project `.claude/settings.json` for permission overrides
- Document project-specific patterns and conventions
- Keep both global and project files in version control

### ❌ DON'T
- Don't copy entire global CLAUDE.md to project
- Don't hardcode paths that only work on your machine
- Don't override global settings without good reason
- Don't commit sensitive project-specific settings
- Don't create conflicting rules between global and project

## Template Repository Usage

The template at `D:/Dev/my-cc-setup` is designed for easy project setup:

\`\`\`bash
# Quick project setup
cd /path/to/new/project
cp D:/Dev/my-cc-setup/CLAUDE.md .
cp -r D:/Dev/my-cc-setup/.claude .
cp D:/Dev/my-cc-setup/.gitignore.template .gitignore

# Customize for your project
notepad CLAUDE.md  # Edit: purpose, tech stack, commands, architecture
\`\`\`

The template CLAUDE.md includes:
- Placeholder sections for project-specific info
- Clear instructions on what to customize
- References to global guidelines
- Examples for different tech stacks

## Automatic Override Behavior

Claude Code automatically handles priority:

1. **When working in a project directory:**
   - Reads `./CLAUDE.md` if it exists
   - Falls back to `~/.claude/CLAUDE.md` for missing content
   - Applies `./.claude/settings.json` over global settings

2. **When working outside a project:**
   - Uses `~/.claude/CLAUDE.md` only
   - Uses global settings from `~/.claude/settings.json`

3. **Nested projects:**
   - Uses closest `CLAUDE.md` (going up directory tree)
   - Merges settings from most specific to most general

## Verification Checklist

Before considering project setup complete:

- [ ] `CLAUDE.md` exists in project root
- [ ] Project purpose and tech stack documented
- [ ] Development commands added (build, test, lint)
- [ ] Architecture documented (if complex)
- [ ] `.claude/settings.json` created (if overriding permissions)
- [ ] Tested Claude Code recognizes project-specific content
- [ ] Verified permission overrides work as expected
- [ ] Both files committed to version control

---

**Remember**: Project-specific configuration always takes precedence over global configuration when properly set up. The template is designed to make this easy and consistent across all your projects.
