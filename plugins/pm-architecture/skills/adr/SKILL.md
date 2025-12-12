---
name: adr
description: Architecture Decision Records (ADRs) for documenting technical decisions. Use when creating, updating, or reviewing architecture decisions. Triggers on discussions about technical choices, trade-offs, or "why did we choose X" questions.
---

# Architecture Decision Records

ADRs document significant technical decisions with their context and consequences.

## When to Create an ADR

Create an ADR when:
- Choosing between technologies (database, framework, language)
- Defining system boundaries or integration patterns
- Establishing conventions that affect multiple components
- Making decisions that are hard to reverse

Do NOT create an ADR for:
- Trivial choices with obvious answers
- Temporary decisions or experiments
- Implementation details within a single component

## ADR Format

```markdown
# [NUMBER]. [TITLE]

**Status**: [proposed | accepted | deprecated | superseded by [NUMBER]]

## Context

[What situation prompted this decision? What constraints exist?
Keep factual - describe the problem, not the solution.]

## Decision

[What is the decision? Be specific and actionable.
Start with "We will..." or "Use..."]

## Consequences

[What are the results? Include both positive and negative.
- Positive: benefits, improvements
- Negative: trade-offs, new constraints, risks]
```

## Status Lifecycle

- **proposed**: Under discussion, not yet decided
- **accepted**: Decision is final and in effect
- **deprecated**: No longer applies (context changed)
- **superseded by [N]**: Replaced by a newer decision

## Writing Tips

- Title: Use short noun phrases ("Use PostgreSQL", "Event-Driven Architecture")
- Context: Focus on forces and constraints, not history
- Decision: One clear statement, not multiple options
- Consequences: Be honest about trade-offs

## Naming Convention

Use sequential numbering: `001-use-postgres.md`, `002-event-driven.md`
