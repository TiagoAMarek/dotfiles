local utils = require "kickstart.utils"
local is_available = utils.is_available

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', "<C-s>", "<cmd>w<cr>", { desc = "Write" })
vim.keymap.set('n', "<C-q>", "<cmd>enew<bar>bd #<cr>", { desc = "Force Close Buffer" })
vim.keymap.set('n', "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set('n', "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set('n', "<C-x>", "<cmd>LspZeroFormat<cr>", { desc = "Horizontal Split" })
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Git

vim.keymap.set(
  'n',
  "<leader>gg",
  function()
    require("lazygit").lazygit()
  end,
  { desc = "Git branches" }
)
vim.keymap.set(
  'n',
  "<leader>gb",
  function()
    require("telescope.builtin").git_branches { use_file_path = true }
  end,
  { desc = "Git branches" }
)

vim.keymap.set(
  'n',
  "<leader>gc",
  function()
    require("telescope.builtin").git_commits { use_file_path = true }
  end,
  { desc = "Git commits (repository)" }
)

vim.keymap.set(
  'n',
  "<leader>gC",
  function()
    require("telescope.builtin").git_bcommits { use_file_path = true }
  end,
  { desc = "Git commits (current file)" }
)

vim.keymap.set(
  'n',
  "<leader>gt",
  function()
    require("telescope.builtin").git_status { use_file_path = true }
  end,
  { desc = "Git status" }
)

-- Search
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Find current Word' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Find by Grep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'Find Resume' })
-- vim.keymap.set('n', "<leader>p", function() require("telescope").extensions.yank_history.yank_history {} end, { desc = "Open Yank History" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>t', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

