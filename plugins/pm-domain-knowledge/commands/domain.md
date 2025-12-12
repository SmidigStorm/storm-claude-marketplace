---
description: Document domain knowledge including entities, processes, and ubiquitous language
---

# Domain Knowledge

Document domain knowledge systematically using the domain-knowledge skill.

## CRITICAL: NO ASSUMPTIONS ALLOWED

**NEVER make assumptions about the domain.** This command exists to trigger dialogue with the user, NOT to create documentation independently.

**STOP and ASK when:**
- You don't know what entities exist
- You don't know attributes or data types
- You don't know how entities relate
- You don't know process steps
- You're uncertain about ANY detail

## Workflow

Ask the user what they want to do:

1. **Document entity** - Create or update an entity in `domains/[domain]/entities/`
2. **Document process** - Create or update a process in `domains/[domain]/processes/`
3. **Add glossary term** - Add a term to `domains/[domain]/glossary/`
4. **View domain** - Show existing domain documentation

### For All Options

1. First check if `domains/` directory exists
2. Ask which domain area this belongs to (or create new)
3. Follow the dialogue-first approach from the skill
4. Create documentation only after user confirms details

### Documentation Structure

```
domains/
└── [domain-name]/
    ├── entities/
    │   ├── _overview.md
    │   └── {entity}.md
    ├── processes/
    │   ├── _overview.md
    │   └── {process}.md
    └── glossary/
        ├── _overview.md
        └── {term}.md
```

## Example Dialogue

```
User: "Document the Order entity"

GOOD Response:
"I'll help document the Order entity. First some questions:

1. Which domain does Order belong to? (e.g., 'ecommerce', 'sales')
2. What attributes does an Order have?
3. What are the data types for each?
4. How does Order relate to other entities?
5. What states can an Order be in?

I'll only document what you tell me."
```

## Remember

- **Dialogue first, documentation second**
- **Verify, don't assume**
- Mark unknowns with `# TODO:` or `# QUESTION:`
- Use Mermaid diagrams for visualization
- Keep files focused - one entity/process/term per file

For detailed templates, refer to the domain-knowledge skill.
