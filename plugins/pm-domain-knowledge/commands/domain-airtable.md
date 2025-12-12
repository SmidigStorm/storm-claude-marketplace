---
description: Document domain knowledge to Airtable (entities, processes, glossary)
---

# Domain Knowledge (Airtable)

Document domain knowledge to Airtable instead of markdown files.

**Prerequisites:**
- Airtable MCP server configured (`npx airtable-mcp-server`)
- Airtable base with required tables (run `pm-airtable-setup` plugin if not set up)

## Required Tables

This command writes to these Airtable tables:

| Table | Purpose |
|-------|---------|
| Domain | Top-level domain areas |
| Subdomain | Sub-domains within domains |
| Entity | Domain entities (core business objects) |
| Attribute | Entity attributes/properties |
| Process | Business processes and workflows |
| Glossary | Ubiquitous language and terminology |

## CRITICAL: NO ASSUMPTIONS ALLOWED

Same as `/domain` - always ask questions, never invent domain details.

## Workflow

Ask the user what they want to do:

1. **Document entity** - Create entity in Entity table with Attribute records
2. **Document process** - Create process in Process table
3. **Add glossary term** - Add term to Glossary table
4. **Add domain/subdomain** - Create domain structure
5. **View domain** - List existing records from Airtable

### Before Starting

1. **Check Airtable connection** - Use `list_bases` to verify MCP is working
2. **Verify tables exist** - Use `list_tables` to check structure
3. **If tables missing** - Tell user to run `pm-airtable-setup` plugin first

### For Documenting Entities

1. Ask which domain/subdomain this entity belongs to
2. Search existing Domain/Subdomain records
3. Ask for entity details (same questions as `/domain`)
4. Create Entity record with `create_record`
5. Create Attribute records for each attribute, linked to Entity

### For Documenting Processes

1. Ask which domain this process belongs to
2. Ask for process details (goal, trigger, steps, actors)
3. Create Process record linked to Domain

### For Adding Glossary Terms

1. Ask which domain this term belongs to
2. Ask for the term, definition, and context
3. Create Glossary record linked to Domain

## Airtable Field Mapping

### Domain Table
| Field | Content |
|-------|---------|
| Name | Domain name |
| Description | Domain description |
| Prefix | 3-letter code for requirement IDs |

### Subdomain Table
| Field | Content |
|-------|---------|
| Name | Subdomain name |
| Description | Subdomain description |
| Domain | Link to Domain record |

### Entity Table
| Field | Content |
|-------|---------|
| Name | Entity name |
| Description | Entity description |
| Subdomain | Link to Subdomain record |

### Attribute Table
| Field | Content |
|-------|---------|
| Name | Attribute name |
| Datatype | String, Integer, Boolean, Date, DateTime, Decimal, Array, Object |
| Description | Attribute description |
| Required | Checkbox if attribute is required |
| Entity | Link to Entity record |

### Process Table
| Field | Content |
|-------|---------|
| Name | Process name |
| Description | Process description |
| Trigger | What initiates the process |
| Steps | Process steps (multiline) |
| Domain | Link to Domain record |

### Glossary Table
| Field | Content |
|-------|---------|
| Term | The domain term |
| Definition | What it means |
| Context | When/how it's used |
| Domain | Link to Domain record |

## Example Interaction

```
User: "Document the Order entity to Airtable"

Response:
"I'll help document the Order entity to Airtable.

First, let me check the connection... [uses list_bases]
Checking tables... [uses list_tables]

Which domain does Order belong to? Let me show existing domains:
[uses list_records on Domain table]

Now, what attributes does Order have?
..."
```

## Error Handling

- **MCP not available**: "Airtable MCP is not configured. Please set up the MCP server first."
- **Tables missing**: "Required tables not found. Please run the pm-airtable-setup plugin to create the Airtable structure."
- **Permission denied**: "Cannot write to Airtable. Check that your token has write permissions."

## Notes

- Uses the same domain-knowledge skill for knowledge/best practices
- Only the storage destination differs from `/domain`
- Records are linked via Airtable's relationship fields
- Glossary helps maintain ubiquitous language across the team
