---
name: requirements-writing
description: >
  BDD/Gherkin knowledge skill. Activates automatically when the user works with
  .feature files, requirements, or BDD-related tasks. Gives Claude understanding
  of Gherkin syntax and BDD best practices.
---

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

## Resources

### examples/gherkin-example.feature

Complete example demonstrating all best practices:
- Feature ID in both tag and feature name
- Multiple Rule sections organizing scenarios by business rules
- Background for common setup with data tables
- MoSCoW prioritization and status tags (`@must`, `@should`, `@implemented`, `@planned`)
- Scenario Outline with Examples table for parameterized tests
- Doc strings for complex messages
- Open questions documented with `# OPEN QUESTIONS:` comments under feature description
- Declarative style (focus on "what", not "how")
- Concrete, specific examples with realistic values

Read this example when you need a template for new feature files.

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

## Tags

See `rules/gherkin-conventions.md` for the complete list. Main categories:

| Category | Tags |
|----------|------|
| Feature ID | `@DOM-SUB-CAP-NNN` (e.g., `@ORD-PRO-VAL-001`) |
| Priority (MoSCoW) | `@must`, `@should`, `@could`, `@wont` |
| Status | `@implemented`, `@in-progress`, `@planned` |
