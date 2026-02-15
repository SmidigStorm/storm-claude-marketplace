# OpenClaw CLI Reference

Format: `openclaw [--dev] [--profile <name>] <command>`

## Global Flags

| Flag | Purpose |
|---|---|
| `--dev` | Isolate state under `~/.openclaw-dev` with shifted default ports |
| `--profile <name>` | Isolate state under `~/.openclaw-<name>` |
| `--no-color` | Disable ANSI styling (respects `NO_COLOR=1`) |
| `-V`, `--version` | Display version |
| `--json` / `--plain` | Machine-readable output |

## Setup & Onboarding

### `openclaw onboard`

Interactive setup wizard for gateway, workspace, channels, and skills.

| Flag | Purpose |
|---|---|
| `--install-daemon` | Install gateway as system service |
| `--mode local\|remote` | Local gateway or connect to remote |
| `--flow quickstart` | Minimal setup flow |
| `--skip-channels` | Skip channel linking step |

### `openclaw setup`

Non-interactive initialization of config and workspace.

### `openclaw configure`

Interactive configuration for models, channels, and skills.

### `openclaw doctor`

Health checks and quick fixes.

| Flag | Purpose |
|---|---|
| `--deep` | Comprehensive scan including extra installs |
| `--yes` | Auto-apply quick fixes |

### `openclaw config`

Non-interactive configuration helpers.

```bash
openclaw config get <key>           # Read config value
openclaw config set <key> <value>   # Set config value (JSON5 or raw)
openclaw config unset <key>         # Remove config key
```

## Gateway Management

### `openclaw gateway`

Run or manage the WebSocket Gateway.

```bash
openclaw gateway                     # Run in foreground
openclaw gateway --port 18789        # Specify port
openclaw gateway --bind 0.0.0.0      # Bind address
openclaw gateway --token <token>     # Set auth token
openclaw gateway --verbose           # Verbose logging
```

### Service management:

```bash
openclaw gateway start               # Start service
openclaw gateway stop                # Stop service
openclaw gateway restart             # Restart service
openclaw gateway status              # Check service status
openclaw gateway install             # Install as system service
openclaw gateway uninstall           # Remove system service
```

## Channel Management

### `openclaw channels`

```bash
openclaw channels list               # List configured channels
openclaw channels status             # Channel status overview
openclaw channels status --probe     # Live connectivity check
openclaw channels logs --channel <id> # Channel-specific logs
openclaw channels add --channel <type> --token <token>  # Add channel
openclaw channels remove --channel <id>  # Remove channel
openclaw channels login              # WhatsApp QR pairing
openclaw channels logout --channel <id>  # Disconnect channel
```

**Supported channel types:** `whatsapp`, `telegram`, `discord`, `slack`, `signal`, `imessage`, `msteams`, `googlechat`, `matrix`, `zalo`, `webchat`

## Model Management

### `openclaw models`

```bash
openclaw models list                 # List available models
openclaw models list --all           # Include all providers
openclaw models status               # Current model config
openclaw models status --probe       # Live probe all auth profiles
openclaw models set <model>          # Set primary model
openclaw models set-image <model>    # Set image model
openclaw models aliases              # View model aliases
openclaw models fallbacks add <model> # Add to failover chain
openclaw models fallbacks remove <model>
openclaw models scan                 # Scan for available models
openclaw models auth setup-token     # Anthropic OAuth flow
openclaw models auth setup-token --provider <name>  # Provider-specific auth
openclaw models auth order           # Set provider priority
```

## Agent Management

### `openclaw agent`

Execute a single agent turn.

```bash
openclaw agent --message "text"      # Run agent with message
openclaw agent --message "text" --thinking high  # With reasoning
openclaw agent --message "text" --session-id <id>  # Specific session
```

### `openclaw agents`

Multi-agent management.

```bash
openclaw agents list                 # List agents
openclaw agents list --bindings      # Show routing bindings
openclaw agents add <name>           # Create new agent
openclaw agents delete <name>        # Remove agent
```

## Memory & Sessions

### `openclaw memory`

```bash
openclaw memory status               # Memory system status
openclaw memory index                # Index memory files
openclaw memory index --all          # Full reindex
openclaw memory search "query"       # Semantic search
```

