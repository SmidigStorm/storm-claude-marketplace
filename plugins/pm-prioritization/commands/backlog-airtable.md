---
description: Manage product backlog in Airtable with numbered prioritization
---

# Backlog (Airtable)

Manage the product backlog in Airtable instead of markdown files.

**Prerequisites:**
- Airtable MCP server configured (`npx airtable-mcp-server`)
- Airtable base with required tables (run `pm-airtable-setup` plugin if not set up)

## Required Tables

This command writes to these Airtable tables:

| Table | Purpose |
|-------|---------|
| BacklogItem | Product backlog items with ordering |
| Requirement | Links to requirement records (optional) |

## Workflow

Ask the user what they want to do:

1. **Add item** - Create a new backlog item
2. **Prioritize** - Reorder items by updating Order field
3. **View backlog** - List items sorted by Order
4. **Link requirements** - Connect backlog items to requirements
5. **Update status** - Change item status

### Before Starting

1. **Check Airtable connection** - Use `list_bases` to verify MCP is working
2. **Verify tables exist** - Use `list_tables` to check structure
3. **If tables missing** - Tell user to run `pm-airtable-setup` plugin first

### Option 1: Add Item

1. Ask for:
   - **Title**: Short name for the item
   - **Description**: What it does and why it matters
   - **Type**: Feature, Fix, Tech Debt, or Spike

2. Determine Order:
   - List existing items to find max Order
   - New item gets Order = max + 1 (added to bottom)
   - Or ask user where to insert

3. Create BacklogItem record with Status = "Backlog"

### Option 2: Prioritize

1. List current items sorted by Order
2. Ask user how to reorder:
   - "Move X to position Y"
   - "Move X above/below Y"
3. Update Order fields for affected items
4. Show updated list

### Option 3: View Backlog

1. Use `list_records` with sort by Order (ascending)
2. Display grouped by Status:
   - In Progress (actively being worked on)
   - Ready (prioritized, ready to start)
   - Backlog (awaiting prioritization)
   - Done (completed)
3. Show Order number for each item

### Option 4: Link Requirements

1. Show backlog item
2. List available Requirements from Requirement table
3. Add selected Requirements to the BacklogItem's Requirements field
4. This connects user stories to their detailed BDD requirements

### Option 5: Update Status

1. Show current items with status
2. Ask which item to update
3. Update status to: Backlog, Ready, In Progress, or Done

## Airtable Field Mapping

### BacklogItem Table
| Field | Content |
|-------|---------|
| Title | Item name |
| Description | What and why |
| Type | Feature, Fix, Tech Debt, Spike |
| Order | Priority number (1 = highest priority) |
| Status | Backlog, Ready, In Progress, Done |
| Requirements | Links to Requirement records |

## Priority vs Order

This plugin uses **numbered ordering** instead of MoSCoW for backlog items:
- **Order 1** = Top priority, work on first
- **Order 2, 3, 4...** = Subsequent priorities
- Items with same Order are equal priority

MoSCoW priority exists on **Requirements** (Must/Should/Could/Won't).

This allows:
- Backlog: "What to work on next" (ordered list)
- Requirements: "How important is this feature" (MoSCoW)

## Example Interaction

```
User: "Add a new feature to the backlog"

Response:
"I'll help add a feature to the backlog.

Let me check the Airtable connection... [uses list_bases]
Checking tables... [uses list_tables]

Current backlog items:
[uses list_records on BacklogItem sorted by Order]

1. User Authentication (In Progress)
2. Dashboard Charts (Ready)
3. Export to PDF (Backlog)

What's the title for your new feature?
What does it do and why does it matter?
Type: Feature, Fix, Tech Debt, or Spike?

Should I add it at position 4, or insert it higher?"
```

## Error Handling

- **MCP not available**: "Airtable MCP is not configured. Please set up the MCP server first."
- **Tables missing**: "Required tables not found. Please run the pm-airtable-setup plugin to create the Airtable structure."
- **Permission denied**: "Cannot write to Airtable. Check that your token has write permissions."

## Notes

- Order numbers can have gaps (1, 2, 5, 10) - only relative order matters
- Link BacklogItems to Requirements to connect high-level stories to detailed specs
- Use the View option to see current state before making changes
