---
name: planning
description: Interactive implementation planning from backlog items. Use when creating plans for features, fixes, or tasks. Guides 6-phase collaborative dialogue from discovery through documentation.
---

# Implementation Planning

Guide for creating implementation plans through interactive dialogue.

## The 6 Phases

```
1. Discovery → 2. Requirements → 3. Codebase → 4. Questions → 5. Design → 6. Document
      ↑              ↑               ↑             ↑            ↑           ↑
    [User]         [User]         [User]        [User]       [User]      [User]
```

## Core Principles

1. **Interactive** - Every phase ends with user confirmation
2. **No assumptions** - Ask before deciding anything
3. **CRITICAL: Clarifying Questions** - Phase 4 is the most important, never skip
4. **Traceable** - Link plan steps to requirements (SUB-CAP-NNN)
5. **Concrete** - End with specific files and changes

## Phase Checklist

### Phase 1: Discovery
- [ ] Understand what needs to be built
- [ ] Clarify problem, solution, beneficiary
- [ ] User confirms understanding

### Phase 2: Requirements
- [ ] List all requirements in scope
- [ ] Clarify acceptance criteria per requirement
- [ ] User confirms scope

### Phase 3: Codebase
- [ ] Ask user for relevant areas
- [ ] Find similar features and patterns
- [ ] Present findings
- [ ] User confirms findings

### Phase 4: Clarifying Questions (CRITICAL)
- [ ] Review requirements + codebase
- [ ] List ALL ambiguities
- [ ] Present questions to user
- [ ] Get answers before proceeding

### Phase 5: Plan Design
- [ ] Propose approach (with alternatives if needed)
- [ ] Get user preference
- [ ] Break into steps with file paths
- [ ] Map steps to requirements
- [ ] User approves plan

### Phase 6: Document
- [ ] Create `docs/plans/[name].md`
- [ ] Include all sections
- [ ] Present summary

## Dialogue Patterns

### Opening (Phase 1)
```
"Let's plan [item]. Help me understand:
1. What problem does this solve?
2. Who benefits?
3. What does success look like?"
```

### Scoping (Phase 2)
```
"I see these requirements in scope:
- [REQ-1]
- [REQ-2]

Are these all? Any I'm missing?"
```

### Before Code Exploration (Phase 3)
```
"Before I explore the codebase:
- Any specific areas I should look at?
- Patterns I should follow?"
```

### Clarifying Questions (Phase 4)
```
"Before designing the plan, I need to clarify:

**Edge Cases:**
1. What happens when X?
2. How should Y behave if Z?

**Integration:**
3. Should this integrate with A?

**Scope:**
4. Is B included or out of scope?

Please answer these before I proceed."
```

### Presenting Options (Phase 5)
```
"I see two approaches:

**A) Minimal Changes**
- Reuse existing X
- Tradeoff: Less flexible

**B) Clean Architecture**
- New abstraction for Y
- Tradeoff: More work upfront

I recommend A because [reason].
Which do you prefer?"
```

## Red Flags - Stop and Ask

- Requirement is vague or undefined
- Multiple valid approaches exist
- Change impacts shared/core code
- Scope is growing beyond original item
- Conflict with existing behavior
- User says "whatever you think" (get explicit confirmation)

## Plan Quality Check

Before finalizing, verify:
- [ ] Each requirement maps to ≥1 step
- [ ] Each step has specific files
- [ ] Acceptance criteria are testable
- [ ] No orphan steps
- [ ] Open questions captured
- [ ] User approved each major decision
