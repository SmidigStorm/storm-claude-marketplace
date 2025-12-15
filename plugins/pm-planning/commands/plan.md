---
description: Guided implementation planning with codebase understanding and requirement focus
argument-hint: Optional backlog item description
---

# Implementation Planning

You are helping a developer create an implementation plan for a backlog item. Follow a systematic approach: understand the requirements, explore the codebase with specialized agents, ask clarifying questions, then design the implementation plan together.

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities, edge cases, and underspecified behaviors. Ask specific, concrete questions rather than making assumptions. Wait for user answers before proceeding.
- **Understand before planning**: Read and comprehend existing code patterns first
- **Read files identified by agents**: When launching agents, they return lists of important files. Read those files to build detailed context.
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

**Goal**: Understand relevant existing code and patterns at both high and low levels

**Actions**:
1. Ask user: "Are there specific areas of the codebase I should look at?"
2. Launch 2-3 `code-explorer` agents in parallel. Each agent should:
   - Trace through the code comprehensively
   - Focus on getting a comprehensive understanding of abstractions, architecture and flow of control
   - Target a different aspect of the codebase
   - Include a list of 5-10 key files to read

   **Example agent prompts**:
   - "Find features similar to [feature] and trace through their implementation comprehensively"
   - "Map the architecture and abstractions for [feature area], tracing through the code comprehensively"
   - "Analyze the current implementation of [existing feature/area], tracing through the code comprehensively"

3. Once the agents return, read all files identified by agents to build deep understanding
4. Present comprehensive summary of findings and patterns discovered
5. **Ask user if findings match their expectations**

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

**Goal**: Design the implementation approach collaboratively using architecture expertise

**Actions**:
1. Launch 2-3 `code-architect` agents in parallel with different focuses:
   - **Minimal changes**: Smallest change, maximum reuse of existing code
   - **Clean architecture**: Maintainability, elegant abstractions
   - **Pragmatic balance**: Speed + quality

2. Review all approaches and form your opinion on which fits best for this task
   - Consider: small fix vs large feature, urgency, complexity, team context

3. Present to user:
   - Brief summary of each approach
   - Trade-offs comparison
   - **Your recommendation with reasoning**
   - Concrete implementation differences

4. **Ask user which approach they prefer**

5. Break down chosen approach into concrete implementation steps

6. Map each step to requirements it implements (SUB-CAP-NNN)

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
   - Decisions made (with rationale)
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

## Architecture Approach
[Which approach was chosen and why]

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
