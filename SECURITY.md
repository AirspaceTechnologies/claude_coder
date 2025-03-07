# Security Policy

## Reporting a Vulnerability

We take the security of the Claude Coder Docker environment seriously. If you believe you've found a security vulnerability in this project, please follow these steps:

1. **Do Not Disclose Publicly**: Please do not disclose the issue publicly until it has been addressed.

2. **Email Details**: Send an email to [michael@airspace.com](mailto:michael@airspace.com) with:
   - A description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Any suggestions for mitigation

3. **Response Time**: We'll acknowledge your report within 72 hours and provide an estimated timeline for a fix.

4. **Disclosure Process**: Once the issue is fixed, we'll:
   - Release a patch
   - Credit you in the release notes (unless you prefer to remain anonymous)
   - Coordinate disclosure timing if needed

## Security Considerations

### Docker Permission Handling

This Docker implementation runs Claude Code with the `--dangerously-skip-permissions` flag enabled by default:

```
CMD ["claude", "--dangerously-skip-permissions", "--verbose"]
```

**Security Implications**:
- Claude Code will not prompt for permission before accessing files
- All files in mounted volumes are accessible to Claude Code
- Security relies on proper Docker volume configuration

**Recommendations**:
- Only mount directories that Claude Code should have access to
- Do not mount sensitive directories or files containing credentials
- Consider running without this flag if working with highly sensitive codebases

### Credential Security

- Authentication tokens are stored in the `.claude-docker` directory and `.claude-docker.json` file
- These are mounted as volumes and persist between container runs
- Ensure these files have appropriate permissions on your host machine

## Dependency Security

We regularly update dependencies to address known vulnerabilities. However, you should:

1. Periodically rebuild the Docker image to incorporate security updates
2. Check for security advisories related to the project's dependencies
3. Consider using tools like Dependabot when forking this repository