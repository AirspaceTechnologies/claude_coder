# Claude Coder

## My Typical experience developing with an LLM

**Developer:** "I'm getting this bug: `TypeNameError: name 'pc_load_letter' is not defined; Cannot read property 'pc' of undefined load_letter; NullPointerException: Attempt to invoke method on a null object;`! Can you help me out here?"

**AI:** "Let's start by checking if 'foo' exists before you use it. Try this code: `<if (pc) { loadLetter(); }>` and see if that resolves the issue."

**Developer:** "I tried that, but now I get 'ReferenceError: foo is not defined!'"

**AI:** "Looks like a syntax hiccup. Try this code: `<if (typeof loadLetter() !== 'pc') { executeTask(); }>`—double-check your punctuation and brackets."

*... After 36 more cycles of back-and-forth copy and paste ...*

**Developer:** "My goodness, that finally fixed it, that was rough!"

**AI:** "I am glad we could get this solved for you... What can I help you copy and paste next?"

**Developer:** "Uhhgggg!"

**Developer:** Thought - If we only had a system to automate all this tedious back-and-forth error-fixing...

Claude Coder in Docker: Navigate to your project directory and run `claude_coder`. Your current directory is safely mounted in a Docker container with Claude Coder ready to help you code faster.

## Quick Start

```bash
# Clone and build
git clone git@github.com:AirspaceTechnologies/claude_coder.git
cd claude_coder
docker-compose build

# Create config file for Docker volume mounts
echo '{}' > ~/.claude-docker.json

# Install via symlink (recommended)
sudo ln -s "$(pwd)/claude_coder" /usr/local/bin/claude_coder

# Run from your project directory
cd /path/to/your/project
claude_coder
```

## Documentation

- [Installation Guide](INSTALLATION.md) - Detailed setup instructions
- [Usage Guide](USAGE.md) - How to use Claude Coder effectively
- [MCP Tools](MCP-TOOLS.md) - Extending Claude with web search and other capabilities
- [Technical Details](TECHNICAL.md) - Authentication, permissions, and customization
- [Troubleshooting](TROUBLESHOOTING.md) - Solutions for common issues

## Key Features

- **Containerized Environment**: Safe, consistent development environment
- **Docker Integration**: Your project mounted securely in an isolated container
- **Efficient Workflow**: No permission prompts for a smoother experience
- **Development Tools**: Pre-installed language runtimes and dev utilities
- **Web Search**: Optional capability to access latest information (see [MCP Tools](MCP-TOOLS.md))

## Learn More

- [Claude Coder documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
- [Claude Coder tutorials](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/tutorials)
- [Model Context Protocol](https://modelcontextprotocol.io/introduction)
- [Anthropic billing management](https://console.anthropic.com/settings/billing)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.