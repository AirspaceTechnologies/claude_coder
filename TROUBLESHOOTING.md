# Troubleshooting

If you encounter issues with Claude Coder, try the following solutions.

## Alternative Run Methods

If the symlink method isn't working for you, try these alternatives:

```bash
# Alternative 1: Use the wrapper script directly
./claude_coder /path/to/your/project

# Alternative 2: Use docker-compose directly
PROJECT_DIR=/path/to/your/project docker-compose run --rm claude-coder
```

## Access Container Shell

For deeper troubleshooting, you can get a bash shell in the container:

```bash
# Start a bash shell in the container with your project mounted
PROJECT_DIR=/path/to/your/project docker-compose run --rm --entrypoint bash claude-coder

# Or if you're already in your project directory
docker-compose run --rm --entrypoint bash -e PROJECT_DIR=$(pwd) claude-coder

# Quick shell access without mounting any project
docker-compose run --rm claude-coder bash
```

## Common Issues

### Authentication Problems

If you're having trouble authenticating:
1. Check that you have a valid Anthropic account with API credits
2. Make sure your `.claude-docker.json` file exists and has proper permissions
3. Try clearing the auth token and authenticating again:
   ```bash
   echo '{}' > ~/.claude-docker.json
   ```

### Docker Connection Issues

If Docker can't connect:
1. Verify Docker is running with `docker info`
2. Check Docker service status with `systemctl status docker` (Linux) or Docker Desktop (Mac/Windows)
3. Restart Docker service if needed

### Permission Issues

If Claude can't access your files:
1. Verify the correct directory is mounted by checking the output of running the container
2. Ensure your project directory path doesn't contain special characters
3. Check file ownership and permissions in your project directory

### Container Build Issues

If you're unable to build the container:
1. Make sure Docker and Docker Compose are up to date
2. Check if there are network issues preventing package downloads
3. Try building with verbose output: `docker-compose build --progress=plain`