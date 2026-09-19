# Gemini CLI Devcontainer

This project provides a secure, ready-to-use development container for working with Gemini CLI in Visual Studio Code. It is designed for developers who want a controlled AI-assisted workflow without exposing their local environment to unnecessary network access.

## What this project includes

- A reproducible dev container based on Debian
- Node.js 24 LTS for CLI tooling and JavaScript-based workflows
- Gemini CLI support in a configured VS Code environment
- Persistent storage for shell history and Gemini configuration
- A built-in firewall that blocks private and local network access while allowing public outbound web traffic needed for AI tools, package managers, and APIs

## Why use it

This setup is useful when you want a clean, isolated environment for experimenting with AI-powered command-line workflows. The container keeps your Gemini configuration and command history stored persistently, while the firewall helps reduce risk by restricting traffic to the public internet and blocking access to local LAN and private network ranges.

## Getting started

1. Open the repository in VS Code with the Dev Containers extension installed.
2. Reopen the project in the container when prompted.
3. Run Gemini CLI from the integrated terminal and begin working in the sandboxed environment.

## Project structure

- `.devcontainer/` contains the container configuration, Dockerfile, and firewall setup
- `.env.example` is a placeholder for environment variables
- `.gitignore` keeps local environment and build artifacts out of source control

This is a simple but effective foundation for AI-assisted development in a safer, more controlled environment.
