# OpenClaw Troubleshooting Reference

## Universal Diagnostic

Run this first for any issue:

```bash
openclaw doctor --deep --yes
```

Performs comprehensive health checks, applies quick fixes, and scans system services.

For shareable diagnostic output:

```bash
openclaw status --all --deep
```

## Common Issues

### Gateway Not Starting

**Symptoms:** Gateway fails to start, port already in use, service not running.

**Diagnose:**

```bash
openclaw gateway status
openclaw health
lsof -i :18789          # macOS/Linux: check port usage
ss -tlnp | grep 18789   # Linux alternative
```

**Fix:**

```bash
# Kill existing process on port
kill $(lsof -t -i :18789)

# Restart service
openclaw gateway restart

# Reinstall service if corrupted
openclaw gateway uninstall
openclaw gateway install
openclaw gateway start
```

### No DM Reply

**Symptoms:** Sending a DM to the bot but receiving no response.

**Diagnose:**

```bash
openclaw pairing list
openclaw channels status --probe
openclaw logs --follow
```

**Fix:**

```bash
# Approve pending pairing requests
openclaw pairing approve <channel> <code>

# Check channel connectivity
openclaw channels status --probe

# Verify agent routing
openclaw agents list --bindings
```

### Silent in Group Chats

**Symptoms:** Bot does not respond in group conversations.

**Cause:** Default activation mode is `mention` (only responds when @mentioned).

**Fix:**
- Mention the bot directly: `@botname your question`
- Or change to always mode: `/activation always` (in chat)
- Or via config: `openclaw config set channels.<ch>.groups.<groupId>.activation always`

### Authentication Expired

**Symptoms:** API calls failing, model errors, "unauthorized" in logs.

**Fix:**

```bash
# Re-authenticate with provider
openclaw models auth setup-token --provider anthropic

# Check auth status
openclaw models status --probe

# Verify model is set
openclaw models status
```

### Channel Disconnected

**Symptoms:** Channel shows as disconnected, messages not delivered.

**Diagnose:**

```bash
openclaw channels status --probe
openclaw channels logs --channel <id>
```

**Fix:**

```bash
# Reconnect channel
openclaw channels logout --channel <id>
openclaw channels login           # WhatsApp
openclaw channels add --channel <type> --token <new-token>  # Token-based

# Remove and re-add
openclaw channels remove --channel <id>
openclaw channels add --channel <type> --token <token>
```

### Memory Not Working

**Symptoms:** Agent doesn't recall past conversations, memory search returns nothing.

**Fix:**

```bash
# Check memory status
openclaw memory status

# Reindex all memory files
openclaw memory index --all

# Test search
openclaw memory search "test query"
```

**Note:** Memory backend auto-selects from local GGUF > OpenAI > Gemini > Voyage. Ensure at least one provider is configured.

### Context Window Full

**Symptoms:** Agent responses degrade, mentions context limits.

**Fix (in chat):**
- `/compact` — Summarize older context, free window space
- `/new` — Start fresh session
- `/reset` — Alias for `/new`

### Port Conflicts

**Symptoms:** Gateway cannot bind to default port.

**Fix:**

```bash
# Use different port
openclaw gateway --port 18790

# Or set in config
openclaw config set gateway.port 18790

# For dev profile (auto-shifted ports)
openclaw --dev gateway
```

### Node.js Version Too Old

**Symptoms:** Installation fails, runtime errors about unsupported syntax.

**Fix:**

```bash
# Check version
node --version

# Install Node 22+ via nvm
nvm install 22
nvm use 22

# Or via fnm
fnm install 22
fnm use 22
```

## Security Audit

Run periodic security audits:

```bash
openclaw security audit
openclaw security audit --fix    # Auto-fix issues
```

Common security findings:
- Open DM policy (allows anyone to message)
- Weak or missing gateway password
- Overly permissive sandbox settings
- Exposed ports without authentication

## Session Management

### Session Scoping

Control context isolation between conversations:

| Setting | Behavior |
|---|---|
| `main` | Single session for all DMs |
| `per-peer` | Isolated per contact |
| `per-channel-peer` | Isolated per contact per channel |
| `per-account-channel-peer` | Most isolated |

```bash
openclaw config set session.dmScope per-channel-peer
```

**Important:** Use `per-channel-peer` for multi-user inboxes to prevent context leakage.

### Session Reset

| Mode | Behavior |
|---|---|
| `daily` | Reset at 4am local time |
| `idle` | Reset after idle timeout |

```bash
openclaw config set session.reset.mode daily
openclaw config set session.reset.idleMinutes 60
```

### Clear Sessions

```bash
openclaw reset --scope sessions
```

## Advanced Configuration

### Sandbox Mode

Control tool execution sandboxing:

| Mode | Behavior |
|---|---|
| `off` | No sandboxing, tools run on host |
| `non-main` | Sandbox only non-main sessions (default) |
| `all` | Every session sandboxed |

```bash
openclaw config set sandbox.mode non-main
```

### Heartbeat Configuration

```bash
openclaw config set heartbeat.every 30m
openclaw config set heartbeat.target last
openclaw system heartbeat enable
```

### Failover Chain

Configure model failover with escalating cooldowns (1min > 5min > 1hr):

```bash
openclaw models fallbacks add openai/gpt-4o
openclaw models fallbacks add anthropic/claude-sonnet-4-5-20250929  # Use latest model ID
```

### Logging

```bash
# Tail logs
openclaw logs --follow

# JSON format for parsing
openclaw logs --json

# Limit output
openclaw logs --limit 200

# Channel-specific
openclaw channels logs --channel whatsapp
```

Log file location: `/tmp/openclaw/openclaw-YYYY-MM-DD.log`

### OpenTelemetry

Enable OTEL export for observability:

```bash
openclaw config set diagnostics.otel.enabled true
```

## Reset and Recovery

### Soft Reset

```bash
openclaw reset --scope sessions    # Clear sessions only
```

### Full Reset

```bash
openclaw reset                     # Clear all local config/state
```

### Complete Uninstall

```bash
openclaw uninstall                 # Remove service and data
npm uninstall -g openclaw          # Remove package
rm -rf ~/.openclaw                 # Remove all data (destructive)
```

## Getting Help

```bash
openclaw docs "search query"       # Search live documentation
openclaw --help                    # CLI help
openclaw <command> --help          # Command-specific help
```

GitHub Issues: https://github.com/openclaw/openclaw/issues
