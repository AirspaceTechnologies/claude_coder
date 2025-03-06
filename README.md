# Claude Code Docker Environment

This repository contains Docker configuration files for running Claude Code in a containerized development environment. Claude Code is Anthropic's CLI tool for interacting with Claude AI models.

## Features

- Ubuntu 22.04 base image
- Pre-installed development tools (git, vim, etc.)
- Multiple language runtimes (Node.js 18, Python 3, Ruby, Go)
- Non-root user setup with proper permissions
- Persistent configuration volumes
- Docker Compose for easy startup

## Prerequisites

- Docker
- Docker Compose
- Anthropic account login credentials

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/AirspaceTechnologies/claude_coder.git
   cd claude_coder
   ```

2. When running Claude Code for the first time, it will guide you through the authentication process:
   - Claude will prompt you to authenticate with your Anthropic account
   - Credentials will be stored automatically for future sessions

3. Run Claude Code in the container:
   ```
   docker-compose run --rm claude-code
   ```

## Configuration

The Docker Compose file is configured to:
- Mount your local `.claude` directory for persistence of settings
- Mount your local `.claude.json` file for API credentials
- Mount a local project directory to work on

### Using a Custom Project Directory

You can use the included wrapper script to easily run Claude Code with your current directory as the project:

```bash
# First, add the script to your PATH:
# Option 1: Create a symlink in a directory that's already in your PATH
ln -s /path/to/claude_code/claude-code /usr/local/bin/claude-code

# Option 2: Add the directory to your PATH in your shell profile (~/.bashrc, ~/.zshrc, etc.)
echo 'export PATH="/path/to/claude_code:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Now you can run from any directory to use that directory as the project
claude-code

# Or specify a different project directory as an argument
claude-code /path/to/your/project
```

Alternatively, you can still use docker-compose directly:

```bash
PROJECT_DIR=/path/to/your/project docker-compose run --rm claude-code
```

## License

[Add appropriate license information here]

## Contributing

[Add contribution guidelines if applicable]