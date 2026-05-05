#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Claude Code Template Setup Script
.DESCRIPTION
    Automates the setup of Claude Code configuration for a new project using the template.
.EXAMPLE
    .\setup.ps1 -ProjectPath "C:\Dev\my-new-project" -ProjectName "My API Project" -TechStack "Node.js, Express, TypeScript"
.NOTES
    Author: @0xPuncker
    Version: 1.0.0
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$ProjectPath = (Get-Location).Path,

    [Parameter(Mandatory = $false)]
    [string]$ProjectName = "",

    [Parameter(Mandatory = $false)]
    [string]$TechStack = "",

    [Parameter(Mandatory = $false)]
    [switch]$SkipGit,

    [Parameter(Mandatory = $false)]
    [switch]$Force
)

# Color functions for better output
function Write-Step {
    param([string]$Message)
    Write-Host "🔧 " -ForegroundColor Cyan -NoNewline
    Write-Host $Message
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ " -ForegroundColor Green -NoNewline
    Write-Host $Message
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ️  " -ForegroundColor Yellow -NoNewline
    Write-Host $Message
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ " -ForegroundColor Red -NoNewline
    Write-Host $Message
}

function Test-Command {
    param([string]$Command)
    try {
        $null = Get-Command $Command -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Main setup function
function Invoke-Setup {
    Write-Host "`n=== Claude Code Template Setup ===" -ForegroundColor Magenta

    # Validate template location
    $TemplatePath = $PSScriptRoot

    if (-not (Test-Path "$TemplatePath\CLAUDE.md")) {
        Write-Error "CLAUDE.md not found in template directory!"
        Write-Info "Please run this script from the template repository root."
        exit 1
    }

    # Check if project path exists
    if (-not (Test-Path $ProjectPath)) {
        Write-Info "Project directory does not exist. Creating: $ProjectPath"
        try {
            New-Item -ItemType Directory -Path $ProjectPath -Force | Out-Null
            Write-Success "Created project directory"
        }
        catch {
            Write-Error "Failed to create project directory: $_"
            exit 1
        }
    }

    # Check if project is already a git repository
    $GitInit = $false
    if (-not $SkipGit) {
        if (-not (Test-Path "$ProjectPath\.git")) {
            Write-Info "Project is not a git repository. Will initialize git."
            $GitInit = $true
        }
        else {
            Write-Step "Git repository already exists"
        }
    }

    # Check for existing files
    $ExistingFiles = @(
        "$ProjectPath\CLAUDE.md",
        "$ProjectPath\.claude\settings.json",
        "$ProjectPath\.gitignore"
    )

    $HasExistingFiles = $false
    foreach ($file in $ExistingFiles) {
        if (Test-Path $file) {
            $HasExistingFiles = $true
            break
        }
    }

    if ($HasExistingFiles -and -not $Force) {
        Write-Error "Project already has Claude Code configuration files!"
        Write-Info "Existing files:"
        foreach ($file in $ExistingFiles) {
            if (Test-Path $file) {
                Write-Host "  - $file" -ForegroundColor Yellow
            }
        }
        Write-Info "Use -Force to overwrite existing files."
        exit 1
    }

    # Copy template files
    Write-Step "Copying template files..."

    # Copy CLAUDE.md
    try {
        Copy-Item "$TemplatePath\CLAUDE.md" "$ProjectPath\CLAUDE.md" -Force
        Write-Success "Copied CLAUDE.md"
    }
    catch {
        Write-Error "Failed to copy CLAUDE.md: $_"
        exit 1
    }

    # Copy .claude directory
    try {
        if (Test-Path "$TemplatePath\.claude") {
            Copy-Item "$TemplatePath\.claude" "$ProjectPath\.claude" -Recurse -Force
            Write-Success "Copied .claude directory"
        }
    }
    catch {
        Write-Error "Failed to copy .claude directory: $_"
        exit 1
    }

    # Copy .gitignore.template
    try {
        if (Test-Path "$TemplatePath\.gitignore.template") {
            Copy-Item "$TemplatePath\.gitignore.template" "$ProjectPath\.gitignore" -Force
            Write-Success "Copied .gitignore"
        }
    }
    catch {
        Write-Error "Failed to copy .gitignore: $_"
        exit 1
    }

    # Customize CLAUDE.md with project info
    if ($ProjectName -or $TechStack) {
        Write-Step "Customizing CLAUDE.md..."

        try {
            $claudeContent = Get-Content "$ProjectPath\CLAUDE.md" -Raw

            # Update Project Purpose
            if ($ProjectName) {
                $claudeContent = $claudeContent -replace '\[Your project name and purpose here\]', $ProjectName
                $claudeContent = $claudeContent -replace '\[Your project description\]', $ProjectName
                Write-Success "Set project name to: $ProjectName"
            }

            # Update Tech Stack
            if ($TechStack) {
                $claudeContent = $claudeContent -replace '\[Main technologies, frameworks, and tools\]', $TechStack
                Write-Success "Set tech stack to: $TechStack"
            }

            # Remove placeholder brackets
            $claudeContent = $claudeContent -replace '\[Your project description\]', $ProjectName

            Set-Content "$ProjectPath\CLAUDE.md" -Value $claudeContent -NoNewline
        }
        catch {
            Write-Error "Failed to customize CLAUDE.md: $_"
            exit 1
        }
    }

    # Initialize git if needed
    if (-not $SkipGit -and $GitInit) {
        Write-Step "Initializing git repository..."
        try {
            Push-Location $ProjectPath
            git init | Out-Null
            Write-Success "Initialized git repository"
            Pop-Location
        }
        catch {
            Write-Error "Failed to initialize git: $_"
        }
    }

    # Create .env.example if it doesn't exist
    $EnvExample = "$ProjectPath\.env.example"
    if (-not (Test-Path $EnvExample)) {
        Write-Step "Creating .env.example template..."
        try {
            @"
# Environment Variables Template
# Add your project's environment variables here
# DO NOT commit actual values to version control

# Example variables:
# DATABASE_URL=postgresql://user:password@localhost:5432/dbname
# API_KEY=your_api_key_here
# JWT_SECRET=your_jwt_secret_here
"@ | Out-File -FilePath $EnvExample -Encoding UTF8

            Write-Success "Created .env.example template"
        }
        catch {
            Write-Error "Failed to create .env.example: $_"
        }
    }

    # Summary
    Write-Host "`n=== Setup Complete! ===" -ForegroundColor Green
    Write-Host "`nProject Location:" -ForegroundColor Cyan
    Write-Host "  $ProjectPath" -ForegroundColor White
    Write-Host "`nNext Steps:" -ForegroundColor Cyan
    Write-Host "  1. Review and customize CLAUDE.md with your project details" -ForegroundColor White
    Write-Host "  2. Add development commands (build, test, lint) to CLAUDE.md" -ForegroundColor White
    Write-Host "  3. Test Claude Code with a simple task" -ForegroundColor White
    Write-Host "  4. Commit the configuration: git add . && git commit -m 'feat: configure Claude Code template'" -ForegroundColor White

    if (-not $SkipGit -and $GitInit) {
        Write-Host "  5. Create initial commit: git commit -m 'chore: initial commit'" -ForegroundColor White
    }

    Write-Host "`nFor detailed instructions, see:" -ForegroundColor Cyan
    Write-Host "  - docs/SETUP.md - Full setup guide" -ForegroundColor White
    Write-Host "  - docs/CHECKLIST.md - Setup checklist" -ForegroundColor White
    Write-Host "  - examples/ - Tech stack examples" -ForegroundColor White
    Write-Host "`nTemplate Repository:" -ForegroundColor Magenta
    Write-Host "  $TemplatePath" -ForegroundColor White
}

# Run the setup
try {
    Invoke-Setup
    exit 0
}
catch {
    Write-Error "Setup failed: $_"
    exit 1
}
