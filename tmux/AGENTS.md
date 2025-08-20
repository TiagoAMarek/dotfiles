# AGENTS.md: tmux Configuration & Agent Guidelines

This repository contains tmux configuration files. Agentic coding agents should follow these guidelines:

## Build/Lint/Test Commands
- No build/lint/test commands for tmux.conf. Use `tmux source-file ~/.config/tmux/tmux.conf` or `Prefix + r` to reload config.
- To install plugins: Inside tmux, press `Prefix + I` (Ctrl-b then Shift-i).
- To start tmux: `tmux`
- To kill server: `tmux kill-server`

## Code Style Guidelines
- Use clear section headers with comment blocks (e.g., `# -- General Settings --`).
- Group related settings and keybindings together.
- Use descriptive comments for each block and keybinding.
- Prefer explicit keybindings and avoid ambiguous/unbound keys.
- For plugins, use TPM syntax: `set -g @plugin 'plugin-name'`.
- Place `run '~/.tmux/plugins/tpm/tpm'` at the end of the file.
- Use double quotes for string values and single quotes for plugin names.
- Error handling: Use `display` to show messages after reloads or actions.
- For advanced popups, use `display-popup` with clear shell commands.
- Maintain consistent indentation and spacing.
- Avoid duplicate or conflicting keybindings.
- Always reload config after changes.

## Plugin Management
- Use TPM for plugin management. List plugins in a dedicated block.
- Recommended plugins: tmux-sensible, tmux-resurrect, tmux-continuum, tmux-yank, minimal-tmux-status, tmux-battery, tmux-cpu, vim-tmux-navigator.
- For plugin troubleshooting, ensure TPM is installed and plugins are listed correctly.

## Conventions
- Prefix key is Ctrl-b (default).
- Window/pane numbering starts at 1.
- True color enabled for modern terminals.
- Mouse support is on by default.

No Cursor or Copilot rules detected in this directory.
