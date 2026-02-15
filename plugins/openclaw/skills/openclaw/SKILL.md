---
name: openclaw
description: >-
  This skill should be used when the user asks to "install openclaw",
  "set up openclaw", "configure openclaw channels", "openclaw gateway",
  "openclaw troubleshooting", "add whatsapp to openclaw",
  "add telegram to openclaw", "openclaw agent", "openclaw models",
  "openclaw cron", "openclaw memory", "openclaw skills",
  "openclaw security", "openclaw browser", "openclaw sessions",
  "openclaw workspace", "openclaw docker", "openclaw not working",
  "debug openclaw", "connect discord to openclaw",
  "openclaw setup guide", or mentions openclaw setup,
  configuration, troubleshooting, or daily usage.
---

# OpenClaw - Self-Hosted Personal AI Assistant

OpenClaw is a self-hosted, single-user AI assistant platform that connects to messaging channels (WhatsApp, Telegram, Discord, Slack, Signal, iMessage, MS Teams, Google Chat, Matrix, Zalo, WebChat) and runs entirely on the user's own hardware.

## Architecture Overview

- **Gateway** — Central WebSocket hub at `ws://127.0.0.1:18789`. Coordinates channels, agents, tools, and events. Runs as a launchd/systemd service.
- **Channels** — Messaging platform integrations (WhatsApp, Telegram, Discord, etc.).
- **Agents** — Isolated workspaces with independent sessions, models, and routing.
- **Workspace** — `~/.openclaw/workspace/` containing prompt files (AGENTS.md, SOUL.md, USER.md, IDENTITY.md, MEMORY.md, TOOLS.md) and skills.
- **Config** — `~/.openclaw/openclaw.json` (JSON5 format).

## Installation

**Prerequisites:** Node >= 22, 2GB+ RAM, 500MB free disk.

**Quick install:**

```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon
```

The onboarding wizard guides through gateway setup, model authentication, workspace creation, and optional channel linking.

**Onboard flags:**
- `--install-daemon` — Install as system service (launchd/systemd)
- `--mode local|remote` — Local gateway or connect to remote
- `--flow quickstart` — Minimal setup
- `--skip-channels` — Skip channel linking

**From source:**

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw && pnpm install && pnpm ui:build && pnpm build
pnpm openclaw onboard --install-daemon
```

**Verify installation:**

```bash
openclaw doctor
openclaw status --all --deep
```

For platform-specific details (macOS permissions, Linux systemd, Windows WSL2, Docker), consult `references/installation.md`.

## Essential CLI Commands

| Command | Purpose |
|---|---|
| `openclaw onboard --install-daemon` | First-time setup with daemon |
| `openclaw gateway start\|stop\|restart` | Manage gateway service |
| `openclaw doctor --deep --yes` | Health check with auto-fix |
| `openclaw channels login` | WhatsApp QR pairing |
| `openclaw channels add --channel <ch> --token <t>` | Add Telegram/Discord/Slack |
| `openclaw channels status --probe` | Check channel connectivity |
| `openclaw models list\|set\|status` | Model management |
| `openclaw models auth setup-token` | Anthropic OAuth setup |
| `openclaw agent --message "text"` | Single agent turn |
| `openclaw config get\|set\|unset` | Manage configuration |
| `openclaw memory index\|search` | Memory vector search |
| `openclaw cron list\|add\|run` | Scheduled jobs |
| `openclaw security audit --fix` | Security foot-gun detection |
| `openclaw update --channel stable\|beta\|dev` | Update CLI |
| `openclaw tui` | Terminal UI |
| `openclaw dashboard` | Open web control UI |

For the full CLI reference, consult `references/cli-reference.md`.

## Channel Setup

Each channel requires a specific setup flow:

| Channel | Setup |
|---|---|
| WhatsApp | `openclaw channels login` (QR scan) |
| Telegram | Create bot via @BotFather, then `channels add --channel telegram --token $TOKEN` |
| Discord | Create bot in Discord Developer Portal, then `channels add --channel discord --token $TOKEN` |
| Slack | Create Slack app with bot token, then `channels add --channel slack` |
| Signal | `channels add --channel signal` (linked device) |
| iMessage | macOS only, native bridge integration |
| MS Teams | Bot registration required, then `channels add --channel msteams` |
| Google Chat | Service account required, then `channels add --channel googlechat` |

Diagnose channel issues:

```bash
openclaw channels status --probe
openclaw channels logs --channel <id>
```

For detailed per-channel setup, consult `references/channels.md`.

## Workspace Files

The workspace is the agent's context — prompt files injected at session start. Customize agent behavior by editing these files. Located at `~/.openclaw/workspace/`:

| File | Purpose |
|---|---|
| `AGENTS.md` | Operating instructions for the agent |
| `SOUL.md` | Persona, tone, and boundaries |
| `USER.md` | User information and preferences |
| `IDENTITY.md` | Agent name, emoji, theme |
| `MEMORY.md` | Curated long-term memory |
| `TOOLS.md` | Local tool notes |
| `HEARTBEAT.md` | Heartbeat checklist items |
| `BOOT.md` | Startup checklist |
| `memory/YYYY-MM-DD.md` | Daily append-only logs |

## Key Paths

| Path | Purpose |
|---|---|
| `~/.openclaw/openclaw.json` | Main configuration |
| `~/.openclaw/workspace/` | Default agent workspace |
| `~/.openclaw/agents/<id>/` | Per-agent state |
| `~/.openclaw/credentials/` | OAuth and API keys |

## Chat Commands (In-Session)

These slash commands are available inside any messaging channel connected to OpenClaw. Send them as regular messages.

| Command | Action |
|---|---|
| `/status` | Session health |
| `/new` or `/reset` | Clear context |
| `/model <model>` | Switch model |
| `/compact` | Summarize and free context |
| `/think` or `/verbose` | Toggle reasoning/verbose |
| `/stop` | Abort current run |
| `/send on\|off` | Override message delivery |

## Recommended Model Setup

Anthropic Pro/Max is strongly recommended for long-context strength and prompt-injection resistance. As of early 2026, the recommended model is Opus 4.6 — update the model ID below to the latest flagship when newer versions are available.

```bash
openclaw models auth setup-token --provider anthropic
openclaw models set anthropic/claude-opus-4-6
openclaw models status --probe    # Verify authentication
```

## Troubleshooting Quick Reference

| Problem | Fix |
|---|---|
| No DM reply | `openclaw pairing list` then approve pending |
| Silent in group | Check `mentionPatterns` config |
| Auth expired | `openclaw models auth setup-token --provider anthropic` |
| Gateway down | `openclaw doctor --deep --yes` |
| Memory not indexing | `openclaw memory index --all` |
| Context full | `/compact` or `/new` |
| Channel disconnected | `openclaw channels status --probe` |
| Port conflict | `lsof -i :18789` or `ss -tlnp \| grep 18789` |

For comprehensive troubleshooting, consult `references/troubleshooting.md`.

## Additional Resources

### Reference Files

- **`references/installation.md`** — Platform-specific installation (macOS, Linux, WSL2, Docker, from source)
- **`references/cli-reference.md`** — Complete CLI command reference with all subcommands and flags
- **`references/channels.md`** — Detailed per-channel setup procedures and configuration
- **`references/troubleshooting.md`** — Extended troubleshooting, security, session management, and advanced configuration
