# MCP Tools and Capabilities

## Web Search with Tavily

Add Tavily search to Claude Code:

1. [Get a Tavily API key](https://docs.tavily.com/welcome)
   
   Tavily provides an AI-powered search API that enhances Claude's capabilities with real-time web information. The welcome page guides you through obtaining your free API key, which includes 1,000 free API credits monthly for searching and extracting web content.

2. Add the MCP server:
   ```bash
   cd /path/to/claude_coder
   docker-compose run --rm claude-coder claude-patched mcp add tavily-mcp -e TAVILY_API_KEY=tvly-xxxxx -- npx -y tavily-mcp@0.1.2
   ```

## Why Web Search is Essential During Development

Web search capability dramatically improves Claude's effectiveness during development by providing:

- **Access to up-to-date documentation** - Claude can find and reference current documentation for libraries, frameworks, and APIs
- **Solutions for error messages** - Claude can search for specific error messages you encounter to find solutions
- **Latest best practices** - Get information on current coding standards and recommended approaches
- **Library and package awareness** - Find and compare current libraries, packages, and dependencies
- **API changes and deprecations** - Stay informed about recent changes to APIs you're working with
- **Real-time knowledge** - Claude's built-in knowledge has a cutoff date, but web search provides current information
- **Enhanced problem-solving** - Combine Claude's reasoning with the collective knowledge of the developer community

Without web search, Claude relies solely on its training data, which may not include the most current information about rapidly evolving technologies, frameworks, and libraries.

## Adding More MCP Servers (Tools)

You can extend Claude Coder's capabilities by adding additional MCP servers. The [MCP Examples page](https://modelcontextprotocol.io/examples) provides a directory of available MCP tools and implementation examples, including APIs for:

- Web browsing
- Data visualization
- Image generation
- PDF analysis
- Database access
- Local file search

Each tool enhances Claude's abilities in specific domains, making it more versatile for your development workflow.
