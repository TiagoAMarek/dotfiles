# AGENTS.md

## Build, Lint, and Test Commands
- **Format code:** `stylua .` (uses 2-space indent, 120-column width)
- **Lint:** No dedicated linter; rely on stylua for formatting.
- **Test:** No standard test runner; test plugins via Neovim commands or plugin-specific docs.
- **Run a single test:** Use plugin-specific test commands inside Neovim (e.g., `:checkhealth <plugin>` or plugin docs).

## Code Style Guidelines
- **Imports:** Use `require("<module>")` for Lua modules.
- **Formatting:** Follow stylua.toml (2 spaces, 120 columns).
- **Types:** Lua is dynamically typed; use clear variable names and comments for clarity.
- **Naming:** Prefer camelCase for variables/functions, snake_case for config/options.
- **Error Handling:** Use idiomatic Lua (e.g., `if ... then ... end`), print errors with `vim.api.nvim_echo` or comments.
- **Comments:** Use `--` for single-line, `--[[ ... ]]--` for block comments.
- **Plugin Config:** Place plugin configs in `lua/plugins/` and use `opts`/`config` keys.
- **Copilot:** Suggestions are disabled by default; panel enabled (`<C-\>`).
- **Claude:** Setup via `require("claude-code").setup()`.

For more details, refer to plugin documentation and LazyVim docs: https://lazyvim.github.io/installation
