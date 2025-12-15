---
description: Generate BDD feature files with Gherkin syntax and requirement IDs
---

# Requirements

Create BDD feature files with unique requirement IDs using the requirements-writing skill.

## CRITICAL: NO ASSUMPTIONS ALLOWED

**NEVER make assumptions or fill in gaps.** This command triggers dialogue with the user, NOT independent generation.

**STOP and ASK when:**
- You don't know where domain knowledge is stored
- You don't know what entities are involved
- You don't know business rules or validation logic
- You don't know what should happen in edge cases
- You're uncertain about ANY detail

## Workflow

Ask the user what they want to do:

1. **Create feature** - Create a new feature file with unique ID
2. **Add scenario** - Add scenarios to existing feature
3. **Review feature** - Check existing feature file for issues
4. **List features** - Show registry of all requirements

### For Creating Features

Follow this process - **STOP at each step until user provides information**:

1. **Read the registry** (`docs/requirements/registry.md`)
   - Check existing requirement IDs
   - If registry doesn't exist, create it

2. **Determine location**
   - Ask which domain, subdomain, and capability this feature belongs to
   - Derive prefixes: subdomain (3 letters) + capability (3 letters)
   - If new, ask user for preferred 3-letter prefixes

3. **Assign requirement ID**
   - Find next available number for that subdomain-capability
   - Format: `[SUB]-[CAP]-[NUMBER]` (e.g., ADM-GRD-001)
   - Show the ID to user for confirmation

4. **Ask about domain knowledge**
   - "Where do you keep domain knowledge?" (schemas, docs, types)
   - "What entities are involved in this feature?"

5. **Clarify requirements**
   - "What business rules apply?"
   - "What validations are needed?"
   - "What error messages should be shown?"

6. **Generate feature file**
   - Add requirement ID as tag: `@ADM-GRD-001`
   - Organize with Rule sections
   - Use kebab-case filename

7. **Update registry**
   - Add new entry to `docs/requirements/registry.md`
   - Include: ID, Name, File path, Status

## Requirement ID Format

```
[SUB]-[CAP]-[NUMBER] [Name]
```

- **SUB**: 3-letter subdomain prefix (e.g., ADM for "Admission Rules")
- **CAP**: 3-letter capability prefix (e.g., GRD for "Grade Calculation")
- **NUMBER**: 3 digits, sequential (001, 002, ...)
- **Name**: Human-readable name

## Output Structure

```
docs/requirements/
├── registry.md                              # Requirement ID registry
└── [domain]/
    └── [subdomain]/
        └── [capability]/
            └── feature-name.feature         # @SUB-CAP-NNN
```

**Example:**
```
docs/requirements/
├── registry.md
└── admission/
    └── admission-rules/
        └── grade-calculation/
            └── weighted-average.feature     # @ADM-GRD-001
```

## Registry Format

```markdown
# Requirements Registry

## Admission (Domain)

### ADM - Admission Rules (Subdomain)

#### GRD - Grade Calculation (Capability)

| ID | Name | File | Status |
|----|------|------|--------|
| ADM-GRD-001 | Weighted Average | admission/admission-rules/grade-calculation/weighted-average.feature | Active |
```

## Example Dialogue

```
User: "Create requirements for grade calculation"

GOOD Response:
"I'll help create requirements for grade calculation.

First, let me check the registry... [reads docs/requirements/registry.md]

Some questions about where this belongs:
1. Which domain? (e.g., Admission)
2. Which subdomain? (e.g., Admission Rules - prefix ADM)
3. Which capability? (e.g., Grade Calculation - prefix GRD)

The next available ID would be: ADM-GRD-001

Your requirement will be: ADM-GRD-001 Weighted Average Calculation

Now some questions about the requirement:
1. Where do you keep domain knowledge?
2. What entities are involved?
3. What business rules apply?
4. What happens with missing grades?"
```

## Remember

- **Always assign a unique requirement ID**
- **Always update the registry**
- IDs are immutable - never reuse deleted IDs
- Dialogue first, documentation second
- Organize scenarios under Rule sections

For detailed guidance, refer to the requirements-writing skill.
