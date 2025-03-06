# Claude Code Docker Environment

This repository provides an easy way to run Claude Code (Anthropic's AI-powered CLI tool) in a Docker container. The containerized setup ensures a consistent environment with all necessary dependencies.

## Quick Start

1. **Clone and build**
   ```bash
   git clone https://github.com/AirspaceTechnologies/claude_coder.git
   cd claude_coder
   docker-compose build
   ```

2. **Run Claude Code**
   ```bash
   # Option 1: Use the wrapper script (recommended)
   ./claude-code /path/to/your/project
   
   # Option 2: Use docker-compose directly
   PROJECT_DIR=/path/to/your/project docker-compose run --rm claude-code
   ```

3. **First-time setup**: Claude will guide you through authentication with your Anthropic account. You will need an Anthropic account with API credits to use Claude Code. Check your [billing management](https://console.anthropic.com/settings/billing) page to confirm you have available credits before using.

## Installation (Optional)

Make Claude Code available from anywhere by adding it to your PATH:

```bash
# Create a symlink in a directory in your PATH
ln -s "$(pwd)/claude-code" /usr/local/bin/claude-code

# Now you can run from any directory
cd /path/to/your/project
claude-code
# Or specify a different project directory
claude-code /path/to/different/project
```

## Features

- Complete containerized environment with Docker
- Pre-installed development tools (git, vim, etc.) 
- Multiple language runtimes (Node.js 18, Python 3, Ruby, Go)
- Non-root user setup with proper permissions
- Persistent configuration storage

## Requirements

- Docker and Docker Compose installed on your system
- An Anthropic account with API credits ([check your billing page](https://console.anthropic.com/settings/billing))
- For web search: A Tavily API key (optional)

## Web Search Capabilities

Add Tavily search to Claude Code:

1. [Get a Tavily API key](https://docs.tavily.com/welcome)
   
   Tavily provides an AI-powered search API that enhances Claude's capabilities with real-time web information. The welcome page guides you through obtaining your free API key, which includes 1,000 free API credits monthly for searching and extracting web content.

2. Add the MCP server:
   ```bash
   claude mcp add tavily-mcp -e TAVILY_API_KEY=tvly-xxxxx -- npx -y tavily-mcp@0.1.2
   ```

## Technical Details

The Docker container:
- Uses Ubuntu 22.04 as the base image
- Mounts your local `.claude-docker` directory and `.claude-docker.json` file for persistence
- Mounts your project directory specified by `PROJECT_DIR`

### Authentication Isolation

This setup maintains separate authentication configurations between:

1. **Local Claude Code installation** (uses `.claude` directory and `.claude.json`)
2. **Docker-based Claude Code** (uses `.claude-docker` directory and `.claude-docker.json`)

This isolation ensures that:
- Your auth tokens and settings remain separate between environments
- You can use different Anthropic accounts in each environment if needed
- Container rebuilds won't affect your authentication state
- Local and containerized Claude can run side-by-side without conflicts

## Learn More

- [Claude Code documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
  
  The official Claude Code documentation provides comprehensive information about this terminal-based AI assistant that understands your codebase and helps you code faster through natural language commands. Learn about its features, installation process, and how to integrate it with your development workflow.

- [Claude Code tutorials](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/tutorials)
  
  These practical tutorials show you how to get the most out of Claude Code for specific tasks like adding tests, updating documentation, working with images, code review, and extending Claude's capabilities with the Model Context Protocol. Follow step-by-step guides to improve your productivity.

- [Model Context Protocol](https://modelcontextprotocol.io/introduction)
  
  The Model Context Protocol (MCP) is an open standard that enables developers to build secure, two-way connections between data sources and AI tools. This standardizes how applications provide context to AI models, allowing Claude Code to access external tools and data sources to enhance its capabilities.

- [Tavily MCP documentation](https://docs.tavily.com/documentation/mcp)
  
  This documentation explains how to integrate Tavily's advanced search and data extraction capabilities with AI assistants like Claude via the Model Context Protocol. It includes step-by-step instructions for setting up the Tavily MCP server in various environments, including Cursor and Claude Desktop.

- [Anthropic billing management](https://console.anthropic.com/settings/billing)
  
  Manage your Anthropic account billing, view usage across API calls and Console chats, and access receipts and invoices through the Anthropic Console. This is where you'll handle payments and monitor your Claude Code usage costs. It's important to regularly check your usage to avoid unexpected charges, as AI model costs can accumulate quickly depending on your usage patterns.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.