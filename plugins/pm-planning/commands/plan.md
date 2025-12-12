---
description: Guided implementation planning with codebase understanding and requirement focus
argument-hint: Optional backlog item description
---

# Implementation Planning

You are helping a developer create an implementation plan for a backlog item. Follow a systematic approach: understand the requirements, explore the codebase, ask clarifying questions, then design the implementation plan together.

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities, edge cases, and underspecified behaviors. Ask specific, concrete questions rather than making assumptions. Wait for user answers before proceeding.
- **Understand before planning**: Read and comprehend existing code patterns first
- **Interactive**: Every major decision involves the user
- **Traceable**: Link plan steps to requirements
- **Use TodoWrite**: Track all progress throughout

---

## Phase 1: Discovery

**Goal**: Understand what needs to be built

Initial request: $ARGUMENTS

**Actions**:
1. Create todo list with all phases
2. If backlog item unclear, ask user for:
   - What problem are they solving?
   - What should the feature do?
   - Who benefits from this?
   - Any constraints or requirements?
3. Summarize understanding and confirm with user

---

## Phase 2: Requirements Mapping

**Goal**: Identify all requirements this backlog item addresses

**Actions**:
1. List any known requirements (ask user)
2. For each requirement, clarify:
   - What is the acceptance criteria?
   - What are the business rules?
   - Any edge cases or examples?
3. Use SUB-CAP-NNN format if requirements exist in the system
4. **Confirm scope with user before proceeding**

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
1. Review requirements and codebase findings
2. Identify underspecified aspects:
   - Edge cases and error handling
   - Integration points
   - Scope boundaries
   - Performance needs
   - Backward compatibility
3. **Present all questions to the user in a clear, organized list**
4. **Wait for answers before proceeding to plan design**

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
6. Map each step to requirements it implements
7. **Confirm plan with user before documenting**

---

## Phase 6: Document Plan

**Goal**: Create the plan document

**Output**: `docs/plans/[backlog-item-name].md`

**Actions**:
1. Create plan document with:
   - Backlog item summary
   - Requirements in scope (with IDs)
   - Codebase patterns to follow
   - Implementation steps with file paths
   - Acceptance criteria
   - Open questions (if any)
2. Mark all todos complete
3. Present summary to user

---

## Plan Document Template

```markdown
# [Backlog Item Title]

## Summary
[What this plan accomplishes]

## Requirements
- [ ] SUB-CAP-001: [Title] - [Acceptance criteria]
- [ ] SUB-CAP-002: [Title] - [Acceptance criteria]

## Codebase Patterns
- [Pattern 1]: Found in `path/to/file.ts:line`
- [Pattern 2]: Found in `path/to/file.ts:line`

## Implementation Steps

### Step 1: [Description]
**Implements**: SUB-CAP-001
**Files**:
- `path/to/file.ts` - [What to change]

### Step 2: [Description]
**Implements**: SUB-CAP-001, SUB-CAP-002
**Files**:
- `path/to/new-file.ts` - [Create new file for X]
- `path/to/existing.ts` - [Modify Y]

## Acceptance Criteria
- [ ] [Criterion from requirements]
- [ ] [Criterion from requirements]

## Open Questions
- [Any unresolved items to address during implementation]

## Decisions Made
- [Decision 1]: [Rationale]
- [Decision 2]: [Rationale]
```
