#!/usr/bin/env bash
set -euo pipefail

# Ensure vscode user owns persistent volume mount points
chown -R vscode:vscode /home/vscode/.gemini /home/vscode/.config /commandhistory 2>/dev/null || true

echo "Configuring container firewall..."

# Flush existing iptables rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Default policy: DROP all outgoing and incoming traffic
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# 1. Allow loopback interface (internal container communication)
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# 2. Allow already established / related return traffic
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 3. Allow outbound DNS resolution (port 53 UDP/TCP)
# Kept above the drop rules so Docker Desktop's internal DNS resolver works
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

# 4. BLOCK traffic to private networks, host Windows PC, and link-local ranges
iptables -A OUTPUT -d 10.0.0.0/8 -j DROP
iptables -A OUTPUT -d 172.16.0.0/12 -j DROP
iptables -A OUTPUT -d 192.168.0.0/16 -j DROP
iptables -A OUTPUT -d 169.254.0.0/16 -j DROP

# 5. ALLOW all public web traffic (HTTP & HTTPS) for APIs, tools, and package managers
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -j ACCEPT

echo "Firewall active: Windows host/LAN blocked, public web tools enabled."