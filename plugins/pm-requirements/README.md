# pm-requirements

BDD requirements with Gherkin feature files and unique requirement IDs.

## Commands

### `/requirements`

Interactive menu to:

- **Create feature** - Create new feature file with unique ID (e.g., ADM-001)
- **Add scenario** - Add scenarios to existing feature
- **Review feature** - Check for issues
- **List features** - Show registry of all requirements

## Requirement IDs

Every feature gets a unique ID for traceability:

```
[PREFIX]-[NUMBER] [Name]
```

- Prefix derived from domain folder (admission → ADM)
- Sequential numbering (001, 002, ...)
- Example: `ADM-001 User Registration`

## Skills

### `requirements-writing`

Knowledge about BDD, Gherkin, and requirement IDs:
- Feature file structure with ID tags
- Given-When-Then syntax
- Registry management
- Domain prefix mapping

## Output

```
requirements/
├── registry.md           # Tracks all requirement IDs
├── admission/
│   └── user-registration.feature  # @ADM-001
└── orders/
    └── create-order.feature       # @ORD-001
```

## Key Principles

- **Unique IDs** - Every feature has a traceable ID
- **Registry** - All IDs tracked in `requirements/registry.md`
- **No assumptions** - Always ask questions, never invent rules

## Installation

```
/plugin install pm-requirements@storm-claude-marketplace
```
