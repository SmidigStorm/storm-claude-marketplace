---
description: Manage tech stack and architecture decisions
---

# Architecture

Manage the project's tech stack and architecture decisions.

## Instructions

Ask the user what they want to do:

1. **Update tech stack** - Add or modify technologies in `docs/strategy/tech-stack.md`
2. **New decision** - Create an Architecture Decision Record in `docs/strategy/architecture/`
3. **Review decisions** - List existing ADRs and check if any need updating

### Option 1: Update Tech Stack

1. Check if `docs/strategy/tech-stack.md` exists
2. If it exists, read it and ask what to add/change
3. If it doesn't exist, gather the current tech stack through conversation
4. Update or create the file

Tech stack document should cover:
- **Languages** - Programming languages used
- **Frameworks** - Core frameworks
- **Infrastructure** - Hosting, CI/CD, etc.
- **Data** - Databases, caching, etc.
- **Key Libraries** - Important dependencies

### Option 2: New Decision

Create a new ADR in `docs/strategy/architecture/`. Use numbered filenames like `001-title.md`.

1. Check existing ADRs to determine the next number
2. Ask the user about:
   - **Title**: Short name for the decision
   - **Context**: Why are we making this decision? What's the situation?
   - **Decision**: What did we decide?
   - **Consequences**: What does this mean going forward? (good and bad)
3. Create the ADR with status "accepted"

ADR format:
```markdown
# [NUMBER]. [TITLE]

**Status**: accepted

## Context

[Why we're making this decision]

## Decision

[What we decided]

## Consequences

[What this means - both positive and negative]
```

### Option 3: Review Decisions

1. List all ADRs in `docs/strategy/architecture/`
2. Show a summary of each (title + status)
3. Ask if any decisions need to be revisited
4. If yes, update the status (deprecated, superseded) and optionally create a new ADR

## Output Locations

- Tech stack: `docs/strategy/tech-stack.md`
- ADRs: `docs/strategy/architecture/NNN-title.md`

## Notes

- Keep ADRs concise - capture the essence, not every detail
- ADRs are immutable once accepted - create new ones to supersede old decisions
- Tech stack should reflect what's actually in use, not aspirational
