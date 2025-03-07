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

## Requirements

- Docker and Docker Compose installed on your system
- An Anthropic account with API credits ([check your billing page](https://console.anthropic.com/settings/billing))
- Optional MCP tool usages (such as Tavily API key for web search)

## Quick Start

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

4. **Run Claude Coder**
   ```bash
   # Run from within your project directory
   cd /path/to/your/project
   claude_coder
   
   # Or specify a project directory directly
   claude_coder /path/to/your/project
   ```

5. **First-time setup**: Claude will guide you through authentication with your Anthropic account. You will need an Anthropic account with API credits to use Claude Coder. Check your [billing management](https://console.anthropic.com/settings/billing) page to confirm you have available credits before using.

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
   
   **Bypass Permissions Mode Warning**:
   
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
   
   Select "Yes, I accept" to proceed. This warning appears because the Docker container runs with the `--dangerously-skip-permissions` flag as mentioned in the [Permission Handling](#permission-handling) section.

## MCP Tools and Capabilities

### Web Search with Tavily

Add Tavily search to Claude Code:

1. [Get a Tavily API key](https://docs.tavily.com/welcome)
   
   Tavily provides an AI-powered search API that enhances Claude's capabilities with real-time web information. The welcome page guides you through obtaining your free API key, which includes 1,000 free API credits monthly for searching and extracting web content.

2. Add the MCP server:
   ```bash
   claude_coder mcp add tavily-mcp -e TAVILY_API_KEY=tvly-xxxxx -- npx -y tavily-mcp@0.1.2
   ```

**Why Web Search is Essential During Development:**

Web search capability dramatically improves Claude's effectiveness during development by providing:

- **Access to up-to-date documentation** - Claude can find and reference current documentation for libraries, frameworks, and APIs
- **Solutions for error messages** - Claude can search for specific error messages you encounter to find solutions
- **Latest best practices** - Get information on current coding standards and recommended approaches
- **Library and package awareness** - Find and compare current libraries, packages, and dependencies
- **API changes and deprecations** - Stay informed about recent changes to APIs you're working with
- **Real-time knowledge** - Claude's built-in knowledge has a cutoff date, but web search provides current information
- **Enhanced problem-solving** - Combine Claude's reasoning with the collective knowledge of the developer community

Without web search, Claude relies solely on its training data, which may not include the most current information about rapidly evolving technologies, frameworks, and libraries.

### Adding More MCP Servers (Tools)

You can extend Claude Coder's capabilities by adding additional MCP servers. The [MCP Examples page](https://modelcontextprotocol.io/examples) provides a directory of available MCP tools and implementation examples, including APIs for web browsing, data visualization, image generation, and more. Each tool enhances Claude's abilities in specific domains, making it more versatile for your development workflow.

## Technical Details

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

> ⚠️ **IMPORTANT SECURITY INFORMATION** ⚠️
> 
> This Docker implementation runs Claude Code with the `--dangerously-skip-permissions` flag enabled by default:
> 
> ```
> CMD ["claude", "--dangerously-skip-permissions", "--verbose"]
> ```
> 
> This flag bypasses Claude Code's permission prompt system - Claude will be able to read and modify files without asking for permission each time.

<table>
<tr>
<th>Benefits</th>
<th>Security Considerations</th>
</tr>
<tr>
<td>

- **No Permission Prompts**: Eliminates interruptions when accessing files
- **Improved Workflow**: Makes Claude significantly more useful and efficient
- **Hassle-Free Automation**: Enables scripting and CI/CD integration
- **Seamless Experience**: Provides a smoother developer experience
- **Docker Isolation**: Security is already handled by container boundaries

</td>
<td>

- **Unrestricted Access**: Claude can read/write any file in mounted volumes
- **No Granular Control**: You can't selectively approve individual actions
- **Relies on Volume Config**: Security depends on proper Docker setup
- **Not for Sensitive Data**: Consider disabling for high-security projects
- **Explicitly Mount Dirs**: Only mount directories Claude should access

</td>
</tr>
</table>

**Why This Approach is Safe in Docker:**
- Container isolation already provides a security boundary
- You explicitly control which directories are mounted and exposed
- The Docker principle of "explicit permissions through volume mounts"
- Your host system remains protected by container isolation

**Outside of Docker**: This flag should be used with extreme caution as it removes Claude's permission safeguards.

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