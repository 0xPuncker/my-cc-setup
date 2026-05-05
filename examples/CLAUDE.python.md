# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

[My Django Project] - Web application built with Django 5.x and Django REST Framework.

## Tech Stack

- **Framework**: Django 5.x
- **API**: Django REST Framework 3.x
- **Database**: PostgreSQL
- **Task Queue**: Celery + Redis
- **Testing**: pytest + pytest-django
- **Python**: 3.11+

## Development Commands

### Running the Application
\`\`\`bash
# Run development server
python manage.py runserver

# Run with specific port
python manage.py runserver 8001
\`\`\`

### Database Operations
\`\`\`bash
# Create and apply migrations
python manage.py makemigrations
python manage.py migrate

# Make migrations for specific app
python manage.py makemigrations myapp

# Show migration SQL
python manage.py sqlmigrate myapp 0001

# Reset database (dev only)
python manage.py flush
\`\`\`

### Testing
\`\`\`bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_views.py

# Run with coverage
pytest --cov=.

# Run tests in parallel
pytest -n auto
\`\`\`

### Django Management
\`\`\`bash
# Create superuser
python manage.py createsuperuser

# Open Django shell
python manage.py shell

# Collect static files
python manage.py collectstatic
\`\`\`

### Linting and Formatting
\`\`\`bash
# Lint code
ruff check .

# Auto-fix lint issues
ruff check . --fix

# Format code
black .

# Sort imports
isort .
\`\`\`

### Celery (Background Tasks)
\`\`\`bash
# Start Celery worker
celery -A myproject worker -l INFO

# Start Celery beat (scheduled tasks)
celery -A myproject beat -l INFO

# Inspect active tasks
celery -A myproject inspect active
\`\`\`

## Architecture

### Directory Structure
\`\`\`
myproject/
├── settings/          # Django settings (dev, staging, prod)
├── urls.py            # Root URL configuration
├── wsgi.py            # WSGI config
└── apps/
    ├── users/         # User management app
    ├── api/           # API endpoints (DRF)
    ├── core/          # Core business logic
    └── utils/         # Shared utilities
\`\`\`

### Django Apps Structure
\`\`\`
myapp/
├── models/            # Database models
├── serializers/       # DRF serializers
├── views/             # View functions/classes
├── urls/              # App-specific URLs
├── permissions.py     # Custom permissions
├── filters.py         # QuerySet filters
├── tasks/             # Celery tasks
└── tests/             # App tests
\`\`\`

### Key Patterns
- **Fat Models, Thin Views**: Business logic in models/manager methods
- **ViewSets**: DRF ViewSets for CRUD operations
- **Serializers**: Handle validation and data transformation
- **Permissions**: Custom permission classes for access control
- **Managers**: Custom QuerySet managers for complex queries

### Request Flow
\`\`\`
Request → Middleware → URLs → ViewSets/Views → Serializers → Models
                              ↓                      ↓
                         Permissions           Validation
                              ↓                      ↓
                         Response ← Serializers ← Models
\`\`\`

## Environment Configuration

Use `django-environments` for settings management:

\`\`\`bash
# .env file
DEBUG=True
DATABASE_URL=postgresql://...
SECRET_KEY=...
REDIS_URL=redis://localhost:6379/0
CELERY_BROKER_URL=redis://localhost:6379/0
\`\`\`

## Testing Strategy

- **Unit tests**: Models, serializers, utilities
- **Integration tests**: Views and API endpoints
- **Factory Boy**: Use factories for test data generation
- **pytest fixtures**: Database and client setup

## Django Conventions

- Use **class-based views** (ViewSets) for APIs
- Use **function-based views** for simple pages
- **Model methods** for data-related business logic
- **Manager methods** for table-level operations
- **Context processors** for global template context
- **Custom template tags** for reusable UI components
