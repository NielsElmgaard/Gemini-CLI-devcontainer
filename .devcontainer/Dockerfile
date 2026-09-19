FROM mcr.microsoft.com/devcontainers/base:bookworm

# Install required networking and build utilities
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
       iptables \
       dnsutils \
       curl \
       ca-certificates \
       git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 LTS (Node 24 is Current/non-LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install agy (Antigravity CLI)
RUN curl -fsSL https://antigravity.google/cli/install.sh | bash \
    && (install -m 755 /root/.local/bin/agy /usr/local/bin/agy 2>/dev/null \
        || install -m 755 /home/vscode/.local/bin/agy /usr/local/bin/agy 2>/dev/null \
        || true)

# Pre-create volume mount points and set non-root ownership
RUN mkdir -p /commandhistory /home/vscode/.gemini /home/vscode/.config \
    && touch /commandhistory/.bash_history \
    && chown -R vscode:vscode /commandhistory /home/vscode/.gemini /home/vscode/.config

# Install the firewall script, strip CRLF, and scope sudo execution
COPY firewall.sh /usr/local/bin/firewall.sh
RUN sed -i 's/\r$//' /usr/local/bin/firewall.sh \
    && chmod 755 /usr/local/bin/firewall.sh \
    && echo "vscode ALL=(root) NOPASSWD: /usr/local/bin/firewall.sh" > /etc/sudoers.d/firewall \
    && chmod 440 /etc/sudoers.d/firewall

USER vscode