#!/bin/bash

# Get the current directory as the default project directory
CURRENT_DIR=$(pwd)

# Allow overriding the project directory via command line argument
if [ $# -gt 0 ]; then
  PROJECT_DIR="$1"
else
  PROJECT_DIR="$CURRENT_DIR"
fi

# Print information about the run
echo "Starting Claude Code with project directory: $PROJECT_DIR"

# Run Claude Code with the specified project directory
cd "$(dirname "$0")" && PROJECT_DIR="$PROJECT_DIR" docker-compose run --rm claude-code