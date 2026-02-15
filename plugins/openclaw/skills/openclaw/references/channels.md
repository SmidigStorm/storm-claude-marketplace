# OpenClaw Channel Setup Reference

## Channel Overview

OpenClaw supports connecting to multiple messaging platforms simultaneously. Each channel runs as a bridge between the platform and the OpenClaw Gateway.

## WhatsApp

**Setup:**

```bash
openclaw channels login
```

This opens a web-based QR pairing flow. Scan the QR code with WhatsApp on the phone.

**Notes:**
- Uses the WhatsApp Web protocol
- Session persists across gateway restarts
- Re-login required if WhatsApp Web session expires (typically 14 days of inactivity)
- Group messages require `mentionPatterns` configuration for the agent to respond

**Group activation:** Set `activation: "mention"` or `activation: "always"` per group. Default is mention-only (agent responds when @mentioned).

## Telegram

**Prerequisites:** Create a bot via [@BotFather](https://t.me/BotFather) and obtain the bot token.

**Setup:**

```bash
openclaw channels add --channel telegram --token $TELEGRAM_BOT_TOKEN
```

**Notes:**
- Bot must be added to groups manually
- Use `/setprivacy` with BotFather to control whether bot sees all messages or only commands/@mentions
- Supports inline keyboards and rich formatting

## Discord

**Prerequisites:**
1. Create application at [Discord Developer Portal](https://discord.com/developers/applications)
2. Create a bot under the application
3. Enable Message Content Intent under Bot settings
4. Generate bot token
5. Create invite URL with appropriate permissions (Send Messages, Read Message History, etc.)

**Setup:**

```bash
openclaw channels add --channel discord --token $DISCORD_BOT_TOKEN
```

**Notes:**
- Bot needs to be invited to servers via OAuth2 URL
- Guild-specific routing available via `guildId` agent bindings
- Supports threads, reactions, and embeds

## Slack

**Prerequisites:**
1. Create a Slack App at [api.slack.com/apps](https://api.slack.com/apps)
2. Add Bot Token Scopes: `chat:write`, `channels:history`, `channels:read`, `groups:history`, `groups:read`, `im:history`, `im:read`, `im:write`, `users:read`
3. Install app to workspace
4. Copy Bot User OAuth Token

**Setup:**

```bash
openclaw channels add --channel slack --token $SLACK_BOT_TOKEN
```

**Notes:**
- Team-specific routing available via `teamId` agent bindings
- Bot must be invited to channels with `/invite @botname`
- Supports threads and reactions

## Signal

**Setup:**

```bash
openclaw channels add --channel signal
```

Follow the prompts to link as a secondary device (similar to Signal Desktop linking).

**Notes:**
- Requires Signal account on a phone
- Uses Signal's linked device protocol
- End-to-end encrypted

## iMessage (macOS Only)

Requires macOS with a native iMessage bridge (BlueBubbles or similar).

**Notes:**
- Only available on macOS
- Requires a Mac that stays on and connected
- Uses the native Messages framework

## Microsoft Teams

**Prerequisites:**
1. Register a bot in the Azure Bot Framework
2. Configure messaging endpoint
3. Obtain App ID and password

**Setup:**

```bash
openclaw channels add --channel msteams --token $TEAMS_BOT_TOKEN
```

## Google Chat

**Prerequisites:**
1. Create a Google Cloud project
2. Enable Google Chat API
3. Create a service account with appropriate permissions
4. Download service account key JSON

**Setup:**

```bash
openclaw channels add --channel googlechat --credentials /path/to/service-account.json
```

## Matrix

**Prerequisites:** Matrix homeserver account with access token.

**Setup:**

```bash
openclaw channels add --channel matrix --token $MATRIX_ACCESS_TOKEN --server https://matrix.example.com
```

## WebChat

Built-in web-based chat interface, accessible via the Gateway dashboard.

```bash
openclaw dashboard
```

No additional setup required. Available at `http://127.0.0.1:18789/`.

## Multi-Agent Routing

Route different channels or accounts to isolated agents:

```bash
# Create agents
openclaw agents add work-agent
openclaw agents add personal-agent

# View bindings
openclaw agents list --bindings
```

**Routing precedence (highest to lowest):**
1. `peer` — Exact DM/group ID
2. `guildId` — Discord server
3. `teamId` — Slack workspace
4. `accountId` — Account-level
5. `channel` — Channel-wide fallback
6. Default agent — Final fallback

## Channel Diagnostics

```bash
# Check all channels
openclaw channels status --probe

# Channel-specific logs
openclaw channels logs --channel <id>

# List configured channels
openclaw channels list

# Remove a channel
openclaw channels remove --channel <id>

# Reconnect
openclaw channels logout --channel <id>
openclaw channels login  # or channels add
```

## DM Security (Pairing Mode)

By default, unknown senders must pair before messaging:

1. Unknown sender sends a message
2. They receive a pairing code
3. Approve via CLI:

```bash
openclaw pairing list
openclaw pairing approve <channel> <code>
```

To allow open DMs (not recommended):

```bash
openclaw config set channels.<channel>.dmPolicy open
```

The `openclaw security audit` command flags risky DM policies.

## Group Chat Configuration

Control how the agent responds in group chats:

- **mention** (default) — Only responds when @mentioned
- **always** — Responds to all messages in the group

Configure via slash command in chat: `/activation mention|always`

Or via config:

```bash
openclaw config set channels.<channel>.groups.<groupId>.activation always
```
