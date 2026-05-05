# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

[My Go Service] - High-performance microservice built with Go 1.21+ and clean architecture.

## Tech Stack

- **Language**: Go 1.21+
- **Framework**: Chi router + middleware
- **Database**: PostgreSQL with pgx
- **ORM**: sqlc for type-safe SQL
- **Testing**: testify + go-test
- **Build**: Go modules + Makefile

## Development Commands

### Running the Application
\`\`\`bash
# Run development server with hot reload
go run cmd/server/main.go

# Run with air (live reload)
air

# Run compiled binary
./bin/server
\`\`\`

### Building
\`\`\`bash
# Build for current platform
go build -o bin/server cmd/server/main.go

# Build for production
make build

# Build for multiple platforms
make build-all
\`\`\`

### Testing
\`\`\`bash
# Run all tests
go test ./...

# Run tests with coverage
go test -cover ./...

# Run tests with coverage report
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out

# Run specific test
go test -v ./internal/handlers -run TestCreateUser

# Run tests with race detection
go test -race ./...
\`\`\`

### Dependency Management
\`\`\`bash
# Add dependency
go get github.com/pkg/pkg

# Tidy dependencies
go mod tidy

# Verify dependencies
go mod verify

# Download dependencies
go mod download
\`\`\`

### Code Generation
\`\`\`bash
# Generate SQL types from queries (sqlc)
sqlc generate

# Generate mocks (mockgen)
mockgen -source=internal/repository/user.go -destination=internal/repository/mocks/user.go

# Generate OpenAPI spec
swag init -g cmd/server/main.go
\`\`\`

### Linting and Formatting
\`\`\`bash
# Format code
go fmt ./...

# Lint code
golangci-lint run

# Lint specific package
golangci-lint run ./internal/...

# Run all static analysis
make lint
\`\`\`

## Architecture

### Directory Structure (Clean Architecture)
\`\`\`
cmd/
└── server/              # Application entry point
    └── main.go

internal/
├── handlers/            # HTTP handlers (presentation layer)
│   ├── user.go
│   └── middleware.go
├── services/            # Business logic (domain logic)
│   ├── user_service.go
│   └── auth_service.go
├── repository/          # Data access (persistence layer)
│   ├── user_repo.go
│   └── interfaces.go    # Repository interfaces
├── models/              # Domain models
│   └── user.go
└── config/              # Configuration
    └── config.go

pkg/                     # Public libraries
├── logger/
└── errors/

migrations/              # Database migrations
├── 000001_init.up.sql
└── 000001_init.down.sql

queries/                 # SQL queries for sqlc
└── user.sql
\`\`\`

### Layer Responsibilities
- **handlers**: HTTP concerns (parsing, validation, response formatting)
- **services**: Business logic and orchestration (framework-agnostic)
- **repository**: Database operations and data access
- **models**: Domain entities and business rules
- **pkg**: Reusable packages that can be imported by other projects

### Key Patterns
- **Dependency Injection**: Constructor injection for services/repositories
- **Interface-based design**: Repository interfaces in repository package
- **Error wrapping**: Use `fmt.Errorf` with `%w` for error chains
- **Context propagation**: Always accept `context.Context` as first parameter
- **Structured logging**: Use structured logging with correlation IDs

### Request Flow
\`\`\`
HTTP Request → Middleware → Handler → Service → Repository → Database
                        ↓           ↓           ↓
                   Validation    Business     Data Access
                        ↓           ↓           ↓
                   Response ← Service ← Repository ← DB
\`\`\`

## Configuration

Use environment variables with `viper` for configuration:

\`\`\`bash
# .env file
DATABASE_URL=postgresql://...
SERVER_PORT=8080
LOG_LEVEL=info
JWT_SECRET=...
\`\`\`

## Testing Strategy

- **Table-driven tests**: Use test tables for multiple scenarios
- **Subtests**: Use `t.Run()` for related test cases
- **Mocks**: Generate mocks with `mockgen` for repository interfaces
- **Test fixtures**: Use `testify/suite` for complex setup

## Go Conventions

- **Interface naming**: `Interface` suffix (e.g., `UserRepositoryInterface`)
- **Error handling**: Never ignore errors, always handle them
- **Goroutines**: Always handle goroutine lifecycle and errors
- **Context**: Use context for cancellation and timeouts
- **Package naming**: Lowercase, single words when possible
- **Exported symbols**: PascalCase for exports, camelCase for internal

## Performance Considerations

- Use connection pooling for database
- Implement proper indexing (measure first)
- Use pprof for profiling:
  \`\`\`bash
  go tool pprof http://localhost:8080/debug/pprof/profile
  \`\`\`
- Check for race conditions in tests
