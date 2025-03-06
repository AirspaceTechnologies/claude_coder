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

3. **First-time setup**: Claude will guide you through authentication with your Anthropic account.

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

## Web Search Capabilities

Add Tavily search to Claude Code:

1. [Get a Tavily API key](https://docs.tavily.com/welcome)
2. Add the MCP server:
   ```bash
   claude mcp add tavily-mcp -e TAVILY_API_KEY=tvly-xxxxx -- npx -y tavily-mcp@0.1.2
   ```

## Technical Details

The Docker container:
- Uses Ubuntu 22.04 as the base image
- Mounts your local `.claude` directory and `.claude.json` file for persistence
- Mounts your project directory specified by `PROJECT_DIR`

## Learn More

- [Claude Code documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
- [Claude Code tutorials](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/tutorials)
- [Model Context Protocol](https://modelcontextprotocol.io/introduction)
- [Tavily MCP documentation](https://docs.tavily.com/documentation/mcp)
- [Anthropic billing management](https://console.anthropic.com/settings/billing)

## License

[Add appropriate license information here]

## Contributing

[Add contribution guidelines if applicable]