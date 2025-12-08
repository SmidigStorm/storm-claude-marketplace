# Contributing to Storm Claude Marketplace

Thank you for your interest in contributing plugins to this marketplace!

## Plugin Types

Claude Code plugins can include:

- **Commands** - Custom slash commands (e.g., `/audit`, `/deploy`)
- **Agents** - Specialized AI agents with domain expertise
- **Skills** - Auto-triggered capabilities based on context
- **Hooks** - Lifecycle event handlers
- **MCP Servers** - External tool integrations

## Creating a Plugin

### 1. Set Up Plugin Structure

```bash
mkdir -p plugins/your-plugin/.claude-plugin
mkdir -p plugins/your-plugin/commands   # if using commands
mkdir -p plugins/your-plugin/agents     # if using agents
mkdir -p plugins/your-plugin/skills     # if using skills
```

### 2. Create plugin.json

Create `plugins/your-plugin/.claude-plugin/plugin.json`:

```json
{
  "name": "your-plugin",
  "version": "1.0.0",
  "description": "Brief description of what your plugin does",
  "author": {
    "name": "Your Name",
    "email": "you@example.com",
    "url": "https://github.com/yourusername"
  },
  "repository": "https://github.com/yourusername/your-plugin",
  "license": "MIT",
  "keywords": ["relevant", "keywords"],
  "commands": ["./commands/"],
  "agents": "./agents/",
  "hooks": "./hooks.json",
  "mcpServers": "./mcp-servers.json"
}
```

Only include the component fields (`commands`, `agents`, `hooks`, `mcpServers`) that your plugin uses.

### 3. Create Commands (Optional)

Commands are markdown files with YAML frontmatter:

`plugins/your-plugin/commands/my-command.md`:

```markdown
---
description: Brief description shown in /help
---

# My Command

Detailed instructions for Claude when this command is invoked.

## What This Command Does

- Step 1
- Step 2
- Step 3

## Guidelines

Be specific about what Claude should do when this command runs.
```

### 4. Create Agents (Optional)

Agents are markdown files defining specialized assistants:

`plugins/your-plugin/agents/expert.md`:

```markdown
---
name: domain-expert
description: An expert in specific domain
---

# Domain Expert Agent

You are an expert in [domain]. When activated, you should:

1. Focus on [specific tasks]
2. Apply [methodologies]
3. Provide [type of output]

## Expertise Areas

- Area 1
- Area 2
```

### 5. Create Skills (Optional)

Skills auto-trigger based on context:

`plugins/your-plugin/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: When and why this skill activates
allowed-tools: Read, Write, Bash
---

# My Skill

This skill activates when [trigger conditions].

## Activation Triggers

- When user mentions [keywords]
- When working with [file types]
- When [context conditions]

## Behavior

Describe what Claude should do when this skill activates.
```

### 6. Create Hooks (Optional)

`plugins/your-plugin/hooks.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'About to write file'"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Tool completed'"
          }
        ]
      }
    ]
  }
}
```

### 7. Create MCP Servers (Optional)

`plugins/your-plugin/mcp-servers.json`:

```json
{
  "my-server": {
    "command": "${CLAUDE_PLUGIN_ROOT}/server.js",
    "args": ["--port", "3000"],
    "env": {
      "API_KEY": "${MY_API_KEY}"
    }
  }
}
```

### 8. Add README

Create `plugins/your-plugin/README.md`:

```markdown
# Your Plugin Name

Brief description.

## Installation

\`\`\`bash
/plugin install your-plugin@storm-claude-marketplace
\`\`\`

## Features

- Feature 1
- Feature 2

## Commands

- `/command-name` - What it does

## Usage Examples

Show example usage scenarios.

## License

MIT
```

## Submitting Your Plugin

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR-USERNAME/storm-claude-marketplace.git
cd storm-claude-marketplace
```

### 2. Create Your Plugin

Follow the structure above to create your plugin in the `plugins/` directory.

### 3. Register in Marketplace

Add your plugin to `.claude-plugin/marketplace.json`:

```json
{
  "plugins": [
    {
      "name": "your-plugin",
      "source": "./plugins/your-plugin",
      "description": "Brief description",
      "version": "1.0.0"
    }
  ]
}
```

### 4. Test Locally

```bash
/plugin marketplace add ./path/to/storm-claude-marketplace
/plugin install your-plugin@storm-claude-marketplace
```

### 5. Submit Pull Request

- Ensure your plugin follows the structure guidelines
- Include a clear README with usage examples
- Use semantic versioning
- Choose an appropriate license (MIT or Apache-2.0 recommended)

## Guidelines

### Naming

- Use kebab-case for plugin names: `my-awesome-plugin`
- Be descriptive but concise
- Avoid generic names like `utils` or `tools`

### Quality

- Test your plugin thoroughly before submitting
- Provide clear documentation
- Include usage examples
- Handle errors gracefully

### Security

- Never include secrets or API keys
- Use environment variables for sensitive configuration
- Document required environment variables

## Questions?

Open an issue if you have questions or need help with your plugin.
