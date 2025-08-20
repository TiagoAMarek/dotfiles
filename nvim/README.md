# Neovim Lua Config

This repository contains my personal Neovim configuration, written in Lua. It is organized for modularity, clarity, and ease of extension. Plugins are managed via [LazyVim](https://lazyvim.github.io/installation), and customizations are grouped by purpose.

## Structure

- `init.lua`: Entry point, loads core config and plugins.
- `lua/config/`: Core settings (options, keymaps, autocmds, lazy.nvim setup).
- `lua/plugins/`: Plugin configurations, organized by category.
- `lua/custom/`: Custom Lua modules and utilities.

## Plugin Management

- Uses [LazyVim](https://lazyvim.github.io/installation) for plugin management.
- Add plugins in `lua/plugins/` as separate files for clarity.
- Use the `opts` and `config` keys for plugin configuration.

## Custom Modules

- Place custom Lua code in `lua/custom/`.
- Use `require("custom.<module>")` to import.

## Formatting

- Code is formatted with [stylua](https://github.com/JohnnyMorganz/StyLua).
- Run `stylua .` to format all Lua files (2-space indent, 120-column width).

## Contributing

- Fork the repo and submit a pull request.
- Follow the code style guidelines (see below and AGENTS.md).
- Test your changes in Neovim before submitting.

---

## Agentic Coding Guidelines and Build/Lint/Test Summary

For contributors and agentic coding agents, please refer to [AGENTS.md](./AGENTS.md) for detailed instructions and guidelines.

**Summary:**
- **Build/Lint/Test:**
  - Format code: `stylua .` (2-space indent, 120-column width)
  - Lint: No dedicated linter; rely on stylua for formatting.
  - Test: No standard test runner; test plugins via Neovim commands or plugin-specific docs.
  - Run a single test: Use plugin-specific test commands inside Neovim (e.g., `:checkhealth <plugin>` or plugin docs).
- **Code Style:**
  - Imports: Use `require("<module>")` for Lua modules.
  - Naming: camelCase for variables/functions, snake_case for config/options.
  - Error Handling: Use idiomatic Lua (`if ... then ... end`), print errors with `vim.api.nvim_echo` or comments.
  - Comments: Use `--` for single-line, `--[[ ... ]]--` for block comments.
  - Plugin Config: Place plugin configs in `lua/plugins/` and use `opts`/`config` keys.
  - Copilot: Suggestions disabled by default; panel enabled (`<C-\>`).
  - Claude: Setup via `require("claude-code").setup()`.

For full details and up-to-date guidelines, see [AGENTS.md](./AGENTS.md).
