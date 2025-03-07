# Using Claude Coder

## Basic Usage

```bash
# Run from within your project directory
cd /path/to/your/project
claude_coder

# Or specify a project directory directly
claude_coder /path/to/your/project
```

When you run Claude Coder, your current directory is safely mounted in the Docker container, giving Claude access to your project files.

## Common Use Cases

Claude Coder can help you with various development tasks:

- Debugging code issues
- Adding new features
- Writing tests
- Refactoring existing code
- Explaining complex code sections
- Optimizing performance
- Documenting your codebase

Simply describe what you need in natural language, and Claude will help you accomplish it.

## Example Commands

Ask Claude questions about your codebase or request changes:

```
"Fix the bug in the login component that prevents form submission"
"Add unit tests for the user authentication flow"
"Explain how the data processing pipeline works"
"Refactor this function to improve performance"
"Help me understand this algorithm"
```

Claude will search through your codebase, understand the context, and make the requested changes or provide explanations.

## Working with Multiple Files

Claude Coder can work across multiple files and understand complex project structures. You don't need to specify file paths - Claude will find relevant files based on your description of the issue or task.