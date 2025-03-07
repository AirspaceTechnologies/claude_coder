# Technical Details

## Authentication Isolation

This setup maintains separate authentication configurations between:

1. **Local Claude Coder installation** (uses `.claude` directory and `.claude.json`)
2. **Docker-based Claude Coder** (uses `.claude-docker` directory and `.claude-docker.json`)

This isolation ensures that:
- Your auth tokens and settings remain separate between environments
- You can use different Anthropic accounts in each environment if needed
- Container rebuilds won't affect your authentication state
- Local and containerized Claude can run side-by-side without conflicts

## Permission Handling

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

## Customizing the Environment

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