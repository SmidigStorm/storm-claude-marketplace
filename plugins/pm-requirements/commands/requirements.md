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

1. **Read the registry** (`requirements/registry.md`)
   - Check existing requirement IDs
   - If registry doesn't exist, create it

2. **Determine domain**
   - Ask which domain this feature belongs to
   - Derive prefix from folder name (admission → ADM)
   - If new domain, ask user for preferred 3-letter prefix

3. **Assign requirement ID**
   - Find next available number for that domain
   - Format: `[PREFIX]-[NUMBER]` (e.g., ADM-001)
   - Show the ID to user for confirmation

4. **Ask about domain knowledge**
   - "Where do you keep domain knowledge?" (schemas, docs, types)
   - "What entities are involved in this feature?"

5. **Clarify requirements**
   - "What business rules apply?"
   - "What validations are needed?"
   - "What error messages should be shown?"

6. **Generate feature file**
   - Add requirement ID as tag: `@ADM-001`
   - Organize with Rule sections
   - Use kebab-case filename

7. **Update registry**
   - Add new entry to `requirements/registry.md`
   - Include: ID, Name, File path, Status

## Requirement ID Format

```
[PREFIX]-[NUMBER] [Name]
```

- **PREFIX**: 3 letters from domain folder (admission → ADM)
- **NUMBER**: 3 digits, sequential (001, 002, ...)
- **Name**: Human-readable name

## Output Structure

```
requirements/
├── registry.md                    # Requirement ID registry
├── admission/
│   └── user-registration.feature  # @ADM-001
└── orders/
    └── create-order.feature       # @ORD-001
```

## Registry Format

```markdown
# Requirements Registry

## ADM - Admission

| ID | Name | File | Status |
|----|------|------|--------|
| ADM-001 | User Registration | admission/user-registration.feature | Active |
```

## Example Dialogue

```
User: "Create requirements for user registration"

GOOD Response:
"I'll help create requirements for user registration.

First, let me check the registry... [reads requirements/registry.md]

This belongs in the 'admission' domain (prefix: ADM).
The next available ID is ADM-001.

Your requirement will be: ADM-001 User Registration

Now some questions:
1. Where do you keep domain knowledge?
2. What entities are involved?
3. What validations are needed?
4. What happens if email is already taken?"
```

## Remember

- **Always assign a unique requirement ID**
- **Always update the registry**
- IDs are immutable - never reuse deleted IDs
- Dialogue first, documentation second
- Organize scenarios under Rule sections

For detailed guidance, refer to the requirements-writing skill.
