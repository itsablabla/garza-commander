# GARZA Commander

Cloud-hosted Desktop Commander accessible via SSE endpoint.

## Architecture

```
Claude Desktop → SSE → GARZA Commander (Fly.io) → Desktop Commander Tools
                                 ↓
                        SSH to garzahive, Fly deploys, MCP calls
```

## What It Does

- Runs Desktop Commander in the cloud on Fly.io
- Exposes SSE endpoint for remote access
- Full network access (no local container isolation)
- Can SSH to garzahive directly
- Can deploy to Fly.io itself
- Can call all MCP servers

## Deployment

```bash
# Deploy to Fly.io
fly deploy

# Check status
fly status

# View logs
fly logs
```

## Connection

Add to Claude Desktop config (`~/Library/Application Support/Claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "garza-commander": {
      "transport": "sse",
      "url": "https://garza-commander.fly.dev/sse"
    }
  }
}
```

## SSH Setup

To enable SSH to garzahive from GARZA Commander:

1. Add SSH keys as Fly secrets:
```bash
fly secrets set SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)"
```

2. Configure SSH hosts in environment

## Integration with Last Rock MCP

GARZA Commander can deploy and manage lastrock-mcp:

```bash
# From within GARZA Commander
ssh root@garzahive.com
cd /root/lastrock-mcp
flyctl deploy
```

## Built With

- [mcp-proxy](https://github.com/sparfenyuk/mcp-proxy) - Bridges stdio to SSE
- [Desktop Commander](https://github.com/wonderwhy-er/DesktopCommanderMCP) - MCP server for terminal/filesystem
- [Fly.io](https://fly.io) - Deployment platform
