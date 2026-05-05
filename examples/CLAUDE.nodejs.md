# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

[My Node.js API Project] - RESTful API service built with Express.js and TypeScript.

## Tech Stack

- **Runtime**: Node.js 20+
- **Framework**: Express.js 4.x
- **Language**: TypeScript 5.x
- **Database**: PostgreSQL with Prisma ORM
- **Testing**: Jest + Supertest
- **Build**: ts-node for development, tsc for production

## Development Commands

### Running the Application
\`\`\`bash
# Development mode with hot reload
npm run dev

# Production mode
npm start
\`\`\`

### Building
\`\`\`bash
# Compile TypeScript
npm run build

# Clean build artifacts
npm run clean
\`\`\`

### Testing
\`\`\`bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm run test:coverage

# Run single test file
npm test -- --testPathPattern=auth.spec.ts
\`\`\`

### Linting and Formatting
\`\`\`bash
# Lint code
npm run lint

# Auto-fix lint issues
npm run lint:fix

# Format code
npm run format

# Type checking
npm run type-check
\`\`\`

### Database Operations
\`\`\`bash
# Generate Prisma client
npx prisma generate

# Run database migrations
npx prisma migrate dev

# Reset database (dev only)
npx prisma migrate reset

# Open Prisma Studio
npx prisma studio
\`\`\`

## Architecture

### Directory Structure
\`\`\`
src/
├── api/              # API route handlers and middleware
│   ├── routes/       # Express route definitions
│   ├── middleware/   # Auth, validation, error handling
│   └── controllers/  # Request/response logic
├── services/         # Business logic layer
├── models/           # Database models (Prisma schema)
├── utils/            # Shared utilities and helpers
├── config/           # App configuration
└── types/            # TypeScript type definitions
\`\`\`

### Key Patterns
- **Routes** define API endpoints and delegate to controllers
- **Controllers** handle HTTP concerns (validation, parsing)
- **Services** contain business logic and are framework-agnostic
- **Middleware** handles cross-cutting concerns (auth, logging)
- **Prisma** handles all database operations

### Request Flow
\`\`\`
Request → Middleware (auth/validate) → Routes → Controllers → Services → Database
         ↓                                              ↓
      Error Handlers ← Response Formatting ← Controllers ← Services
\`\`\`

## Environment Configuration

Required environment variables (see `.env.example`):
\`\`\`
DATABASE_URL=postgresql://...
JWT_SECRET=...
PORT=3000
NODE_ENV=development
\`\`\`

## Testing Strategy

- **Unit tests**: Services and utilities
- **Integration tests**: API endpoints with test database
- **E2E tests**: Critical user flows
- Always use test factories for consistent test data

## Error Handling

- Use custom `AppError` class for application errors
- Middleware handles all errors and returns consistent format
- Log errors with context (user id, request id, timestamp)
