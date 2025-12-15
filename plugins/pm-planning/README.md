# PM Planning

Create implementation plans from backlog items and execute them with confidence. This plugin uses specialized agents for thorough codebase exploration, architecture design, and code review.

## Commands

### `/plan [backlog item]`

Creates an implementation plan through a guided 6-phase process:

```mermaid
flowchart LR
    D[Discovery] --> R[Requirements]
    R --> E[Explore]
    E --> Q[Questions]
    Q --> A[Architecture]
    A --> Doc[Document]
```

**Example:**
```
/plan Add user authentication with OAuth
```

### `/execute [plan-name]`

Executes a plan from `docs/plans/` with built-in code review:

```mermaid
flowchart LR
    L[Load] --> C[Check]
    C --> I[Implement]
    I --> R[Review]
    R --> V[Verify]
    V --> Done[Complete]
```

**Example:**
```
/execute user-authentication
```

## How It Works

### Planning Phase

1. **Discovery** - Understand what needs to be built
2. **Requirements Mapping** - Link to existing requirements (SUB-CAP-NNN format)
3. **Codebase Exploration** - Launch `code-explorer` agents to understand patterns
4. **Clarifying Questions** - Resolve all ambiguities before designing
5. **Architecture Design** - Launch `code-architect` agents to propose approaches
6. **Document Plan** - Create plan file in `docs/plans/`

### Execution Phase

1. **Load Plan** - Read and summarize the plan
2. **Pre-Implementation Check** - Verify codebase matches assumptions
3. **Implementation** - Execute steps autonomously (stops on roadblocks)
4. **Quality Review** - Launch `code-reviewer` agents to catch issues
5. **Verification** - Check acceptance criteria
6. **Completion** - Update plan, offer to commit

## Agents

The plugin includes three specialized agents:

| Agent | Purpose | Used In |
|-------|---------|---------|
| `code-explorer` | Traces execution paths, maps architecture, identifies patterns | `/plan` Phase 3 |
| `code-architect` | Designs implementation approaches with trade-offs | `/plan` Phase 5 |
| `code-reviewer` | Reviews for bugs, quality, and conventions | `/execute` Phase 4 |

### Using Agents Manually

You can also invoke agents directly:

```
"Launch code-explorer to trace how the payment system works"
```

```
"Launch code-architect to design a caching layer"
```

```
"Launch code-reviewer to check my recent changes"
```

## Output

Plans are saved to `docs/plans/[name].md` with:

- Summary of what's being built
- Requirements being implemented (with IDs)
- Architecture approach chosen
- Codebase patterns to follow
- Step-by-step implementation guide
- Acceptance criteria
- Decisions made with rationale

## Example Workflow

```
# 1. Create a plan
/plan Add rate limiting to API endpoints

# Claude will:
# - Ask clarifying questions about requirements
# - Launch explorers to understand the codebase
# - Present architecture options
# - Create docs/plans/rate-limiting.md

# 2. Review the plan (it's just a markdown file)
cat docs/plans/rate-limiting.md

# 3. Execute when ready
/execute rate-limiting

# Claude will:
# - Implement each step
# - Run code review
# - Verify acceptance criteria
# - Offer to commit
```

## Tips

- **Be specific** in your initial request to reduce clarifying questions
- **Review the plan** before executing - it's a checkpoint
- **Trust the agents** - they explore thoroughly so you don't have to
- **Don't skip code review** - it catches real issues

## When to Use

**Use `/plan` for:**
- Features touching multiple files
- Work requiring architectural decisions
- Complex integrations
- Unclear requirements that need exploration

**Skip planning for:**
- Single-line fixes
- Well-defined simple tasks
- Urgent hotfixes
