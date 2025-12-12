---
name: requirements-writing
description: BDD requirements using Gherkin syntax. Activates when users describe features, requirements, user stories, acceptance criteria, or work with .feature files. Generates Given-When-Then scenarios, validates Gherkin structure, and creates complete feature files.
---

# Requirements Writing

## Overview

This skill enables assistance with Behavior-Driven Development (BDD) requirements documentation using Gherkin syntax. It helps create well-structured feature files with Given-When-Then scenarios.

## Core Principles

### The Golden Gherkin Rule

> "Write Gherkin so that people who don't know the feature will understand it."

Treat readers as you'd want to be treated - prioritize clarity for all audiences, including non-technical stakeholders.

### The Cardinal Rule of BDD

> "One Scenario, One Behavior!"

Each scenario must cover exactly ONE independent behavior. Never write multiple When-Then pairs in a single scenario. If you find yourself wanting to add another When-Then, create a separate scenario.

## CRITICAL: NO ASSUMPTIONS POLICY

**This skill MUST trigger dialogue with users, NOT make assumptions.**

AI has a strong tendency to:
- Fill in gaps when information is missing
- Invent business rules and validation logic
- Make up entity names and relationships
- Assume default behaviors and error messages

**NEVER do any of the above.** Instead:
- **ASK questions** when information is missing
- **WAIT for answers** before proceeding
- **DOCUMENT gaps** as open questions if user doesn't know
- **VERIFY understanding** before generating scenarios

### What to Always Ask

- "What error message should be shown?"
- "What validations are needed for this field?"
- "What should be the default behavior?"
- "Can you provide an example?"
- "What edge cases should we handle?"

## Requirement IDs

Every feature file gets a unique requirement ID for traceability.

### ID Format

```
[PREFIX]-[NUMBER] [Name]
```

- **PREFIX**: 3-letter code derived from domain folder name
- **NUMBER**: 3-digit sequential number (001, 002, ...)
- **Name**: Human-readable requirement name

Examples:
- `ADM-001 User Registration` (from `requirements/admission/`)
- `ORD-003 Order Checkout` (from `requirements/orders/`)
- `PAY-002 Payment Processing` (from `requirements/payments/`)

### Domain Prefix Mapping

The prefix is derived from the folder name:
- `admission` → `ADM`
- `orders` → `ORD`
- `payments` → `PAY`
- `users` → `USR`
- `inventory` → `INV`
- `authentication` → `AUT`

For custom domains, take the first 3 letters or ask the user for a preferred prefix.

### ID Tag in Feature Files

The requirement ID is added as a tag on the Feature:

```gherkin
@ADM-001
Feature: User Registration
  As a new user
  I want to register an account
  So that I can access the system
```

### Requirements Registry

All requirement IDs are tracked in `requirements/registry.md`:

```markdown
# Requirements Registry

## ADM - Admission

| ID | Name | File | Status |
|----|------|------|--------|
| ADM-001 | User Registration | admission/user-registration.feature | Active |
| ADM-002 | Email Verification | admission/email-verification.feature | Active |

## ORD - Orders

| ID | Name | File | Status |
|----|------|------|--------|
| ORD-001 | Create Order | orders/create-order.feature | Active |
```

### Registry Management Rules

1. **IDs are immutable** - Never reuse a deleted ID
2. **Sequential numbering** - Always use the next available number
3. **Status values**: `Active`, `Draft`, `Deprecated`
4. **Update registry** when creating, renaming, or deprecating features

## File Location and Organization

### Directory Structure

Feature files are organized in `requirements/` with subdirectories for each domain:

```
requirements/
├── registry.md                    # Tracks all requirement IDs
├── admission/
│   ├── user-registration.feature  # @ADM-001
│   └── email-verification.feature # @ADM-002
├── orders/
│   ├── create-order.feature       # @ORD-001
│   └── order-checkout.feature     # @ORD-002
└── payments/
    └── payment-processing.feature # @PAY-001
```

### File Naming

- Use **kebab-case** for filenames: `user-registration.feature`, `order-checkout.feature`
- Make names descriptive and match the feature's purpose
- Always use `.feature` extension

### Auto-Detection Workflow

1. **Read the registry** (`requirements/registry.md`) to get existing IDs
2. **Search for existing feature files** (use Glob: `**/*.feature`)
3. **Determine domain** and derive prefix from folder name
4. **Assign next ID** based on registry
5. **Update registry** after creating the feature file

