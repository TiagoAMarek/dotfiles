-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<leader>x', '<C-w>q', { desc = 'Close window' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Write' })

-- Pane split
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })

-- Git
vim.keymap.set('n', '<leader>gg', ':<cmd>Git<cr><cr>', { desc = 'Fugitive' })
vim.keymap.set('n', '<leader>gl', function()
  require('lazygit').lazygit()
end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gb', function()
  require('telescope.builtin').git_branches { use_file_path = true }
end, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>gc', function()
  require('telescope.builtin').git_commits { use_file_path = true }
end, { desc = 'Git commits (repository)' })
vim.keymap.set('n', '<leader>gC', function()
  require('telescope.builtin').git_bcommits { use_file_path = true }
end, { desc = 'Git commits (current file)' })
vim.keymap.set('n', '<leader>gt', function()
  require('telescope.builtin').git_status { use_file_path = true }
end, { desc = 'Git status' })

-- Search
vim.keymap.set('n', '<leader>fs', ":lua require('telescope.builtin').lsp_document_symbols()<CR>",
  { desc = 'Find Symbols' })
vim.keymap.set('n', '<leader><space>', ":lua require('telescope.builtin').buffers()<CR>", { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fm', require('telescope.builtin').marks, { desc = 'Find Marks' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Find current Word' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>ct', ":%s/js/ts/I<CR>", { desc = 'Replace string JS to TS' })

vim.keymap.set('n', '<leader>fG', require('telescope.builtin').live_grep, { desc = 'Find by Grep' })
vim.keymap.set('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = 'Find by Grep' })
-- vim.keymap.set('n', '<leader>fd', function()
--   require('telescope.builtin').find_files { cwd = vim.fn.expand '%:p:h' }
-- end, { desc = 'Find in current dir' })
-- vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'Find Resume' })
-- vim.keymap.set('n', '<leader>fp', ":lua require'telescope'.extensions.project.project{}<CR>", { desc = 'Projects' })
vim.keymap.set('n', '<leader>p', function()
  require('telescope').extensions.yank_history.yank_history {}
end, { desc = 'Open Yank History' })
vim.keymap.set('n', '<leader>r', require('telescope.builtin').oldfiles, { desc = 'Show recently opened files' })
-- vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>t', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- code
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, { desc = 'Format' })

-- window
vim.keymap.set('n', '=', [[<cmd>vertical resize +5<cr>]])   -- make the window biger vertically
vim.keymap.set('n', '-', [[<cmd>vertical resize -5<cr>]])   -- make the window smaller vertically
vim.keymap.set('n', '+', [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set('n', '_', [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -
