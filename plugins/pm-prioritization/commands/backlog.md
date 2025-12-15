---
description: Manage product backlog as an ordered priority list
---

# Backlog

Manage the product backlog at `docs/strategy/backlog.md` as an ordered list where position = priority.

## Instructions

Ask the user what they want to do:

1. **Add item** - Add a new feature or fix to the backlog
2. **Prioritize** - Reorder items by priority
3. **View** - Show the current backlog

### Option 1: Add Item

1. Ask for:
   - **Title**: Short name for the item
   - **Description**: What it does and why it matters (1-2 sentences)
   - **Type**: Feature, Fix, Tech Debt, or Spike

2. Ask where to insert in the list (top, bottom, or after item X)

3. Add the item to `docs/strategy/backlog.md`

### Option 2: Prioritize

1. Read the current backlog
2. Show the numbered list
3. Ask the user how they want to reorder:
   - "Move item X to position Y"
   - "Swap items X and Y"
   - "Move item X to top"
4. Update the backlog file with new order

### Option 3: View

1. Read and display the backlog as a numbered list
2. Show status for each item (backlog, in-progress, done)
3. Ask if the user wants to:
   - Reorder items
   - Update an item's status
   - Add a new item

## Backlog Format

Store in `docs/strategy/backlog.md`:

```markdown
# Product Backlog

| # | Title | Type | Status | Description |
|---|-------|------|--------|-------------|
| 1 | User authentication | Feature | backlog | Allow users to login with email/password |
| 2 | Fix checkout bug | Fix | in-progress | Cart total not updating on quantity change |
| 3 | Dark mode | Feature | backlog | Add dark theme option for accessibility |
| 4 | Refactor API layer | Tech Debt | backlog | Clean up duplicate API call patterns |
| 5 | Evaluate caching options | Spike | done | Research Redis vs Memcached for session storage |
```

## Notes

- Position in list = priority (1 is highest)
- Keep descriptions focused on user value, not implementation
- Update status as work progresses: backlog → in-progress → done
- Items can be reordered at any time during prioritization
