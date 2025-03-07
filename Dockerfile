# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic development tools and language runtimes
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  git \
  git-lfs \
  vim \
  python3 \
  python3-pip \
  ruby-full \
  golang-go \
  ca-certificates \
  openssh-client \
  gnupg \
  make \
  jq \
  zip \
  unzip \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Install modern CLI tools through apt repositories
RUN apt-get update && apt-get install -y \
  ripgrep \
  fd-find \
  bat \
  && rm -rf /var/lib/apt/lists/*

# Create symlink for fd-find to fd for easier use
RUN ln -s $(which fdfind) /usr/local/bin/fd

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && apt-get update \
  && apt-get install -y gh \
  && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 using the NodeSource setup script
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root developer user
RUN useradd -ms /bin/bash developer

# Create .ssh directory for the developer user
RUN mkdir -p /home/developer/.ssh && \
    chmod 700 /home/developer/.ssh && \
    chown developer:developer /home/developer/.ssh

# Switch to the developer user
USER developer
WORKDIR /home/developer

# Configure npm to install global packages in a user directory
RUN mkdir -p /home/developer/.npm-global && \
    npm config set prefix '/home/developer/.npm-global'
ENV PATH="/home/developer/.npm-global/bin:${PATH}"

# Install Claude Code globally via npm
RUN npm install -g @anthropic-ai/claude-code

# Create a persistent configuration directory for Claude Code (e.g. for authentication data)
RUN mkdir -p /home/developer/.claude

# Create empty directory for default project directory fallback
RUN mkdir -p /tmp/empty

# Volumes for Claude Code config and SSH credentials
VOLUME ["/home/developer/.claude", "/home/developer/.ssh"]

# Default command: launch Claude Code interactively
CMD ["claude", "--dangerously-skip-permissions", "--verbose"]