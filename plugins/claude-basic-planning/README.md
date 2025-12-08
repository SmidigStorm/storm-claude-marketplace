# Claude Basic Planning

A structured workflow plugin for Claude Code that breaks work into three phases: Analyze, Plan, and Execute.

## Installation

```bash
/plugin install claude-basic-planning@storm-claude-marketplace
```

## Commands

### `/analyze`
Understand the user's needs and create a summary of what they want to achieve. Outputs a concise summary with goals, requirements, scope, and assumptions.

### `/plan`
Create an implementation plan after reading and understanding the codebase. Explores the repository first, then produces a structured plan with steps, affected files, and risks.

### `/execute`
Execute the implementation plan step by step. Tracks progress, verifies each step, and reports on completion.

## Workflow

1. Start with `/analyze` to clarify what needs to be done
2. Use `/plan` to create a detailed implementation plan
3. Run `/execute` to implement the plan

## License

MIT
