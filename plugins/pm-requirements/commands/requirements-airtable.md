---
description: Generate BDD requirements to Airtable (requirements, rules, examples)
---

# Requirements (Airtable)

Create BDD requirements in Airtable instead of markdown files.

**Prerequisites:**
- Airtable MCP server configured (`npx airtable-mcp-server`)
- Airtable base with required tables (run `pm-airtable-setup` plugin if not set up)

## Required Tables

This command writes to these Airtable tables:

| Table | Purpose |
|-------|---------|
| Domain | Domain areas (provides prefix for ReqID) |
| Requirement | Requirements with MoSCoW priority |
| Rule | Business rules for requirements |
| Example | Concrete examples (Example Mapping) |
| OpenQuestion | Unresolved questions |

## CRITICAL: NO ASSUMPTIONS ALLOWED

Same as `/requirements` - always ask questions, never invent requirement details.

## Workflow

Ask the user what they want to do:

1. **Create requirement** - Create requirement record with unique ID
2. **Add rules** - Add Rule records linked to a requirement
3. **Add examples** - Add Example records linked to rules
4. **Track question** - Add OpenQuestion for unclear items
5. **View requirements** - List existing requirements from Airtable

### Before Starting

1. **Check Airtable connection** - Use `list_bases` to verify MCP is working
2. **Verify tables exist** - Use `list_tables` to check structure
3. **If tables missing** - Tell user to run `pm-airtable-setup` plugin first

### For Creating Requirements

1. **List existing domains** - Use `list_records` on Domain table
2. **Ask which domain** - Or create new Domain if needed
3. **Determine next ReqID**
   - Get domain's Prefix (e.g., "ADM")
   - Count existing requirements for that domain
   - Next ID = `[PREFIX]-[NNN]` (e.g., ADM-001)
4. **Ask clarifying questions** (same as `/requirements`)
   - What entities are involved?
   - What business rules apply?
   - What validations are needed?
5. **Create Requirement record** with:
   - ReqID (e.g., ADM-001)
   - Title
   - Description
   - Status (Draft)
   - Priority (MoSCoW)
   - Domain link
6. **Add Rules** as separate Rule records linked to Requirement
7. **Add Examples** as Example records linked to Rules
8. **Track OpenQuestions** for anything unclear

## Airtable Field Mapping

### Requirement Table
| Field | Content |
|-------|---------|
| ReqID | Unique ID (e.g., ADM-001) |
| Title | Requirement name |
| Description | Detailed description |
| Status | Draft, Review, Approved, Implementing, Done, Deprecated |
| Priority | Must, Should, Could, Wont (MoSCoW) |
| Domain | Link to Domain record |

### Rule Table
| Field | Content |
|-------|---------|
| Rule | Business rule text (Given/When/Then style) |
| Requirement | Link to Requirement record |

### Example Table
| Field | Content |
|-------|---------|
| Example | Concrete example input |
| ExpectedResult | Expected outcome |
| Rule | Link to Rule record |

### OpenQuestion Table
| Field | Content |
|-------|---------|
| Question | The unresolved question |
| Answer | Answer when resolved |
| Status | Open, Answered, Closed |
| Requirement | Link to Requirement record |

## Example Interaction

```
User: "Create a requirement for user registration"

Response:
"I'll help create a requirement for user registration.

First, let me check the Airtable connection... [uses list_bases]
Checking tables... [uses list_tables]

Let me see existing domains:
[uses list_records on Domain table]

Found domain 'Admission' with prefix 'ADM'.
Checking existing requirements... [uses list_records with filter]

Next available ID is ADM-003.

Now some questions:
1. What's the title for this requirement?
2. What business rules apply to registration?
3. What's the MoSCoW priority? (Must/Should/Could/Wont)
..."
```

## Example Mapping to Airtable

When discovering requirements, use Example Mapping:
- Create Requirement record first
- For each Rule, create Rule record linked to Requirement
- For each Example of a Rule, create Example record linked to Rule
- For each Question, create OpenQuestion linked to Requirement

This maps directly to the Airtable structure:
```
Requirement (ADM-001 User Registration)
├── Rule (User must provide valid email)
│   ├── Example (Valid: user@example.com → Success)
│   └── Example (Invalid: not-an-email → Error)
├── Rule (Password must be 8+ characters)
│   └── Example (7 chars → Error, 8 chars → Success)
└── OpenQuestion (What if email domain is blocked?)
```

## BDD Best Practices (Same as /requirements)

- Follow Golden Gherkin Rule: scenarios from user perspective
- Use declarative style, not imperative
- Keep scenarios focused (max 10 steps)
- Use Scenario Outline for data variations
- One behavior per scenario

## Error Handling

- **MCP not available**: "Airtable MCP is not configured. Please set up the MCP server first."
- **Tables missing**: "Required tables not found. Please run the pm-airtable-setup plugin to create the Airtable structure."
- **Permission denied**: "Cannot write to Airtable. Check that your token has write permissions."

## Notes

- Uses the same requirements-writing skill for knowledge/best practices
- Only the storage destination differs from `/requirements`
- Requirements are linked to Domains for the prefix system
- Rules and Examples maintain the Example Mapping structure
