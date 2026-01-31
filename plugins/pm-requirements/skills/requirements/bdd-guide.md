# BDD/Gherkin Best Practices

## Core Principle: NEVER ASSUME

When writing requirements, NEVER assume or invent:
- Error messages
- Validation rules
- Business logic
- Entity attributes

ALWAYS ask the user for missing details.

## One Scenario = One Behavior

Each scenario should test one specific behavior. If you need multiple When-Then pairs, create separate scenarios.

```gherkin
# WRONG - tests two things
Scenario: User logs in and sees dashboard
  When user logs in
  Then user sees welcome message
  When user clicks dashboard
  Then user sees statistics

# CORRECT - one scenario per behavior
Scenario: Successful login
  When user logs in
  Then user sees welcome message

Scenario: Navigate to dashboard
  Given user is logged in
  When user clicks dashboard
  Then user sees statistics
```

## Declarative vs Imperative

Write WHAT should happen, not HOW.

```gherkin
# WRONG - imperative (how)
When I click on the username field
And I type "test@example.com"
And I click on the password field
And I type "password123"
And I click on the login button

# CORRECT - declarative (what)
When I log in with "test@example.com"
```

## Use Scenario Outline for Variations

When the same scenario repeats with different values:

```gherkin
Scenario Outline: Input validation
  When user enters "<input>"
  Then user sees "<result>"

  Examples:
    | input   | result        |
    | valid   | Success       |
    | invalid | Error message |
    | empty   | Required field|
```

## Use Rule Sections

Group related scenarios under business rules:

```gherkin
Rule: Only active users can log in

  Scenario: Active user logs in
    ...

  Scenario: Deactivated user is denied access
    ...
```

## Background for Common Setup

Move repeated Given steps to Background:

```gherkin
Background:
  Given user is logged in
  And user is on dashboard

Scenario: View statistics
  When user clicks statistics
  Then ...
```

## Concrete Examples

Use specific, realistic values:

```gherkin
# WRONG - generic
Given a user exists
When user searches for something

# CORRECT - concrete
Given the user "John Smith" exists
When user searches for "computer science"
```

## Gherkin Keywords

| Keyword | Purpose |
|---------|---------|
| Feature | High-level functionality |
| Rule | Business rule (groups scenarios) |
| Background | Common preconditions |
| Scenario | Concrete test case |
| Scenario Outline | Parameterized test case |
| Examples | Data for Scenario Outline |
| Given | Precondition (context) |
| When | Action (trigger) |
| Then | Expected result |
| And/But | Continuation of previous step |

## Open Questions

Document uncertainties with comments, **NOT tags**:

```gherkin
Feature: My feature
  As a user...

  # OPEN QUESTIONS:
  # - Question 1
  # - Question 2

  Background:
    ...
```

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

## Actors

Define your project actors here. Examples:
- administrator, applicant, customer, agent

---

## Complete Example

See [examples/gherkin-example.feature](examples/gherkin-example.feature) for a complete example demonstrating:
- Feature ID in both tag and feature name
- Multiple Rule sections organizing scenarios by business rules
- Background for common setup with data tables
- MoSCoW prioritization and status tags (`@must`, `@should`, `@implemented`, `@planned`)
- Scenario Outline with Examples table for parameterized tests
- Doc strings for complex messages
- Open questions documented with `# OPEN QUESTIONS:` comments under feature description
- Declarative style (focus on "what", not "how")
- Concrete, specific examples with realistic values
