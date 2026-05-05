# Global Claude Code Setup

Instructions for applying Claude Code template settings globally to `~/.claude`.

## What's Been Configured

### ✅ Global Permission Settings
- **Permission Mode**: Changed from `bypassPermissions` to `default` (SAFE)
- **Read Operations**: No prompts (fast code exploration)
- **Write Operations**: Prompts for approval (safe editing)
- **Shell Commands**: Prompts for approval (safe execution)
- **Dangerous Mode Prompt**: Re-enabled (was disabled)

### ✅ Global Development Guidelines
Updated `~/.claude/CLAUDE.md` with:
- Karpathy-inspired development principles
- Global commit conventions (Semantic Versioning, Git Flow, Conventional Commits)
- Security rules and protected files list
- Working style guidelines
- Project template instructions

## Files Modified

### ~/.claude/settings.json
**Backup created**: `~/.claude/settings.json.backup`

**Changes made**:
\`\`\`json
// BEFORE (Unsafe)
"permissions": {
  "defaultMode": "bypassPermissions"  // No prompts!
}

// AFTER (Safe)
"permissions": {
  "defaultMode": "default",           // Prompts for writes/shell
  "allowWriteWithoutRead": false,     // Must read before write
  "alwaysAllowReadOnly": true,        // No prompts for reading
  "alwaysAllowShell": false           // Prompts for shell commands
}
\`\`\`

### ~/.claude/CLAUDE.md
**Changes made**:
- Preserved existing oh-my-claudecode (OMC) configuration
- Added global development guidelines
- Added security rules and protected files list
- Added commit conventions
- Added template repository instructions

## How It Works Now

### ✅ No Prompts (Fast)
- Reading source code files
- Searching with Grep/Glob tools
- Git status/log operations
- Any read-only operation

### ⚠️ Prompts for Approval (Safe)
- Editing files (Edit/Write tools)
- Running shell commands
- Git operations (commit, push, merge)
- Installing packages/dependencies
- Deleting files

### 🛡️ Always Blocked (Secure)
- Reading `.env*` files
- Reading `secrets/` directory
- Reading `*.pem`, `*.key` files
- Reading `.aws/`, `.ssh/` directories
- Writing to any protected file

## Testing Your Setup

### Test 1: Read File (Should Work)
\`\`\`bash
# Ask Claude: "Read the package.json file"
# Expected: Works immediately, no prompt
\`\`\`

### Test 2: Edit File (Should Prompt)
\`\`\`bash
# Ask Claude: "Add a comment to the top of index.js"
# Expected: Prompts for approval
\`\`\`

### Test 3: Run Command (Should Prompt)
\`\`\`bash
# Ask Claude: "Run npm install"
# Expected: Prompts for approval
\`\`\`

### Test 4: Read .env (Should Be Blocked)
\`\`\`bash
# Ask Claude: "Read the .env file"
# Expected: Blocked, Claude asks you to provide the value
\`\`\`

## Reverting Changes

If you want to revert to the previous settings:

\`\`\`bash
# Restore backup settings
cp ~/.claude/settings.json.backup ~/.claude/settings.json

# Or manually edit permissions to "bypassPermissions"
\`\`\`

## Customizing Global Settings

### For More Permissive (Faster)
If you find prompts too frequent:

\`\`\`json
{
  "permissions": {
    "defaultMode": "acceptEdits",  // Auto-approve file edits
    "alwaysAllowReadOnly": true,
    "alwaysAllowShell": false      // Still prompt for shell
  }
}
\`\`\`

### For More Restrictive (Safer)
If you want maximum security:

\`\`\`json
{
  "permissions": {
    "defaultMode": "default",      // Keep as-is
    "alwaysAllowReadOnly": false,  // Prompt for reads too
    "alwaysAllowShell": false
  }
}
\`\`\`

## Project-Specific Overrides

Each project can have its own `.claude/settings.json` to override global settings:

\`\`\`bash
# In a specific project directory
mkdir .claude
echo '{"permissions":{"defaultMode":"acceptEdits"}}' > .claude/settings.json
\`\`\`

## Updating Settings

To update global settings in the future:

\`\`\`bash
# Edit global settings directly
notepad ~/.claude/settings.json

# Or use the template
cp D:/Dev/my-cc-setup/.claude/settings.json ~/.claude/settings.json
\`\`\`

## Troubleshooting

### "Settings not taking effect"
1. Restart Claude Code completely
2. Check for typos in JSON (use JSON validator)
3. Ensure no project-level `.claude/settings.json` is overriding

### "Too many prompts"
- Change `defaultMode` to `acceptEdits` for file operations
- Keep shell commands requiring prompts for safety

### "Not enough prompts"
- Verify `defaultMode` is `default`, not `auto` or `bypassPermissions`
- Check that `alwaysAllowShell` is `false`

### "Can't read config files"
- Check if file is in global protected list
- Move non-sensitive configs to unprotected location
- Consider adding project-specific CLAUDE.md to customize rules

## Permission Mode Reference

| Mode | Read | Write | Shell | Best For |
|------|------|-------|-------|----------|
| `default` | ✅ No prompt | ⚠️ Prompts | ⚠️ Prompts | **Most projects** (recommended) |
| `acceptEdits` | ✅ No prompt | ✅ No prompt | ⚠️ Prompts | Trusted projects, frequent editing |
| `auto` | ✅ No prompt | ✅ No prompt | ✅ No prompt | Rapid prototyping |
| `bypassPermissions` | ✅ No prompt | ✅ No prompt | ✅ No prompt | **Use with extreme caution** |

## Security Notes

⚠️ **Important**: Your previous setting was `bypassPermissions` which is **very unsafe**:
- No prompts for ANY operations
- Could accidentally delete files
- Could run dangerous commands
- Could make destructive git changes

The new `default` mode is **much safer** while still being efficient for development.

## Next Steps

1. **Test the new settings** with the examples above
2. **Adjust if needed** based on your comfort level
3. **Use the template repository** for new projects
4. **Keep the backup** in case you need to revert

## Template Repository Location

Your Claude Code template is at: `D:/Dev/my-cc-setup`

Use it for new projects:
\`\`\`bash
cp D:/Dev/my-cc-setup/CLAUDE.md /path/to/new/project/
cp -r D:/Dev/my-cc-setup/.claude /path/to/new project/
cp D:/Dev/my-cc-setup/.gitignore.template /path/to/new/project/.gitignore
\`\`\`

---

**Version:** 1.0.0 | **Last Updated:** 2025-05-05 | **Maintained:** [0xPuncker](https://github.com/0xPuncker)