### `openclaw sessions`

```bash
openclaw sessions                    # List sessions
openclaw sessions --json             # JSON output
```

## Messaging

### `openclaw message`

```bash
openclaw message send --to <recipient> --message "text"
openclaw message poll                # Poll for messages
openclaw message react               # React to message
```

## Automation

### `openclaw cron`

```bash
openclaw cron list                   # List scheduled jobs
openclaw cron add                    # Create job (interactive)
openclaw cron edit <id>              # Modify job
openclaw cron rm <id>                # Delete job
openclaw cron enable <id>            # Enable job
openclaw cron disable <id>           # Disable job
openclaw cron run <id>               # Manual trigger
openclaw cron runs                   # View run history
```

### `openclaw webhooks`

Gmail Pub/Sub integration for webhook-based automation.

### `openclaw hooks`

```bash
openclaw hooks list                  # List all hooks
openclaw hooks enable <name>         # Activate hook
openclaw hooks disable <name>        # Deactivate hook
openclaw hooks info <name>           # Show hook metadata
openclaw hooks check                 # Verify eligibility
```

## Browser Automation

### `openclaw browser`

```bash
openclaw browser start               # Launch headless browser
openclaw browser stop                # Shutdown browser
openclaw browser tabs                # List open tabs
openclaw browser open <url>          # New tab
openclaw browser navigate <url>      # Navigate current tab
openclaw browser screenshot          # Capture view
openclaw browser click <selector>    # Click element
openclaw browser type <text>         # Type text
openclaw browser press <key>         # Press key
openclaw browser evaluate <js>       # Execute JavaScript
openclaw browser pdf                 # Export page as PDF
```

## Security & Pairing

### `openclaw security`

```bash
openclaw security audit              # Security audit
openclaw security audit --fix        # Auto-fix issues
```

### `openclaw pairing`

```bash
openclaw pairing list                # List pending requests
openclaw pairing approve <channel> <code>  # Approve pairing
```

## Plugins & Skills

### `openclaw plugins`

```bash
openclaw plugins list                # List plugins
openclaw plugins info <name>         # Plugin details
openclaw plugins install <name>      # Install plugin
openclaw plugins enable <name>       # Enable plugin
openclaw plugins disable <name>      # Disable plugin
```

### `openclaw skills`

```bash
openclaw skills                      # List available skills
```

## Node & Device Management

### `openclaw nodes`

```bash
openclaw nodes list                  # List paired nodes
openclaw nodes pending               # Pending approvals
openclaw nodes approve <id>          # Approve node
openclaw nodes run --node <name> "command"  # Run on node
openclaw nodes status                # Node status
```

### `openclaw devices`

```bash
openclaw devices list                # List devices
openclaw devices approve <id>        # Approve device
openclaw devices rotate <id>         # Rotate token
openclaw devices revoke <id>         # Revoke device
```

## Diagnostics & Logs

```bash
openclaw status                      # Session health
openclaw status --all --deep         # Full diagnosis
openclaw health                      # Gateway health via RPC
openclaw logs                        # Tail gateway logs
openclaw logs --follow               # Follow logs
openclaw logs --json                 # JSON format
openclaw logs --limit 200            # Limit output
```

## System Commands

```bash
openclaw system event --text "msg"   # Queue system event
openclaw system heartbeat enable|disable|last  # Heartbeat management
openclaw reset                       # Clear local config/state
openclaw reset --scope sessions      # Clear sessions only
openclaw uninstall                   # Remove service and data
openclaw update                      # Update CLI
openclaw update --channel stable|beta|dev  # Switch channel
openclaw update status               # Check update status
```

## Utilities

```bash
openclaw tui                         # Terminal UI
openclaw tui --url <url> --token <t> # Remote TUI
openclaw dashboard                   # Open web control UI
openclaw dns setup                   # Wide-area discovery
openclaw docs <query>                # Search documentation
openclaw acp                         # IDE bridge
```

## Common RPC Options

For commands that communicate with the gateway:

| Flag | Purpose |
|---|---|
| `--url <url>` | Gateway URL |
| `--token <token>` | Auth token |
| `--password <pw>` | Gateway password |
| `--timeout <ms>` | Request timeout |
| `--expect-final` | Wait for final response |