## Domain Knowledge Discovery

**Before writing scenarios, ALWAYS ask about domain knowledge.**

1. **"Where do you keep your domain knowledge?"**
   - Schema files, type definitions, documentation
   - If none: Ask them to describe entities verbally

2. **"What entities are involved in this feature?"**
   - What do you call them in your system?
   - NEVER assume entity names

3. **"What are the business rules?"**
   - Validations, success criteria, error cases
   - NEVER invent business logic

**If user doesn't provide enough information:**
- Mark gaps with `# TODO:` or `# QUESTION:` comments
- Tag incomplete scenarios with `@wip`
- List open questions at top of file

### Example Mapping (Optional Discovery Technique)

A structured technique for refining requirements before writing Gherkin:

| Card Color | Purpose |
|------------|---------|
| **Yellow** | The user story or feature being discussed |
| **Blue** | Business rules / acceptance criteria |
| **Green** | Concrete examples for each rule |
| **Red** | Open questions to resolve |

**Process:**
1. Put the story on a yellow card
2. For each business rule, add a blue card
3. For each rule, add green cards with specific examples
4. Capture unknowns on red cards

**Benefits:**
- ~25 minutes per story
- Visual indicator if story is too large (too many cards)
- Green cards convert directly to Gherkin scenarios
- Red cards become `# QUESTION:` comments

## Core Capabilities

### 1. Auto-Detect Requirements

When users describe functionality, recognize it as a feature requirement and offer to create Gherkin scenarios.

### 2. Parse Feature Files

Read and understand existing feature files:
- Identify scenarios, steps, and structure
- Recognize Gherkin keywords
- Extract business rules and test coverage

### 3. Generate Scenarios

Convert descriptions into Given-When-Then scenarios:

1. **Extract context** - Preconditions (Given)
2. **Identify action** - Event or user action (When)
3. **Determine outcomes** - Expected results (Then)

**Guidelines:**
- Use declarative style (focus on "what" not "how")
- Write from user's perspective
- Make scenarios independent
- Add appropriate tags

### 4. Validate Syntax

Check feature files for:
- Proper keyword usage
- Correct hierarchy (Feature > Rule > Scenario > Steps)
- Valid Given-When-Then flow
- Data table and doc string formatting

### 5. Create Complete Feature Files

**Feature file structure:**

```gherkin
@ADM-001
Feature: User Registration
  As a new user
  I want to register an account
  So that I can access the system

  Background:
    Given the registration page is displayed

  Rule: Users must provide valid email and password

    Scenario: Successful registration
      Given I enter email "user@example.com"
      And I enter password "SecurePass123"
      When I submit the registration form
      Then I should see a confirmation message
      And a verification email should be sent

    @negative
    Scenario: Registration with existing email
      Given a user with email "existing@example.com" exists
      When I try to register with "existing@example.com"
      Then I should see "Email already registered"

  Rule: Password must meet security requirements

    Scenario Outline: Password validation
      When I enter password "<password>"
      Then I should see "<message>"

      Examples:
        | password | message                    |
        | short    | Password too short         |
        | nodigits | Password must have numbers |
```

## Gherkin Keywords

- **Feature** - High-level feature description
- **Rule** - Business rule grouping (organize scenarios under rules)
- **Scenario** / **Example** - Concrete test scenario
- **Given** - Initial context/precondition
- **When** - Action or event
- **Then** - Expected outcome
- **And** / **But** - Step continuation
- **Background** - Common setup steps
- **Scenario Outline** - Parameterized scenario
- **Examples** - Data table for outlines

## Handling Open Questions

### When to Document

- Business rules aren't fully defined
- Technical solutions are uncertain
- Stakeholder decisions are pending

### How to Document

**1. Use comments:**

```gherkin
# OPEN QUESTIONS:
# - What happens if the user is already registered?
# - Should we send a confirmation email?

Feature: User Registration
```

**2. Use tags:**

```gherkin
@wip @needs-clarification
Scenario: Registration with existing email
  Given a user with email "test@example.com" exists
  When I try to register with "test@example.com"
  # TODO: Clarify error message with product owner
  Then I should see an error message
```

**3. Document in steps:**

```gherkin
Scenario: Order with invalid payment
  Given I have items in my cart
  When I submit an invalid credit card
  # QUESTION: Should we show specific validation errors or generic message?
  Then I should see a payment error
```

### Tags for Incomplete Work

