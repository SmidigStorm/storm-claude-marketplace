# MCP Essentials

Essential MCP servers for development, auto-loaded when the plugin is installed.

## Included Servers

| Server | Transport | Description |
|--------|-----------|-------------|
| **GitHub** | HTTP (remote) | Repository management, PRs, issues, branches |
| **Git** | stdio (uvx) | Read, search, and manipulate local Git repositories |
| **GitLab** | stdio (npx) | Merge requests, CI/CD, code review |
| **Context7** | stdio (npx) | Version-specific documentation from official sources |
| **Notion** | HTTP (remote) | Read/write pages, databases, documentation |

## Prerequisites

- **Node.js** (for npx-based servers: GitLab, Context7)
- **Python + uv** (for uvx-based server: Git) - install via `pip install uv` or see [uv docs](https://docs.astral.sh/uv/)

## Setup

### 1. Install the plugin

```bash
claude /plugins
# Install mcp-essentials from storm-claude-marketplace
```

### 2. Authenticate remote servers

GitHub and Notion use OAuth authentication. After installing, run `/mcp` in Claude Code and authenticate each:

```
> /mcp
# Select GitHub → Authenticate
# Select Notion → Authenticate
```

### 3. Configure environment variables (GitLab)

GitLab requires a personal access token. Set it in your environment:

```bash
export GITLAB_PERSONAL_ACCESS_TOKEN="your-token-here"
export GITLAB_API_URL="https://gitlab.com"  # or your self-hosted instance
```

### 4. Verify

Run `/mcp` in Claude Code to confirm all servers are connected.

## Server Details

### GitHub
- **Auth**: OAuth (automatic via `/mcp`)
- **Capabilities**: Repos, PRs, issues, branches, code search

### Git
- **Auth**: None (uses local git credentials)
- **Capabilities**: Log, diff, status, blame, branch operations on local repos

### GitLab
- **Auth**: Personal access token via `GITLAB_PERSONAL_ACCESS_TOKEN`
- **Capabilities**: Merge requests, CI/CD pipelines, issues, code review

### Context7
- **Auth**: Optional API key via `CONTEXT7_API_KEY`
- **Capabilities**: Fetch up-to-date documentation for any library/framework

### Notion
- **Auth**: OAuth (automatic via `/mcp`)
- **Capabilities**: Pages, databases, search, create/update content
