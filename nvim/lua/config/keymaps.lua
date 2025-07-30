-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local api = vim.api
-- Bufnr = -1
--
-- local function spf_run()
--   api.nvim_command("terminal spf")
--   api.nvim_command("startinsert")
--   local buf = api.nvim_get_current_buf()
--   Bufnr = buf
--
--   api.nvim_buf_set_keymap(Bufnr, "n", "<C-q>", ":bdelete!<CR>", {})
--   api.nvim_buf_set_keymap(Bufnr, "t", "<esc>", "<C-\\><C-n> :bdelete!<CR>", {})
-- end
--
-- local function spf()
--   -- vim.print(Bufnr)
--   if Bufnr == -1 then
--     spf_run()
--     return
--   end
--
--   -- Check if a buffer with bufnr exists
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if buf == Bufnr then
--       api.nvim_set_current_buf(Bufnr)
--       api.nvim_command("startinsert")
--       return
--     end
--   end
--
--   Bufnr = -1
--   spf_run()
-- end
--
-- vim.keymap.set("n", "<C-l>", spf, {})

vim.keymap.set("n", "<C-x>", "<cmd>:bdelete<cr>", {})

-- disable find files default keymaps
vim.keymap.del("n", "<leader>ff")
vim.keymap.del("n", "<leader>fc")
vim.keymap.del("n", "<leader>fn")
vim.keymap.del("n", "<leader>fp")
vim.keymap.del("n", "<leader>fg")
vim.keymap.del("n", "<leader>fb")
vim.keymap.del("n", "<leader>fB")
vim.keymap.del("n", "<leader>fr")
vim.keymap.del("n", "<leader>fR")
vim.keymap.del("n", "<leader>fF")
vim.keymap.del("n", "<leader>fe")
vim.keymap.del("n", "<leader>fE")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

vim.keymap.set("n", "<leader>w", function()
  require("snacks.picker").grep()
end, { desc = "Find word" })

vim.keymap.set("n", "<leader>W", function()
  require("snacks.picker").grep({ root = false })
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>f", function()
  require("snacks.picker").files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>F", function()
  require("snacks.picker").files({ root = false })
end, { desc = "Find Files (cwd)" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "Explorer" })

vim.keymap.set("n", "<leader>r", function()
  require("snacks.picker").recent()
end, { desc = "Recent" })
--
-- vim.keymap.set("n", "<leader>F", function()
--   require("lazyvim.util").pick("files", { root = false })
-- end, { desc = "Find Files (cwd)", noremap = true })

vim.keymap.set("n", "<leader>cp", function()
  require("conform").format({
    lsp_fallback = true,
    timeout_ms = 1000,
    bufnr = 0,
    formatters = { "prettier" },
  })
end, { desc = "Format with Prettier" })
