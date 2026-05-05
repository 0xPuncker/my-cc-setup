# New Project Setup Checklist

Use this checklist when setting up a new project with this Claude Code template.

## ✅ Phase 1: Copy Template Files

- [ ] Copy `CLAUDE.md` to new project root
- [ ] Copy `.claude/settings.json` to new project
- [ ] Copy `.gitignore.template` as `.gitignore`
- [ ] Initialize git repo (`git init`) if not already done

## ✅ Phase 2: Customize CLAUDE.md

### Header Section
- [ ] Update "Project Purpose" with your project description
- [ ] Update "Tech Stack" with main technologies
- [ ] Add "Development Commands" section with:
  - [ ] Build command
  - [ ] Test command (including single test)
  - [ ] Lint/format commands
  - [ ] Run command

### Project-Specific Sections
- [ ] Add "Architecture" section if complex structure
  - [ ] Directory structure
  - [ ] Key patterns and conventions
  - [ ] Request/data flow diagrams

- [ ] Add "Environment Configuration" section if needed
  - [ ] List required environment variables
  - [ ] Reference `.env.example` file

- [ ] Add "Testing Strategy" section if non-standard
  - [ ] Test types (unit, integration, E2E)
  - [ ] Test conventions

## ✅ Phase 3: Configure Permissions

### Verify `.claude/settings.json`
- [ ] `"defaultMode": "auto"` ✓ (recommended)
- [ ] `"permissionMode": "default"` ✓ (recommended)
- [ ] `"alwaysAllowReadOnly": true` ✓ (safe)

### Adjust if Needed
- [ ] Change to `"acceptEdits"` if too many prompts
- [ ] Keep `"default"` for security-conscious projects
- [ ] Never use `"bypassPermissions"` unless absolutely necessary

## ✅ Phase 4: Security Setup

### Protect Sensitive Files
- [ ] Create `.env.example` template file
- [ ] Add `.env*` to `.gitignore`
- [ ] Add `secrets/` to `.gitignore`
- [ ] Add `*.pem`, `*.key` to `.gitignore`
- [ ] Add provider-specific dirs (`.aws/`, `.ssh/`, etc.)

### Verify CLAUDE.md Security Rules
- [ ] Protected files list matches project needs
- [ ] Custom rules added if project has unique sensitive files

## ✅ Phase 5: Testing and Verification

### Test Claude Code
- [ ] Ask Claude to read a file (should work without prompt)
- [ ] Ask Claude to edit a file (should prompt for approval)
- [ ] Ask Claude to run a shell command (should prompt)
- [ ] Ask Claude to read `.env` file (should be blocked)

### Test Git Workflow
- [ ] Make a small change with Claude
- [ ] Review the change
- [ ] Commit with conventional commit format
- [ ] Verify commit message follows conventions

## ✅ Phase 6: Documentation

### Update README.md
- [ ] Add project description
- [ ] Add setup/installation instructions
- [ ] Reference CLAUDE.md for AI assistant usage
- [ ] Add badge for Claude Code if desired

### Optional Documentation
- [ ] Create `CONTRIBUTING.md` if open source
- [ ] Create `docs/` directory for complex docs
- [ ] Add architecture diagrams if helpful

## ✅ Phase 7: First Commit

### Commit the Configuration
- [ ] Review all staged files
- [ ] Write conventional commit message:
  ```
  feat: configure Claude Code with custom guidelines

  - Add CLAUDE.md with project-specific commands
  - Configure .claude/settings.json with default permissions
  - Setup .gitignore with security rules
  ```

- [ ] Commit (NO CoAuthored commits)
- [ ] Verify commit appears in git log

## 🚀 Quick Reference

### Minimal Setup (5 minutes)
1. Copy `CLAUDE.md` and `.claude/settings.json`
2. Edit project purpose and commands in CLAUDE.md
3. Copy `.gitignore.template` to `.gitignore`
4. Test with a simple Claude task
5. Commit

### Full Setup (15 minutes)
1. Complete minimal setup
2. Add architecture documentation
3. Configure environment variables
4. Create `.env.example`
5. Test permissions and security
6. Write comprehensive commit

## 📋 Example Commit Messages

```
# Initial setup
feat: configure Claude Code for Node.js API project

- Add CLAUDE.md with Express.js commands and architecture
- Setup permission controls for destructive operations
- Configure .gitignore with security rules

# Adding to existing project
docs: add Claude Code configuration and guidelines

- Add CLAUDE.md with development commands
- Configure AI assistant permissions and security rules
- Document testing strategy and architecture

# Updating configuration
chore: update Claude Code guidelines with new commands

- Add database migration commands
- Update architecture section for new service layer
- Adjust permission mode for trusted development environment
```

## ⚠️ Common Mistakes to Avoid

- ❌ Forgetting to customize "Project Purpose" in CLAUDE.md
- ❌ Not adding development commands (build, test, lint)
- ❌ Skipping `.gitignore` setup for sensitive files
- ❌ Using `"bypassPermissions"` mode carelessly
- ❌ Not testing permissions before real work
- ❌ Writing CoAuthored commits (violates conventions)

## 🎯 Success Criteria

You'll know the setup is complete when:
- Claude Code can read your source code without prompts
- Claude Code prompts before editing files or running commands
- Sensitive files (`.env`) cannot be read by Claude Code
- You can run build/test/lint commands via Claude Code
- Git commits follow conventional commit format
- Team members can copy the same setup for consistency

## 📞 Need Help?

- Review [SETUP.md](SETUP.md) for detailed instructions
- Check [examples/](examples/) for tech stack-specific templates
- Read [CLAUDE.md](CLAUDE.md) for full guidelines
- Consult Claude Code docs: https://claude.ai/code
