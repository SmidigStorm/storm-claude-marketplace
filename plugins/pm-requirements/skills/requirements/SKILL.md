---
name: requirements
description: Write BDD requirements in Gherkin format. Guides the user through the process.
---

# /requirements

Write new BDD requirements in Gherkin format.

## Workflow

### 0. Read Conventions

**First:** Read `.claude/rules/gherkin-conventions.md` to understand the project's conventions for:
- Folder structure (Domain → Subdomain → Capability)
- Feature ID format (`@DOM-SUB-CAP-NNN`)
- Tags (priority, status)
- Actors

### 1. Understand the Need

Ask the user:
- What should the functionality do?
- Who are the actors?
- What terms/expressions should be used?

### 2. Define Scenarios

For each scenario, ask about:
- Precondition (Given)
- Action (When)
- Expected result (Then)

**NEVER assume error messages or business logic - ask!**

### 3. Generate Feature File

**Location:** Follow the folder structure in `rules/gherkin-conventions.md`:
```
requirements/[NN] [Domain]/[NN] [Subdomain]/[NN] [Capability]/feature-name.feature
```

**Format:**
```gherkin
@[ID] @[priority]

Feature: [ID] [Name]
  As a [actor]
  I want to [action]
  So that [value].

  # OPEN QUESTIONS:
  # - [Any uncertainties are documented here]

  Background:
    Given [common precondition]

  Rule: [Business rule]

    Scenario: [Descriptive name]
      Given [precondition]
      When [action]
      Then [expected result]
```

**When uncertain:** Document with `# OPEN QUESTIONS:` right after the feature description (after "So that...").

### 4. Update Overview

Run the markdown generator to update `requirements/requirements-overview.md`:

```bash
cd requirements-parser && npm run generate-overview
```

This scans all `.feature` files and generates an updated overview with ID, feature name, tags, and statistics.

## Resources

- For BDD best practices, see [bdd-guide.md](bdd-guide.md)
- For a complete example, see [examples/gherkin-example.feature](examples/gherkin-example.feature)
- For project-specific rules, see `rules/gherkin-conventions.md`
