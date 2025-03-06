# CLAUDE.md - Agent Guidelines

## Commands (Do not run these commands directly)
- Run CLI tool: `./claude-code [project_dir]`
- Alternative: `PROJECT_DIR=/path/to/project docker-compose run --rm claude-code`
- Install via symlink: `ln -s $(pwd)/claude-code /usr/local/bin/claude-code`
- Debug mode: Add `--verbose` flag

## Environment
- Based on Ubuntu 22.04 Docker image
- Includes Node.js 18, Python 3, Ruby, and Go runtimes
- Stores credentials in local `.claude.json` file
- Persists settings in `.claude` directory

## Coding Style
- Follow Docker best practices for containerization
- Use relative paths for portability
- Add descriptive comments for complex configurations
- Use environment variables for customization
- Maintain detailed README documentation
- Keep shell scripts concise and robust
- Handle errors gracefully with appropriate exit codes