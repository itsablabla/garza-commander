FROM node:20-slim

# Install Python and other dependencies needed by Desktop Commander
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install mcp-proxy globally
RUN npm install -g @sparfenyuk/mcp-proxy

# Install Desktop Commander globally
RUN npm install -g @wonderwhy-er/desktop-commander

# Set working directory
WORKDIR /workspace

# Expose port for SSE endpoint
EXPOSE 8080

# Run mcp-proxy wrapping Desktop Commander
# --host=0.0.0.0 to accept external connections
# --port=8080 for the SSE endpoint
CMD ["mcp-proxy", "--host=0.0.0.0", "--port=8080", "npx", "-y", "@wonderwhy-er/desktop-commander"]
