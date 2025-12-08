# Storm Claude Marketplace

A curated collection of Claude Code plugins.

## Using This Marketplace

### Add the Marketplace

```bash
/plugin marketplace add storm/storm-claude-marketplace
```

Or using a git URL:

```bash
/plugin marketplace add https://github.com/storm/storm-claude-marketplace.git
```

### Browse and Install Plugins

After adding the marketplace, browse available plugins:

```bash
/plugin
```

Install a specific plugin:

```bash
/plugin install plugin-name@storm-claude-marketplace
```

## Available Plugins

| Plugin | Description |
|--------|-------------|
| [hello-world](./plugins/hello-world) | A simple example plugin demonstrating the plugin structure |

## Repository Structure

```
storm-claude-marketplace/
├── .claude-plugin/
│   └── marketplace.json    # Marketplace configuration
├── plugins/                # Individual plugins
│   └── plugin-name/
│       ├── .claude-plugin/
│       │   └── plugin.json # Plugin configuration
│       ├── commands/       # Slash commands (optional)
│       ├── agents/         # Custom agents (optional)
│       ├── skills/         # Agent skills (optional)
│       └── README.md
├── README.md
└── CONTRIBUTING.md
```

## Creating a Plugin

See [CONTRIBUTING.md](./CONTRIBUTING.md) for detailed instructions on creating and submitting plugins.

### Quick Start

1. Create a new directory under `plugins/`:

```bash
mkdir -p plugins/my-plugin/.claude-plugin
mkdir -p plugins/my-plugin/commands
```

2. Create `plugins/my-plugin/.claude-plugin/plugin.json`:

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "What your plugin does",
  "author": {
    "name": "Your Name"
  },
  "license": "MIT",
  "commands": ["./commands/"]
}
```

3. Create a command in `plugins/my-plugin/commands/my-command.md`:

```markdown
---
description: Brief description of the command
---

# My Command

Instructions for Claude when this command is invoked.
```

4. Add your plugin to `.claude-plugin/marketplace.json`

5. Submit a pull request!

## License

MIT
