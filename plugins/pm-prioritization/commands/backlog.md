---
description: Manage product backlog with MoSCoW prioritization
---

# Backlog

Manage the product backlog at `docs/strategy/backlog.md`.

## Instructions

Ask the user what they want to do:

1. **Add item** - Add a new feature or fix to the backlog
2. **Prioritize** - Review items and assign/update MoSCoW priorities
3. **View** - Show the current backlog

### Option 1: Add Item

1. Ask for:
   - **Title**: Short name for the item
   - **Description**: What it does and why it matters (1-2 sentences)
   - **Type**: Feature or Fix
   - **Priority**: Must / Should / Could / Won't (optional, can be set later)

2. Add the item to `docs/strategy/backlog.md` with status `backlog`

### Option 2: Prioritize

1. Read the current backlog
2. Show unprioritized items or items the user wants to review
3. For each item, ask for MoSCoW priority:
   - **Must** - Critical, non-negotiable for next release
   - **Should** - Important but not critical
   - **Could** - Nice to have if time permits
   - **Won't** - Not this time (but acknowledged)

4. Update the backlog file with new priorities

### Option 3: View

1. Read and display the backlog grouped by priority:
   - Must (do first)
   - Should
   - Could
   - Won't (parked)
   - Unprioritized

2. Show status for each item (backlog, in-progress, done)
3. Ask if the user wants to update any item's status

## Backlog Format

Store in `docs/strategy/backlog.md`:

```markdown
# Product Backlog

## Must

### [Title]
- **Type**: Feature | Fix
- **Status**: backlog | in-progress | done
- **Description**: [What and why]

## Should

### [Title]
...

## Could

### [Title]
...

## Won't

### [Title]
...

## Unprioritized

### [Title]
...
```

## Notes

- Keep descriptions focused on user value, not implementation
- Items move between priority sections during prioritization
- Update status as work progresses
- "Won't" means "not now" - keep items visible for future consideration
