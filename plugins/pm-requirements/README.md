# pm-requirements

BDD requirements with Gherkin feature files and unique requirement IDs.

## Commands

### `/requirements`

Write new BDD requirements in Gherkin format. The workflow:

1. **Read conventions** - Load project-specific rules from `gherkin-conventions.md`
2. **Understand the need** - Ask about functionality, actors, and terminology
3. **Define scenarios** - Gather preconditions, actions, and expected results
4. **Generate feature file** - Create file in correct location with proper tags
5. **Update overview** - Regenerate the requirements overview

## Requirement IDs

Every feature gets a unique ID for traceability:

```
@DOM-SUB-CAP-NNN
```

- `DOM` = Domain prefix (3 letters)
- `SUB` = Subdomain prefix (3 letters)
- `CAP` = Capability prefix (3 letters)
- `NNN` = Sequential number (001, 002, ...)

Example: `@ORD-PRO-VAL-001` (Orders → Processing → Validation → feature 001)

## Folder Structure

Three levels: **Domain → Subdomain → Capability**

```
requirements/
└── [NN] [Domain]/
    └── [NN] [Subdomain]/
        └── [NN] [Capability]/
            └── feature-name.feature
```

## Rules

### `gherkin-conventions.md`

Project-specific conventions for:
- Folder structure
- Feature ID format
- Tag categories (priority, status, type)
- Actor definitions

Copy this to your project's `.claude/rules/` folder and customize.

## Skills

### `requirements-writing`

BDD/Gherkin best practices:
- One scenario = one behavior
- Declarative over imperative
- Use Scenario Outline for variations
- Group with Rule sections
- Concrete examples with realistic values

Includes a complete example feature file demonstrating all patterns.

## Key Principles

- **Never assume** - Always ask about business logic, error messages, validation
- **Document uncertainties** - Use `# OPEN QUESTIONS:` for unresolved items
- **Unique IDs** - Every feature has a traceable ID

## Installation

```
/plugin install pm-requirements@storm-claude-marketplace
```
