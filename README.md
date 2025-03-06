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
- Anthropic API credentials

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/AirspaceTechnologies/claude_coder.git
   cd claude_coder
   ```

2. When running Claude Code for the first time, it will guide you through the authentication process:
   - Claude will prompt you to authenticate with your Anthropic account
   - Credentials will be stored automatically for future sessions

3. Build and start the container:
   ```
   docker-compose up -d
   ```

4. Attach to the running container:
   ```
   docker attach claude-code
   ```

5. Use Claude Code inside the container:
   ```
   claude --help
   ```

## Configuration

The Docker Compose file is configured to:
- Mount your local `.claude` directory for persistence of settings
- Mount your local `.claude.json` file for API credentials
- Mount a local project directory to work on

You can modify the `docker-compose.yml` file to change mounted volumes or working directory.

## License

[Add appropriate license information here]

## Contributing

[Add contribution guidelines if applicable]