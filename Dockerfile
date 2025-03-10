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
  sudo \
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

# Add developer to sudo group
RUN usermod -aG sudo developer && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Create .ssh directory for the developer user
RUN mkdir -p /home/developer/.ssh && \
    chmod 700 /home/developer/.ssh && \
    chown developer:developer /home/developer/.ssh

# Install rbenv for Ruby version management
RUN git clone https://github.com/rbenv/rbenv.git /home/developer/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git /home/developer/.rbenv/plugins/ruby-build && \
    chown -R developer:developer /home/developer/.rbenv

# Switch to the developer user
USER developer
WORKDIR /home/developer

# Configure rbenv
ENV PATH="/home/developer/.rbenv/bin:/home/developer/.rbenv/shims:${PATH}"
RUN echo 'eval "$(rbenv init -)"' >> /home/developer/.bashrc && \
    /home/developer/.rbenv/bin/rbenv init -

# Configure npm to install global packages in a user directory
RUN mkdir -p /home/developer/.npm-global && \
    npm config set prefix '/home/developer/.npm-global'
ENV PATH="/home/developer/.npm-global/bin:/root/.local/bin:/usr/local/bin:${PATH}"

# Install Claude Code globally via npm
# RUN npm install -g @anthropic-ai/claude-code
COPY anthropic-ai-claude-code-patched-0.2.35.tgz anthropic-ai-claude-code-patched-0.2.35.tgz
RUN npm install -g ./anthropic-ai-claude-code-patched-0.2.35.tgz

# Create a persistent configuration directory for Claude Code (e.g. for authentication data)
RUN mkdir -p /home/developer/.claude

USER developer
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/developer/.bashrc && \
    chmod +x $HOME/.local/bin/uv* && \
    export PATH="$HOME/.local/bin:$PATH"
USER root
ENV PATH="/home/developer/.local/bin:${PATH}"

# Create empty directory for default project directory fallback
RUN mkdir -p /tmp/empty

USER developer

# Volumes for Claude Code config and SSH credentials
VOLUME ["/home/developer/.claude", "/home/developer/.ssh"]

# Default command: launch Claude Code interactively
# Use a shell to ensure PATH is properly set
# CMD ["claude-patched", "--dangerously-skip-permissions", "--verbose"]
CMD ["claude-patched", "--dangerously-skip-permissions", "--verbose"]