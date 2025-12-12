---
description: Set up Airtable tables for PM plugins (domain-knowledge, requirements)
---

# Airtable Setup

Create the required Airtable tables for PM plugins.

## Prerequisites

- Airtable MCP server configured
- An empty Airtable base ready
- Token with `schema.bases:write` and `data.records:write` permissions

## Tables to Create

### Domain Knowledge Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **Domain** | Name, Description | Top-level domain areas |
| **Subdomain** | Name, Description, → Domain | Sub-areas within domains |
| **Entity** | Name, Description, → Subdomain | Domain entities |
| **Attribute** | Name, Datatype, Description, Required, → Entity | Entity properties |
| **Process** | Name, Description, Trigger, Steps, → Domain | Business processes |
| **Glossary** | Term, Definition, Context, → Domain | Ubiquitous language |

### Requirements Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **Requirement** | ReqID, Title, Description, Status, Priority, → Domain | Requirements with MoSCoW |
| **Rule** | Rule, → Requirement | Business rules |
| **Example** | Example, ExpectedResult, → Rule | Concrete examples |
| **OpenQuestion** | Question, Answer, Status, → Requirement | Unresolved questions |

### Backlog Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **BacklogItem** | Title, Description, Type, Order, Status, → Requirements | Product backlog with ordering |

## Workflow

1. **List available bases** - Use `list_bases` to find the target base
2. **Confirm base** - Ask user which base to set up
3. **Check existing tables** - Use `list_tables` to see what exists
4. **Create tables in order** - Create parent tables before children (for links)
5. **Verify setup** - List tables to confirm creation

## Table Creation Order

Must create in this order due to relationships:

1. Domain (no dependencies)
2. Subdomain (links to Domain)
3. Entity (links to Subdomain)
4. Attribute (links to Entity)
5. Process (links to Domain)
6. Glossary (links to Domain)
7. Requirement (links to Domain)
8. Rule (links to Requirement)
9. Example (links to Rule)
10. OpenQuestion (links to Requirement)
11. BacklogItem (links to Requirements)

## Field Specifications

### Domain
```json
{
  "name": "Domain",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Prefix", "type": "singleLineText", "description": "3-letter code for requirement IDs"}
  ]
}
```

### Subdomain
```json
{
  "name": "Subdomain",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Domain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Domain table ID>"}}
  ]
}
```

### Entity
```json
{
  "name": "Entity",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Subdomain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Subdomain table ID>"}}
  ]
}
```

### Attribute
```json
{
  "name": "Attribute",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Datatype", "type": "singleSelect", "options": {"choices": [
      {"name": "String"}, {"name": "Integer"}, {"name": "Boolean"},
      {"name": "Date"}, {"name": "DateTime"}, {"name": "Decimal"},
      {"name": "Array"}, {"name": "Object"}
    ]}},
    {"name": "Description", "type": "multilineText"},
    {"name": "Required", "type": "checkbox"},
    {"name": "Entity", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Entity table ID>"}}
  ]
}
```

### Process
```json
{
  "name": "Process",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Trigger", "type": "singleLineText"},
    {"name": "Steps", "type": "multilineText"},
    {"name": "Domain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Domain table ID>"}}
  ]
}
```

### Glossary
```json
{
  "name": "Glossary",
  "fields": [
    {"name": "Term", "type": "singleLineText"},
    {"name": "Definition", "type": "multilineText"},
    {"name": "Context", "type": "multilineText"},
    {"name": "Domain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Domain table ID>"}}
  ]
}
```

### Requirement
```json
{
  "name": "Requirement",
  "fields": [
    {"name": "ReqID", "type": "singleLineText", "description": "e.g., ADM-001"},
    {"name": "Title", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Status", "type": "singleSelect", "options": {"choices": [
      {"name": "Draft"}, {"name": "Review"}, {"name": "Approved"},
      {"name": "Implementing"}, {"name": "Done"}, {"name": "Deprecated"}
    ]}},
    {"name": "Priority", "type": "singleSelect", "options": {"choices": [
      {"name": "Must", "color": "redDark1"},
      {"name": "Should", "color": "orangeLight1"},
      {"name": "Could", "color": "yellowLight1"},
      {"name": "Wont", "color": "grayLight1"}
    ]}},
    {"name": "Domain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Domain table ID>"}}
  ]
}
```

### Rule
```json
{
  "name": "Rule",
  "fields": [
    {"name": "Rule", "type": "multilineText"},
    {"name": "Requirement", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Requirement table ID>"}}
  ]
}
```

### Example
```json
{
  "name": "Example",
  "fields": [
    {"name": "Example", "type": "multilineText"},
    {"name": "ExpectedResult", "type": "multilineText"},
    {"name": "Rule", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Rule table ID>"}}
  ]
}
```

### OpenQuestion
```json
{
  "name": "OpenQuestion",
  "fields": [
    {"name": "Question", "type": "multilineText"},
    {"name": "Answer", "type": "multilineText"},
    {"name": "Status", "type": "singleSelect", "options": {"choices": [
      {"name": "Open"}, {"name": "Answered"}, {"name": "Closed"}
    ]}},
    {"name": "Requirement", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Requirement table ID>"}}
  ]
}
```

### BacklogItem
```json
{
  "name": "BacklogItem",
  "fields": [
    {"name": "Title", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Type", "type": "singleSelect", "options": {"choices": [
      {"name": "Feature", "color": "blueBright"},
      {"name": "Fix", "color": "redBright"},
      {"name": "Tech Debt", "color": "purpleBright"},
      {"name": "Spike", "color": "yellowBright"}
    ]}},
    {"name": "Order", "type": "number", "options": {"precision": 0}, "description": "Priority order (lower = higher priority)"},
    {"name": "Status", "type": "singleSelect", "options": {"choices": [
      {"name": "Backlog"}, {"name": "Ready"}, {"name": "In Progress"}, {"name": "Done"}
    ]}},
    {"name": "Requirements", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Requirement table ID>"}}
  ]
}
```

## Notes

- Delete the default "Table 1" after setup if not needed
- Tables can be customized after creation
- Links are created automatically when specifying linkedTableId
