---
description: Execute an implementation plan step by step
argument-hint: Plan filename (e.g., user-registration)
---

# Execute Plan

You are helping a developer implement a plan from `docs/plans/`. Follow the plan systematically, implementing each step while keeping the user informed and involved.

## Core Principles

- **Follow the plan**: The plan was agreed upon - stick to it
- **Autonomous execution**: Complete the entire plan without stopping unless there's a problem
- **Stop on roadblocks**: If you hit ANY issue, stop immediately and ask for input
- **Track progress**: Update todos and check off acceptance criteria
- **Flag deviations**: If something doesn't match the plan, stop and discuss

---

## Phase 1: Load Plan

**Goal**: Read and understand the plan

Initial request: $ARGUMENTS

**Actions**:
1. If no plan specified, list available plans in `docs/plans/`
2. Read the specified plan file
3. Create todo list from implementation steps
4. Summarize the plan to user:
   - What we're building
   - Number of steps
   - Requirements being implemented
5. **Ask user to confirm ready to start**

---

## Phase 2: Pre-Implementation Check

**Goal**: Verify we're ready to implement

**Actions**:
1. Check if any open questions remain in the plan
   - If yes, resolve them with user first
2. Verify the codebase matches plan assumptions:
   - Do the referenced files exist?
   - Are patterns still as expected?
3. If anything changed since planning, discuss with user:
   - Update plan if needed
   - Or proceed with adjustments
4. **Confirm ready to implement**

---

## Phase 3: Implementation

**Goal**: Execute ALL steps from the plan autonomously

**IMPORTANT**: Execute the entire plan without stopping. Only stop if you hit a roadblock.

**For each step**:

1. Read all relevant files first

2. Implement the changes:
   - Follow codebase patterns noted in plan
   - Match existing code style
   - Add appropriate comments

3. Mark step complete in todo list

4. **Continue immediately to next step** (do not wait for user)

**STOP IMMEDIATELY if**:
- File doesn't exist or is different than expected
- Pattern/code has changed since planning
- Implementation conflicts with existing code
- Step is unclear or ambiguous
- You're unsure about the right approach
- Tests fail unexpectedly
- Any error or unexpected behavior

**When stopping**:
```
"I hit a roadblock at Step [X]:

[Clear description of the problem]

The plan expected [X] but I found [Y].

Options:
A) [Proposed solution]
B) [Alternative approach]
C) [Skip and continue]

What would you like to do?"
```

**If NO roadblocks**: Complete all steps, then proceed to Phase 4.

---

## Phase 4: Verification

**Goal**: Verify implementation meets requirements

**Actions**:
1. Go through acceptance criteria from the plan
2. For each criterion:
   - Verify it's implemented
   - Mark as complete or flag issues
3. Run any relevant tests
4. Present verification summary:
   ```
   "Acceptance Criteria:
   ✓ [Criterion 1]
   ✓ [Criterion 2]
   ✗ [Criterion 3] - [issue]"
   ```
5. **Address any failed criteria with user**

---

## Phase 5: Completion

**Goal**: Wrap up and document

**Actions**:
1. Mark all todos complete
2. Update the plan file with completion status:
   - Add "Completed: [date]" to header
   - Check off all acceptance criteria
   - Note any deviations or decisions made
3. Summarize to user:
   - What was built
   - Files created/modified
   - Any follow-up items
4. Ask if user wants to commit the changes

---

## Dialogue Patterns

### Starting
```
"I'll execute the plan for [name].

Summary:
- [X] steps to implement
- Requirements: [REQ-IDs]
- Key files: [list]

I'll implement all steps and only stop if I hit a roadblock.
Ready to start?"
```

### On Roadblock (STOP)
```
"I hit a roadblock at Step [X]:

[Clear description of problem]

The plan expected [X] but I found [Y].

Options:
A) [Proposed solution]
B) [Alternative approach]
C) [Skip and continue]

What would you like to do?"
```

### After Roadblock Resolved
```
"Got it. Continuing with the plan..."
[Resume autonomous execution]
```

### Completing (all steps done)
```
"Implementation complete!

Steps completed: [X/X]

Created:
- [new files]

Modified:
- [changed files]

Acceptance Criteria: [X/Y] passing

Want me to commit these changes?"
```

## Red Flags - Stop and Discuss

- File doesn't exist that plan references
- Pattern changed since planning
- Step seems larger than expected
- Acceptance criterion can't be verified
- Implementation conflicts with existing code
- User seems unsure about a change

## Handling Deviations

When something doesn't match the plan:
1. Stop immediately
2. Explain what's different
3. Propose options
4. Document the decision
5. Update plan file if significant
