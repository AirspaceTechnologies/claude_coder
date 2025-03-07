# Claude Coder Docker Environment

This repository provides an easy way to run Claude Coder (Anthropic's AI-powered CLI tool) in a Docker container. The containerized setup ensures a consistent environment with all necessary dependencies.

## Requirements

- Docker and Docker Compose installed on your system
- An Anthropic account with API credits ([check your billing page](https://console.anthropic.com/settings/billing))
- Optional MCP tool usages (such as Tavily API key for web search)

## Quick Start

1. **Clone and build**
   ```bash
   git clone https://github.com/AirspaceTechnologies/claude_coder.git
   cd claude_coder
   docker-compose build
   ```

2. **Install Claude Coder**
   ```bash
   # Create a symlink in a directory in your PATH (recommended)
   ln -s "$(pwd)/claude_coder" /usr/local/bin/claude_coder
   ```

3. **Run Claude Coder**
   ```bash
   # Run from within your project directory
   cd /path/to/your/project
   claude_coder
   
   # Or specify a project directory directly
   claude_coder /path/to/your/project
   ```

4. **First-time setup**: Claude will guide you through authentication with your Anthropic account. You will need an Anthropic account with API credits to use Claude Coder. Check your [billing management](https://console.anthropic.com/settings/billing) page to confirm you have available credits before using.

## MCP Tools and Capabilities

### Web Search with Tavily

Add Tavily search to Claude Code:

1. [Get a Tavily API key](https://docs.tavily.com/welcome)
   
   Tavily provides an AI-powered search API that enhances Claude's capabilities with real-time web information. The welcome page guides you through obtaining your free API key, which includes 1,000 free API credits monthly for searching and extracting web content.

2. Add the MCP server:
   ```bash
   claude_coder mcp add tavily-mcp -e TAVILY_API_KEY=tvly-xxxxx -- npx -y tavily-mcp@0.1.2
   ```

### Adding More MCP Servers (Tools)

You can extend Claude Coder's capabilities by adding additional MCP servers. The [MCP Examples page](https://modelcontextprotocol.io/examples) provides a directory of available MCP tools and implementation examples, including APIs for web browsing, data visualization, image generation, and more. Each tool enhances Claude's abilities in specific domains, making it more versatile for your development workflow.

## Technical Details

### Features
- Complete containerized environment with Docker
- Pre-installed development tools:
  - Version control: git, git-lfs, GitHub CLI
  - Editors: vim
  - Modern CLI tools: ripgrep, fd-find, bat, jq, make
  - Utilities: curl, wget, zip/unzip
- Multiple language runtimes (Node.js 18, Python 3, Ruby, Go)
- Non-root user setup with proper permissions
- Persistent configuration storage

### Container Configuration
- Uses Ubuntu 22.04 as the base image
- Mounts your local `.claude-docker` directory and `.claude-docker.json` file for persistence
- Mounts your project directory specified by `PROJECT_DIR`

### Authentication Isolation

This setup maintains separate authentication configurations between:

1. **Local Claude Coder installation** (uses `.claude` directory and `.claude.json`)
2. **Docker-based Claude Coder** (uses `.claude-docker` directory and `.claude-docker.json`)

This isolation ensures that:
- Your auth tokens and settings remain separate between environments
- You can use different Anthropic accounts in each environment if needed
- Container rebuilds won't affect your authentication state
- Local and containerized Claude can run side-by-side without conflicts

### Permission Handling

This Docker implementation runs Claude Code with the `--dangerously-skip-permissions` flag enabled by default:

```
CMD ["claude", "--dangerously-skip-permissions", "--verbose"]
```

**Why This Flag is Used:**
- Eliminates repetitive permission prompts when Claude Coder accesses files
- Improves workflow efficiency in containerized environments
- Security is maintained through Docker's isolation layer
- Permissions are already explicitly granted via volume mounts
- Provides a smoother, interruption-free experience

This approach is safe in containerized environments because:
- The Docker container already provides an isolation boundary
- Access is limited to directories explicitly mounted as volumes
- The user controls exactly which project directories are exposed
- Container environments have predetermined access patterns

Outside containerized environments, this flag should be used with caution as it removes Claude's permission safeguards.

### Customizing the Environment

The Dockerfile can be easily customized to meet your specific project requirements:

```bash
# Clone the repository and modify the Dockerfile
git clone https://github.com/AirspaceTechnologies/claude_coder.git
cd claude_coder
# Edit Dockerfile to add your project's dependencies
docker-compose build
```

**Key Requirements for Any Customization:**
- Node.js must be installed (the container uses Node.js 18)
- Claude Code must be installed globally: `npm install -g @anthropic-ai/claude-code`
- A non-root user should run Claude Code for proper permission handling

**Common Customizations:**
- Adding language-specific tools (e.g., Rust, Java, .NET)
- Installing additional development tools (linters, formatters)
- Configuring environment variables for your project
- Adding cloud provider CLI tools (AWS, Azure, GCP)

The containerized approach ensures that your customizations are isolated and reproducible across different environments and team members.

## Learn More

- [Claude Coder documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
  
  The official Claude Coder documentation provides comprehensive information about this terminal-based AI assistant that understands your codebase and helps you code faster through natural language commands. Learn about its features, installation process, and how to integrate it with your development workflow.

- [Claude Coder tutorials](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/tutorials)
  
  These practical tutorials show you how to get the most out of Claude Coder for specific tasks like adding tests, updating documentation, working with images, code review, and extending Claude's capabilities with the Model Context Protocol. Follow step-by-step guides to improve your productivity.

- [Model Context Protocol](https://modelcontextprotocol.io/introduction)
  
  The Model Context Protocol (MCP) is an open standard that enables developers to build secure, two-way connections between data sources and AI tools. This standardizes how applications provide context to AI models, allowing Claude Coder to access external tools and data sources to enhance its capabilities.

- [Tavily MCP documentation](https://docs.tavily.com/documentation/mcp)
  
  This documentation explains how to integrate Tavily's advanced search and data extraction capabilities with AI assistants like Claude via the Model Context Protocol. It includes step-by-step instructions for setting up the Tavily MCP server in various environments, including Cursor and Claude Desktop.

- [Anthropic billing management](https://console.anthropic.com/settings/billing)
  
  Manage your Anthropic account billing, view usage across API calls and Console chats, and access receipts and invoices through the Anthropic Console. This is where you'll handle payments and monitor your Claude Coder usage costs. It's important to regularly check your usage to avoid unexpected charges, as AI model costs can accumulate quickly depending on your usage patterns.

## Troubleshooting

If you encounter issues with the symlink method, you can try these alternative approaches:

### Alternative Run Methods

```bash
# Alternative 1: Use the wrapper script directly
./claude_coder /path/to/your/project

# Alternative 2: Use docker-compose directly
PROJECT_DIR=/path/to/your/project docker-compose run --rm claude-coder
```

### Access Container Shell

For deeper troubleshooting, you can get a bash shell in the container:

```bash
# Start a bash shell in the container with your project mounted
PROJECT_DIR=/path/to/your/project docker-compose run --rm --entrypoint bash claude-coder

# Or if you're already in your project directory
docker-compose run --rm --entrypoint bash -e PROJECT_DIR=$(pwd) claude-coder

# Quick shell access without mounting any project
docker-compose run --rm claude-coder bash
```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.