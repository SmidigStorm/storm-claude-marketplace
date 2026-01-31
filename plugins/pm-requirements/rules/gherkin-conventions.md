---
paths:
  - "requirements/**/*.feature"
  - "**/*.feature"
---

# Gherkin Conventions

Project-specific rules for .feature files.

## Language

- Use English Gherkin keywords
- Keywords: Feature, Scenario, Given, When, Then, And, But, Rule, Background, Scenario Outline, Examples

## Folder Structure

Three levels: **Domain → Subdomain → Capability**

Feature files should **only** be placed at the capability level (level 3).

```
requirements/
└── [NN] [Domain]/
    └── [NN] [Subdomain]/
        └── [NN] [Capability]/
            └── feature-name.feature
```

### Domains

Define your project domains here. Examples:
- `00 Core` - Core functionality
- `01 User Management` - User accounts and authentication
- `02 Orders` - Order processing
- `03 Inventory` - Stock management
- `04 Reporting` - Reports and analytics
- `99 Demo` - Demo and testing

### Example

```
requirements/
└── 02 Orders/
    └── 01 Order Processing/
        └── 01 Validation/
            └── order-validation.feature
```

## Tags

### Feature ID

Each feature **must have** a unique ID in both the tag and the feature name.

**Format:**
```
@DOM-SUB-CAP-NNN
Feature: DOM-SUB-CAP-NNN Feature Name
```

- `DOM` = 3-letter abbreviation for domain
- `SUB` = 3-letter abbreviation for subdomain
- `CAP` = 3-letter abbreviation for capability
- `NNN` = Unique sequence number per feature (001, 002, 003...)

**Abbreviations:** Derived logically from the folder name (usually first 3 letters, but exceptions for readability). Ask if unsure.

**Examples:**
```gherkin
@ORD-PRO-VAL-001
Feature: ORD-PRO-VAL-001 Order Validation Rules
```

```gherkin
@USR-AUT-LOG-001
Feature: USR-AUT-LOG-001 User Login
```

**For new features:** Check existing features in the same folder to find the next available sequence number.

### Priority (MoSCoW)
- `@must` / `@should` / `@could` / `@wont`

### Status
- `@implemented` - Fully implemented
- `@in-progress` - Under implementation
- `@planned` - Planned

## Open Questions

Document uncertainties with comments:

```gherkin
# OPEN QUESTIONS:
# - Question here

Scenario: ...
  # TODO: Clarify with product owner
```

## Actors

Define your project actors here. Examples:
- administrator, applicant, customer, agent
