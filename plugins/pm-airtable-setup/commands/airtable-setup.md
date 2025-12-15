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
| **Subdomain** | Name, Description, Prefix, → Domain | Sub-areas with 3-letter prefix |
| **Capability** | Name, Description, Prefix, → Subdomain | Functional groupings with 3-letter prefix |
| **Entity** | Name, Description, → Subdomain | Domain entities |
| **Attribute** | Name, Datatype, Description, Required, → Entity | Entity properties |
| **Relationship** | Name, Description, FromEntity, ToEntity, Cardinality | Entity connections |
| **Process** | Name, Description, Trigger, Steps, → Subdomain | Business processes |
| **Glossary** | Term, Definition, Context, → Subdomain | Ubiquitous language |

### Requirements Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **Requirement** | ReqID, Title, Description, Status, Priority, → Capability | Requirements with MoSCoW (ReqID: SUB-CAP-NNN) |
| **Rule** | Rule, → Requirement | Business rules |
| **Example** | Example, ExpectedResult, → Rule | Concrete examples |
| **OpenQuestion** | Question, Answer, Status, → Requirement | Unresolved questions |

### Backlog Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **BacklogItem** | Title, Description, Type, Order, Status, → Requirements, → Recommendation | Product backlog with ordering |

### Optional: Testing Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **TestSuite** | Name, Description | Groups related tests |
| **Test** | Name, Description, Steps, ExpectedResult, → TestSuite, → Requirement | Individual test cases |
| **TestRun** | RunDate, Status, Notes, → TestSuite | Execution records |

### Optional: Research Tables

| Table | Fields | Purpose |
|-------|--------|---------|
| **Fact** | Fact, Source, Date | Raw research observations |
| **Insight** | Insight, → Facts | Patterns from facts |
| **Recommendation** | Recommendation, Priority, → Insights | Actionable suggestions |

## Workflow

1. **List available bases** - Use `list_bases` to find the target base
2. **Confirm base** - Ask user which base to set up
3. **Check existing tables** - Use `list_tables` to see what exists
4. **Create tables in order** - Create parent tables before children (for links)
5. **Verify setup** - List tables to confirm creation

## Table Creation Order

Must create in this order due to relationships:

**Core tables:**
1. Domain (no dependencies)
2. Subdomain (links to Domain)
3. Capability (links to Subdomain)
4. Entity (links to Subdomain)
5. Attribute (links to Entity)
6. Relationship (links to Entity twice)
7. Process (links to Subdomain)
8. Glossary (links to Subdomain)
9. Requirement (links to Capability)
10. Rule (links to Requirement)
11. Example (links to Rule)
12. OpenQuestion (links to Requirement)

**Optional - Testing:**
13. TestSuite (no dependencies)
14. Test (links to TestSuite, Requirement)
15. TestRun (links to TestSuite)

**Optional - Research:**
16. Fact (no dependencies)
17. Insight (links to Fact)
18. Recommendation (links to Insight)

**Backlog (after all others):**
19. BacklogItem (links to Requirement, Recommendation)

## Field Specifications

### Domain
```json
{
  "name": "Domain",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"}
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
    {"name": "Prefix", "type": "singleLineText", "description": "3-letter code (e.g., ADM, ENR)"},
    {"name": "Domain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Domain table ID>"}}
  ]
}
```

### Capability
```json
{
  "name": "Capability",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Prefix", "type": "singleLineText", "description": "3-letter code (e.g., GRD, ELG)"},
    {"name": "Subdomain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Subdomain table ID>"}}
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

### Relationship
```json
{
  "name": "Relationship",
  "fields": [
    {"name": "Name", "type": "singleLineText", "description": "e.g., 'has many', 'belongs to'"},
    {"name": "Description", "type": "multilineText"},
    {"name": "FromEntity", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Entity table ID>"}},
    {"name": "ToEntity", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Entity table ID>"}},
    {"name": "Cardinality", "type": "singleSelect", "options": {"choices": [
      {"name": "1:1"}, {"name": "1:N"}, {"name": "N:N"}
    ]}}
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
    {"name": "Subdomain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Subdomain table ID>"}}
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
    {"name": "Subdomain", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Subdomain table ID>"}}
  ]
}
```

### Requirement
```json
{
  "name": "Requirement",
  "fields": [
    {"name": "ReqID", "type": "singleLineText", "description": "Format: SUB-CAP-NNN (e.g., ADM-GRD-001)"},
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
    {"name": "Capability", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Capability table ID>"}}
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

### TestSuite (Optional)
```json
{
  "name": "TestSuite",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"}
  ]
}
```

### Test (Optional)
```json
{
  "name": "Test",
  "fields": [
    {"name": "Name", "type": "singleLineText"},
    {"name": "Description", "type": "multilineText"},
    {"name": "Steps", "type": "multilineText"},
    {"name": "ExpectedResult", "type": "multilineText"},
    {"name": "TestSuite", "type": "multipleRecordLinks", "options": {"linkedTableId": "<TestSuite table ID>"}},
    {"name": "Requirement", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Requirement table ID>"}}
  ]
}
```

### TestRun (Optional)
```json
{
  "name": "TestRun",
  "fields": [
    {"name": "RunDate", "type": "date"},
    {"name": "Status", "type": "singleSelect", "options": {"choices": [
      {"name": "Pass"}, {"name": "Fail"}, {"name": "Partial"}, {"name": "Skipped"}
    ]}},
    {"name": "Notes", "type": "multilineText"},
    {"name": "TestSuite", "type": "multipleRecordLinks", "options": {"linkedTableId": "<TestSuite table ID>"}}
  ]
}
```

### Fact (Optional)
```json
{
  "name": "Fact",
  "fields": [
    {"name": "Fact", "type": "multilineText"},
    {"name": "Source", "type": "singleLineText"},
    {"name": "Date", "type": "date"}
  ]
}
```

### Insight (Optional)
```json
{
  "name": "Insight",
  "fields": [
    {"name": "Insight", "type": "multilineText"},
    {"name": "Facts", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Fact table ID>"}}
  ]
}
```

### Recommendation (Optional)
```json
{
  "name": "Recommendation",
  "fields": [
    {"name": "Recommendation", "type": "multilineText"},
    {"name": "Priority", "type": "singleSelect", "options": {"choices": [
      {"name": "High"}, {"name": "Medium"}, {"name": "Low"}
    ]}},
    {"name": "Insights", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Insight table ID>"}}
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
    {"name": "Requirements", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Requirement table ID>"}},
    {"name": "Recommendation", "type": "multipleRecordLinks", "options": {"linkedTableId": "<Recommendation table ID>"}}
  ]
}
```

## Notes

- Delete the default "Table 1" after setup if not needed
- Tables can be customized after creation
- Links are created automatically when specifying linkedTableId
- Optional tables (Testing, Research) can be skipped if not needed
- The ReqID format SUB-CAP-NNN combines Subdomain prefix + Capability prefix + sequence number
