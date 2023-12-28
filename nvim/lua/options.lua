-- Set highlight on search
vim.o.hlsearch = true
vim.o.relativenumber = true
-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.scrolloff = 8

vim.o.foldenable = true   -- enable fold for nvim-ufo
vim.o.foldlevel = 99      -- set high foldlevel for nvim-ufo
vim.o.foldlevelstart = 99 -- start with all code unfolded
-- vim.o.foldcolumn = nil
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.o.copyindent = true
vim.o.tabstop = 2
-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- G options
vim.g.icons_enabled = true -- disable icons in the UI (disable if no nerd font is available)
vim.g.autoformat_enabled = true


-- Copilot
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""
