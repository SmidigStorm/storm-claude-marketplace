# pm-domain-knowledge

Document domain knowledge including entities, processes, and ubiquitous language.

## Commands

### `/domain`

Interactive documentation with options:

- **Document entity** - Capture domain entities with attributes and relationships
- **Document process** - Document business workflows and processes
- **Add glossary term** - Build ubiquitous language dictionary
- **View domain** - Browse existing documentation

## Skills

### `domain-knowledge`

Knowledge about domain modeling:
- Entity documentation with attributes, relationships, lifecycle
- Process documentation with actors, steps, outcomes
- Glossary for ubiquitous language
- Mermaid diagrams (ERD, flowcharts, state diagrams)

## Output

```
domains/
└── [domain-name]/
    ├── entities/
    ├── processes/
    └── glossary/
```

## Key Principle

**No assumptions** - Always ask questions, never invent domain details.

## Installation

```
/plugin install pm-domain-knowledge@storm-claude-marketplace
```
