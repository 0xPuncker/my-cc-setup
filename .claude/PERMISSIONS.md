# Claude Code Permission Reference

Quick reference for permission modes and what they control.

## Permission Modes Comparison

| Operation | `default` | `acceptEdits` | `auto` | `bypass` |
|-----------|-----------|---------------|--------|----------|
| Read files | ✅ No prompt | ✅ No prompt | ✅ No prompt | ✅ No prompt |
| Write files | ⚠️ **Prompt** | ✅ No prompt | ✅ No prompt | ✅ No prompt |
| Shell commands | ⚠️ **Prompt** | ⚠️ **Prompt** | ✅ No prompt | ✅ No prompt |
| Git operations | ⚠️ **Prompt** | ⚠️ **Prompt** | ✅ No prompt | ✅ No prompt |
| Install packages | ⚠️ **Prompt** | ⚠️ **Prompt** | ✅ No prompt | ✅ No prompt |
| Delete files | ⚠️ **Prompt** | ⚠️ **Prompt** | ✅ No prompt | ✅ No prompt |

## Recommended Settings

### For New Projects (Recommended)
\`\`\`json
{
  "defaultMode": "auto",
  "permissionMode": "default",
  "permissions": {
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": false
  }
}
\`\`\`
- ✅ Safe but not annoying
- ✅ Prompts for destructive operations
- ✅ No prompts for reading code
- ⚠️ Prompts for shell commands

### For Trusted Projects
\`\`\`json
{
  "defaultMode": "auto",
  "permissionMode": "acceptEdits",
  "permissions": {
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": false
  }
}
\`\`\`
- ✅ Fast for frequent editing
- ✅ Still prompts for shell commands
- ⚠️ Only use for trusted projects

### For Rapid Prototyping
\`\`\`json
{
  "defaultMode": "auto",
  "permissionMode": "auto",
  "permissions": {
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": true
  }
}
\`\`\`
- ⚠️ Almost no prompts
- ⚠️ Use only for experimental/throwaway projects
- ❌ NOT recommended for production codebases

## Protected Files (Cannot Read/Write)

These files are **always protected** regardless of permission mode:

### Environment & Secrets
- `.env*` - All environment files
- `.dev.vars*` - Development variables
- `secrets/` - Secrets directory
- `credentials/` - Credentials directory

### Encryption Keys
- `*.pem` - Private keys
- `*.key` - Key files
- `*.cert` - Certificates
- `*.crt` - Certificates

### Cloud Providers
- `.aws/` - AWS configuration
- `.gcp/` - Google Cloud configuration
- `.azure/` - Azure configuration

### SSH & Git
- `.ssh/` - SSH keys and config
- `.git/config` - Git configuration (can be read)

### Database Configs
- `config/database.yml` - Database config
- `config/credentials.json` - Credential files
- `config/secrets.yml` - Secrets config

### Package Managers
- `.npmrc` - NPM configuration
- `.pypirc` - Python configuration
- `.yarnrc.yml` - Yarn configuration

## File Access Rules

### ✅ CAN Read (with default mode)
- Source code files (`.js`, `.ts`, `.py`, `.go`, etc.)
- Configuration files (unless protected)
- Documentation files (`.md`, `.txt`)
- Test files
- `package.json`, `go.mod`, `requirements.txt`

### ✅ CAN Write (with approval)
- Source code files
- Test files
- Documentation files
- Non-sensitive config files

### ❌ CANNOT Read (always blocked)
- All files in "Protected Files" list above

### ❌ CANNOT Write (always blocked)
- All files in "Protected Files" list above

## When Claude Needs Access

If Claude Code needs information from a protected file:

1. **It will ask you** to provide the specific value needed
2. **It will suggest** creating template files (`.env.example`)
3. **It will use** placeholders in examples
4. **It will document** required variables without asking for values

Example:
\`\`\`
# Claude will say:
"I need to know the database name. Please provide the DATABASE_NAME value,
or add it to your .env file if you'd like to configure it yourself."
\`\`\`

## Troubleshooting

### "Claude keeps asking for permission"
- This is expected with `default` mode
- Change to `acceptEdits` if editing is frequent
- Keep `default` for security-conscious projects

### "Claude can't read my config file"
- Check if file is in protected list
- Move non-sensitive config to different location
- Update CLAUDE.md security rules if needed

### "I want to approve everything"
- Use `acceptEdits` mode for file operations
- Keep shell commands requiring prompts for safety
- Never use `bypassPermissions` lightly

### "How do I know my current mode?"
Check `.claude/settings.json`:
\`\`\`bash
cat .claude/settings.json | grep permissionMode
\`\`\`

## Security Best Practices

1. **Never use `bypassPermissions`** for production codebases
2. **Keep `default` mode** for security-sensitive projects
3. **Use `acceptEdits`** for trusted projects with frequent edits
4. **Always commit** `.claude/settings.json` to version control
5. **Review permission changes** in code reviews
6. **Document any custom rules** in CLAUDE.md

## Quick Test

Test your permission setup:

\`\`\`bash
# Test 1: Read a file (should work without prompt)
"Read the README.md file"

# Test 2: Edit a file (should prompt with default mode)
"Add a comment to the top of main.js"

# Test 3: Run a command (should prompt)
"Run npm install"

# Test 4: Try to read .env (should be blocked)
"Read the .env file"
\`\`\`

Expected results:
- Test 1: No prompt ✓
- Test 2: Prompts for approval ✓
- Test 3: Prompts for approval ✓
- Test 4: Blocked, asks you to provide value ✓
