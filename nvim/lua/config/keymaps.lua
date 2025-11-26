-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-x>", "<cmd>:bdelete<cr>", {})

vim.keymap.set("n", "<leader>cp", function()
  require("conform").format({
    lsp_fallback = true,
    timeout_ms = 1000,
    bufnr = 0,
    formatters = { "prettier" },
  })
end, { desc = "Format with Prettier" })

vim.keymap.set("n", "<leader>an", "<cmd>Sidekick nes update<cr>", { desc = "NES update" })
vim.keymap.set("n", "<leader>aN", "<cmd>Sidekick nes toggle<cr>", { desc = "NES toggle" })
