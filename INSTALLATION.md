# Installation Guide

## Requirements

- Docker and Docker Compose installed on your system
- An Anthropic account with API credits ([check your billing page](https://console.anthropic.com/settings/billing))
- Optional MCP tool usages (such as Tavily API key for web search)

## Installation Steps

1. **Clone and build**
   ```bash
   git clone git@github.com:AirspaceTechnologies/claude_coder.git
   cd claude_coder
   docker-compose build
   ```

2. **Prepare claude config file for Docker volume mounts**
   ```bash
   # Create the claude json file locally to properly mount in Docker
   echo '{}' > ~/.claude-docker.json
   ```

3. **Install Claude Coder**
   ```bash
   # Create a symlink in a directory in your PATH (recommended)
   sudo ln -s "$(pwd)/claude_coder" /usr/local/bin/claude_coder
   ```

## First-time Setup

Claude will guide you through authentication with your Anthropic account. You will need an Anthropic account with API credits to use Claude Coder. Check your [billing management](https://console.anthropic.com/settings/billing) page to confirm you have available credits before using.

**Authentication in Docker container**:
```
╭────────────────────────────────────────────╮
│ ✻ Welcome to Claude Code research preview! │
╰────────────────────────────────────────────╯

 ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
██║     ██║     ███████║██║   ██║██║  ██║█████╗  
██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  
╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗
 ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
 ██████╗ ██████╗ ██████╗ ███████╗                
██╔════╝██╔═══██╗██╔══██╗██╔════╝                
██║     ██║   ██║██║  ██║█████╗                  
██║     ██║   ██║██║  ██║██╔══╝                  
╚██████╗╚██████╔╝██████╔╝███████╗                
 ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝

Browser didn't open? Use the url below to sign in:

https://console.anthropic.com/oauth/authorize?....

Paste code here if prompted >
```

When authenticating inside a Docker container, you'll need to:
- Copy the provided URL
- Open it in a browser on your host machine
- Complete the authentication process
- Copy the secret code back to the CLI prompt in the container

## Bypass Permissions Mode Warning

When running Claude Coder, you may see this warning:
```
╭───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│                                                                                                                                                           │
│ WARNING: Claude Code running in Bypass Permissions mode                                                                                                   │
│                                                                                                                                                           │
│ In Bypass Permissions mode, Claude Code will not ask for your approval before running potentially dangerous commands.                                     │
│ This mode should only be used in a sandboxed container/VM that has restricted internet access and can easily be restored if damaged.                      │
│                                                                                                                                                           │
│ By proceeding, you accept all responsibility for actions taken while running in Bypass Permissions mode.                                                  │
│                                                                                                                                                           │
│ https://docs.anthropic.com/s/claude-code-security                                                                                                         │
│                                                                                                                                                           │
│   No, exit                                                                                                                                                │
│ ❯ Yes, I accept                                                                                                                                           │
│                                                                                                                                                           │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
   Enter to confirm · Esc to exit
```

Select "Yes, I accept" to proceed. This warning appears because the Docker container runs with the `--dangerously-skip-permissions` flag for improved workflow. See the [TECHNICAL.md](TECHNICAL.md) file for more details on security implications.