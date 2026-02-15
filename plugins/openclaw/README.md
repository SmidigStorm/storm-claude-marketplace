# OpenClaw Plugin

Claude Code plugin for installing, configuring, and using [OpenClaw](https://github.com/openclaw/openclaw) — a self-hosted personal AI assistant platform.

## What This Plugin Provides

A single skill (`openclaw`) that gives Claude comprehensive knowledge about OpenClaw:

- **Installation** — npm, Docker, from source, platform-specific guides (macOS, Linux, WSL2)
- **CLI reference** — All commands, subcommands, and flags
- **Channel setup** — WhatsApp, Telegram, Discord, Slack, Signal, iMessage, MS Teams, Google Chat, Matrix
- **Troubleshooting** — Common issues, diagnostics, security audit, session management

## Prerequisites

OpenClaw must be installed separately. This plugin provides guidance — it does not install OpenClaw itself.

- Node.js >= 22
- npm, pnpm, or bun

## Usage

Ask Claude anything about OpenClaw:

- "Help me install openclaw"
- "How do I add Telegram to openclaw?"
- "Openclaw gateway is not starting"
- "Set up openclaw channels"
- "Configure openclaw models"

## Structure

```
openclaw/
├── .claude-plugin/plugin.json
├── README.md
└── skills/openclaw/
    ├── SKILL.md
    └── references/
        ├── installation.md
        ├── cli-reference.md
        ├── channels.md
        └── troubleshooting.md
```
