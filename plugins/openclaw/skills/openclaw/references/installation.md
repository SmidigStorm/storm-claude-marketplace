# OpenClaw Installation Reference

## Prerequisites

- **Node.js** >= 22 (verify with `node --version`)
- **RAM**: 2GB minimum, 4GB+ recommended
- **Disk**: 500MB free space
- **Package Manager**: npm, pnpm, or bun

## Quick Install (All Platforms)

```bash
# npm
npm install -g openclaw@latest

# pnpm (recommended)
pnpm add -g openclaw@latest

# bun
bun add -g openclaw@latest
```

Then run the onboarding wizard:

```bash
openclaw onboard --install-daemon
```

## macOS

The onboarding wizard handles everything including launchd service installation.

**Post-install permissions:** Grant microphone and screen recording permissions in System Settings > Privacy & Security if using Voice Wake or Talk Mode.

**Companion app:** Optional macOS menu bar app provides Voice Wake, WebChat, and SSH remote access. Install separately from the OpenClaw website.

## Linux

The onboarding wizard configures a systemd user service automatically.

**Manual systemd setup (if needed):**

```bash
mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/openclaw.service << 'EOF'
[Unit]
Description=OpenClaw Gateway
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=%h/.local/bin/openclaw gateway --port 18789
Restart=on-failure
RestartSec=5
Environment=NODE_ENV=production

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable openclaw
systemctl --user start openclaw
```

**Verify:**

```bash
systemctl --user status openclaw
journalctl --user -u openclaw -f
```

## Windows (WSL2)

OpenClaw requires WSL2. Native Windows is not supported.

1. Enable WSL2: `wsl --install` (PowerShell as admin)
2. Install Ubuntu from Microsoft Store
3. Inside WSL2 terminal, install Node 22+ (use nvm or fnm)
4. Follow the Linux installation steps above
5. The gateway runs inside WSL2 and is accessible from Windows at `127.0.0.1:18789`

## Docker

Run OpenClaw in an isolated container, useful for servers and VPS deployments.

```bash
docker run -d \
  --name openclaw \
  -p 18789:18789 \
  -v openclaw-data:/root/.openclaw \
  node:22-slim \
  sh -c "npm install -g openclaw@latest && openclaw gateway --port 18789 --bind 0.0.0.0"
```

Then exec into the container to run onboarding:

```bash
docker exec -it openclaw openclaw onboard
```

**Docker Compose example:**

```yaml
services:
  openclaw:
    image: node:22-slim
    container_name: openclaw
    ports:
      - "18789:18789"
    volumes:
      - openclaw-data:/root/.openclaw
    command: >
      sh -c "npm install -g openclaw@latest &&
             openclaw gateway --port 18789 --bind 0.0.0.0"
    restart: unless-stopped

volumes:
  openclaw-data:
```

## Building from Source

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
pnpm install
pnpm ui:build
pnpm build
pnpm openclaw onboard --install-daemon
```

For development with hot reload:

```bash
pnpm gateway:watch
```

## Post-Installation Verification

```bash
# System health check
openclaw doctor

# Deep scan with auto-fix
openclaw doctor --deep --yes

# Full status
openclaw status --all --deep

# Test agent
openclaw agent --message "Hello, are you working?" --thinking high

# Check version
openclaw --version
```

## Updating

```bash
# Update to latest stable
openclaw update

# Switch release channels
openclaw update --channel stable    # Tagged releases
openclaw update --channel beta      # Prerelease versions
openclaw update --channel dev       # Main branch HEAD

# Check update status
openclaw update status
```

## Uninstalling

```bash
# Remove gateway service and data
openclaw uninstall

# Remove global package
npm uninstall -g openclaw
```

## Remote Access with Tailscale

For accessing the gateway remotely without exposing ports:

```bash
# Serve gateway over Tailscale
tailscale serve --bg http://127.0.0.1:18789

# Or use Tailscale Funnel for public access
tailscale funnel --bg http://127.0.0.1:18789
```

Auth modes: Tailscale identity headers or shared password via `openclaw config set gateway.password <pw>`.

## Isolation Profiles

Run multiple OpenClaw instances with isolated state:

```bash
# Dev profile (state in ~/.openclaw-dev, shifted ports)
openclaw --dev onboard --install-daemon

# Named profile (state in ~/.openclaw-<name>)
openclaw --profile work onboard --install-daemon
openclaw --profile personal onboard --install-daemon
```
