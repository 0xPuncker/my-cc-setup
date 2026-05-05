#!/bin/bash
# Claude Code Template Setup Script
# Automates the setup of Claude Code configuration for a new project
# Author: @0xPuncker
# Version: 1.0.0

set -e  # Exit on error

# Color functions
setup_step() { echo "🔧 $1"; }
setup_success() { echo "✅ $1"; }
setup_info() { echo "ℹ️  $1"; }
setup_error() { echo "❌ $1"; }

# Default values
PROJECT_PATH="${1:-.}"
PROJECT_NAME="${2:-}"
TECH_STACK="${3:-}"
SKIP_GIT="${4:-false}"
FORCE="${5:-false}"

# Get template directory
TEMPLATE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Claude Code Template Setup ==="

# Validate template location
if [ ! -f "$TEMPLATE_PATH/CLAUDE.md" ]; then
    setup_error "CLAUDE.md not found in template directory!"
    setup_info "Please run this script from the template repository root."
    exit 1
fi

# Check if project path exists
if [ ! -d "$PROJECT_PATH" ]; then
    setup_info "Project directory does not exist. Creating: $PROJECT_PATH"
    mkdir -p "$PROJECT_PATH"
    setup_success "Created project directory"
fi

# Check if project is already a git repository
GIT_INIT=false
if [ "$SKIP_GIT" = "false" ] && [ ! -d "$PROJECT_PATH/.git" ]; then
    setup_info "Project is not a git repository. Will initialize git."
    GIT_INIT=true
elif [ "$SKIP_GIT" = "false" ]; then
    setup_step "Git repository already exists"
fi

# Check for existing files
EXISTING_FILES=""
if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then EXISTING_FILES="$EXISTING_FILES\n- CLAUDE.md"; fi
if [ -f "$PROJECT_PATH/.claude/settings.json" ]; then EXISTING_FILES="$EXISTING_FILES\n- .claude/settings.json"; fi
if [ -f "$PROJECT_PATH/.gitignore" ]; then EXISTING_FILES="$EXISTING_FILES\n- .gitignore"; fi

if [ -n "$EXISTING_FILES" ] && [ "$FORCE" = "false" ]; then
    setup_error "Project already has Claude Code configuration files!"
    setup_info "Existing files:$EXISTING_FILES"
    setup_info "Use --force to overwrite existing files."
    exit 1
fi

# Copy template files
setup_step "Copying template files..."

# Copy CLAUDE.md
cp "$TEMPLATE_PATH/CLAUDE.md" "$PROJECT_PATH/CLAUDE.md"
setup_success "Copied CLAUDE.md"

# Copy .claude directory
if [ -d "$TEMPLATE_PATH/.claude" ]; then
    cp -r "$TEMPLATE_PATH/.claude" "$PROJECT_PATH/.claude"
    setup_success "Copied .claude directory"
fi

# Copy .gitignore.template
if [ -f "$TEMPLATE_PATH/.gitignore.template" ]; then
    cp "$TEMPLATE_PATH/.gitignore.template" "$PROJECT_PATH/.gitignore"
    setup_success "Copied .gitignore"
fi

# Customize CLAUDE.md with project info
if [ -n "$PROJECT_NAME" ] || [ -n "$TECH_STACK" ]; then
    setup_step "Customizing CLAUDE.md..."

    if [ -n "$PROJECT_NAME" ]; then
        # Update Project Purpose
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s/\[Your project name and purpose here\]/$PROJECT_NAME/g" "$PROJECT_PATH/CLAUDE.md"
            sed -i '' "s/\[Your project description\]/$PROJECT_NAME/g" "$PROJECT_PATH/CLAUDE.md"
        else
            sed -i "s/\[Your project name and purpose here\]/$PROJECT_NAME/g" "$PROJECT_PATH/CLAUDE.md"
            sed -i "s/\[Your project description\]/$PROJECT_NAME/g" "$PROJECT_PATH/CLAUDE.md"
        fi
        setup_success "Set project name to: $PROJECT_NAME"
    fi

    if [ -n "$TECH_STACK" ]; then
        # Update Tech Stack
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s/\[Main technologies, frameworks, and tools\]/$TECH_STACK/g" "$PROJECT_PATH/CLAUDE.md"
        else
            sed -i "s/\[Main technologies, frameworks, and tools\]/$TECH_STACK/g" "$PROJECT_PATH/CLAUDE.md"
        fi
        setup_success "Set tech stack to: $TECH_STACK"
    fi
fi

# Initialize git if needed
if [ "$SKIP_GIT" = "false" ] && [ "$GIT_INIT" = "true" ]; then
    setup_step "Initializing git repository..."
    (cd "$PROJECT_PATH" && git init)
    setup_success "Initialized git repository"
fi

# Create .env.example if it doesn't exist
ENV_EXAMPLE="$PROJECT_PATH/.env.example"
if [ ! -f "$ENV_EXAMPLE" ]; then
    setup_step "Creating .env.example template..."
    cat > "$ENV_EXAMPLE" << 'EOF'
# Environment Variables Template
# Add your project's environment variables here
# DO NOT commit actual values to version control

# Example variables:
# DATABASE_URL=postgresql://user:password@localhost:5432/dbname
# API_KEY=your_api_key_here
# JWT_SECRET=your_jwt_secret_here
EOF
    setup_success "Created .env.example template"
fi

# Summary
echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Project Location:"
echo "  $PROJECT_PATH"
echo ""
echo "Next Steps:"
echo "  1. Review and customize CLAUDE.md with your project details"
echo "  2. Add development commands (build, test, lint) to CLAUDE.md"
echo "  3. Test Claude Code with a simple task"
echo "  4. Commit the configuration: git add . && git commit -m 'feat: configure Claude Code template'"

if [ "$SKIP_GIT" = "false" ] && [ "$GIT_INIT" = "true" ]; then
    echo "  5. Create initial commit: git commit -m 'chore: initial commit'"
fi

echo ""
echo "For detailed instructions, see:"
echo "  - docs/SETUP.md - Full setup guide"
echo "  - docs/CHECKLIST.md - Setup checklist"
echo "  - examples/ - Tech stack examples"
echo ""
echo "Template Repository:"
echo "  $TEMPLATE_PATH"

exit 0
