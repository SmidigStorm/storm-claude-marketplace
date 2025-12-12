---
description: Guided implementation planning from Airtable backlog item with codebase understanding
argument-hint: Optional backlog item title or ID
---

# Implementation Planning (Airtable)

You are helping a developer create an implementation plan for an Airtable BacklogItem. Follow a systematic approach: load the backlog item and requirements, explore the codebase, ask clarifying questions, then design the implementation plan together.

**Prerequisites:**
- Airtable MCP server configured
- PM tables set up (run `pm-airtable-setup` if needed)

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities, edge cases, and underspecified behaviors. Ask specific, concrete questions rather than making assumptions. Wait for user answers before proceeding.
- **Understand before planning**: Read and comprehend existing code patterns first
- **Interactive**: Every major decision involves the user
- **Traceable**: Link plan steps to requirements from Airtable
- **Use TodoWrite**: Track all progress throughout

---

## Phase 1: Discovery

**Goal**: Load and understand the backlog item

Initial request: $ARGUMENTS

**Actions**:
1. Create todo list with all phases
2. If no specific item given, list BacklogItems from Airtable:
   ```
   list_records(baseId, "BacklogItem", sort=[{field: "Order", direction: "asc"}])
   ```
3. Ask user which item to plan
4. Fetch the full BacklogItem record
5. Summarize the item and confirm with user

---

## Phase 2: Requirements Loading

**Goal**: Load and understand all linked requirements

**Actions**:
1. Fetch linked Requirement records from the BacklogItem
2. For each requirement, also fetch:
   - Rules (business rules)
   - Examples (concrete scenarios)
   - OpenQuestions (unresolved items)
3. Present requirements summary:
   - ReqID (SUB-CAP-NNN)
   - Title and description
   - Priority (MoSCoW)
   - Rules and examples
4. **Ask user to confirm which requirements are in scope**
5. If there are OpenQuestions, discuss them now

---

## Phase 3: Codebase Exploration

**Goal**: Understand relevant existing code and patterns

**Actions**:
1. Ask user: "Are there specific areas of the codebase I should look at?"
2. Explore the codebase to understand:
   - Similar existing features
   - Relevant patterns and conventions
   - Where changes need to be made
   - Dependencies and integration points
3. Present comprehensive summary of findings
4. **Ask user if findings match their expectations**

---

## Phase 4: Clarifying Questions

**Goal**: Fill in gaps and resolve all ambiguities before designing

**CRITICAL**: This is one of the most important phases. DO NOT SKIP.

**Actions**:
1. Review requirements (Rules, Examples) and codebase findings
2. Identify underspecified aspects:
   - Edge cases not covered by Examples
   - Error handling
   - Integration points
   - Scope boundaries
   - Performance needs
3. **Present all questions to the user in a clear, organized list**
4. **Wait for answers before proceeding to plan design**
5. Optionally create OpenQuestion records in Airtable for tracking

If the user says "whatever you think is best", provide your recommendation and get explicit confirmation.

---

## Phase 5: Plan Design

**Goal**: Design the implementation approach collaboratively

**Actions**:
1. Based on codebase patterns, propose implementation approach
2. If multiple valid approaches exist, present options with trade-offs:
   - Minimal changes (smallest change, maximum reuse)
   - Clean architecture (maintainability, elegant abstractions)
   - Pragmatic balance (speed + quality)
3. Present your recommendation with reasoning
4. **Ask user which approach they prefer**
5. Break down into concrete implementation steps
6. Map each step to requirements it implements (use ReqIDs)
7. **Confirm plan with user before documenting**

---

## Phase 6: Document Plan

**Goal**: Create the plan document

**Output**: `docs/plans/[backlog-item-name].md`

**Actions**:
1. Create plan document with:
   - BacklogItem reference (Airtable ID)
   - Requirements in scope (with ReqIDs)
   - Rules and acceptance criteria
   - Codebase patterns to follow
   - Implementation steps with file paths
   - Open questions (if any)
2. Mark all todos complete
3. Present summary to user

---

## Plan Document Template

```markdown
# [BacklogItem Title]

**Airtable ID**: [record ID]
**Order**: [priority number]
**Type**: [Feature/Fix/Tech Debt/Spike]

## Summary
[BacklogItem description]

## Requirements

### [CAR-DEA-001] [Title]
**Priority**: Must
**Status**: Approved

**Rules**:
- [Rule from Airtable]
- [Rule from Airtable]

**Examples**:
- Given [context], when [action], then [result]

---

### [CAR-DEA-002] [Title]
...

## Codebase Patterns
- [Pattern 1]: Found in `path/to/file.ts:line`
- [Pattern 2]: Found in `path/to/file.ts:line`

## Implementation Steps

### Step 1: [Description]
**Implements**: CAR-DEA-001
**Files**:
- `path/to/file.ts` - [What to change]

### Step 2: [Description]
**Implements**: CAR-DEA-001, CAR-DEA-002
**Files**:
- `path/to/new-file.ts` - [Create new file for X]
- `path/to/existing.ts` - [Modify Y]

## Acceptance Criteria
- [ ] CAR-DEA-001: [From Rules/Examples]
- [ ] CAR-DEA-002: [From Rules/Examples]

## Open Questions
- [From OpenQuestion records or discovered during planning]

## Decisions Made
- [Decision 1]: [Rationale]
- [Decision 2]: [Rationale]
```

---

## Airtable Queries Reference

```javascript
// List backlog items by priority
list_records(baseId, "BacklogItem", sort=[{field: "Order", direction: "asc"}])

// Get specific backlog item
get_record(baseId, "BacklogItem", recordId)

// Get requirements for a capability
list_records(baseId, "Requirement", filterByFormula="...")

// Get rules for a requirement
list_records(baseId, "Rule", filterByFormula="FIND('{reqRecordId}', ARRAYJOIN({Requirement}))")

// Get examples for a rule
list_records(baseId, "Example", filterByFormula="FIND('{ruleRecordId}', ARRAYJOIN({Rule}))")

// Get open questions
list_records(baseId, "OpenQuestion", filterByFormula="AND({Status}='Open', FIND('{reqRecordId}', ARRAYJOIN({Requirement})))")
```