- `@wip` - Work in progress
- `@needs-clarification` - Awaiting stakeholder decision
- `@todo` - Needs additional work

## Best Practices

### CRITICAL: Keep It Focused

**1. Business Rules, Not Edge Cases**

Focus on documenting the core business rules - not every possible edge case or validation detail. A feature file should capture WHAT the system does, not exhaustively test every input combination.

**Too detailed (avoid):**
```gherkin
Scenario: Password too short (5 chars)
Scenario: Password too short (6 chars)
Scenario: Password too short (7 chars)
Scenario: Password missing uppercase
Scenario: Password missing lowercase
Scenario: Password missing number
Scenario: Password missing special char
```

**Focused on business rule (preferred):**
```gherkin
Rule: Password must meet security requirements

  Scenario Outline: Invalid password rejected
    When I enter password "<invalid_password>"
    Then I should see "<error_message>"

    Examples:
      | invalid_password | error_message              |
      | short            | Minimum 8 characters       |
      | nouppercas3      | Must include uppercase     |
      | NOLOWERCASE1     | Must include lowercase     |
```

**2. DRY - Use Scenario Outline**

When you have similar scenarios varying only in data, ALWAYS use Scenario Outline with Examples table instead of multiple separate scenarios.

**Repetitive (avoid):**
```gherkin
Scenario: Admin can access dashboard
  Given I am logged in as "admin"
  When I navigate to the dashboard
  Then I should see the dashboard

Scenario: Manager can access dashboard
  Given I am logged in as "manager"
  When I navigate to the dashboard
  Then I should see the dashboard

Scenario: Guest cannot access dashboard
  Given I am logged in as "guest"
  When I navigate to the dashboard
  Then I should see "Access denied"
```

**DRY with Scenario Outline (preferred):**
```gherkin
Scenario Outline: Role-based dashboard access
  Given I am logged in as "<role>"
  When I navigate to the dashboard
  Then I should see "<result>"

  Examples:
    | role    | result        |
    | admin   | the dashboard |
    | manager | the dashboard |
    | guest   | Access denied |
```

### Scenario Titles

**3. Good Scenario Titles**

Titles should be short one-liners that summarize the behavior.

**Avoid in titles:**
- Conjunctions: "and", "or", "but", "because", "since" (implies multiple behaviors)
- Assertion words: "verify", "assert", "should" (testing language, not behavior)
- Long titles (if hard to name, scenario needs restructuring)

**Good:** `Successful login with valid credentials`
**Bad:** `Verify user can login and should see dashboard`

### Limits

**4. Keep It Small**
- **Max ~10 steps per scenario** - lengthy scenarios indicate poor practices
- **Max ~12 scenarios per feature** - avoid overwhelming documents
- **One feature per file** - keep files focused and findable

### Writing Style

**5. Third-Person, Present Tense**
- Write consistently in third-person
- Use present tense for all steps
- Every step needs clear subject and predicate

**Good:** `Given the user is logged in` / `When the user submits the form`
**Avoid:** `Given I am logged in` (mixing perspectives)

### Structure

**6. Organize with Rules**
   - Always use Rule to group scenarios by business rules
   - Name rules after the business rule they represent

**7. Declarative over Imperative**
   - Good: `When the user registers a new account`
   - Avoid: `When the user clicks the button, fills the form, and submits`

**8. Business Language**
   - Use domain terminology
   - Match language from domain documentation

**9. Specific Examples**
   - Good: `Given the customer "John Smith" with order "ORD-123"`
   - Avoid: `Given a customer with an order`

**10. Independent Scenarios**
   - Each scenario should run independently
   - Use Background for common setup

**11. Meaningful Tags**
   - `@critical` - Critical functionality
   - `@smoke` - Smoke test suite
   - `@negative` - Negative test cases
   - `@slow` - Long-running tests

## Example Interaction

```
User: "Users should be able to register with email and password"

GOOD Response:
"I'll help create a feature file for user registration. First some questions:

1. Where do you keep domain knowledge? (schemas, docs)
2. What validations are needed? (email format, password strength)
3. What happens if the email is already taken?
4. Should we send a confirmation email?
5. What error messages should be shown?

Once I understand these, I'll create accurate scenarios."
```

## Quality Checks

When reviewing feature files, check for:
- Scenarios organized under Rule sections
- Proper Given-When-Then structure
- Opportunities for Background (repeated setup)
- Opportunities for Scenario Outline (repeated patterns)
- Missing edge cases
- Undocumented assumptions
