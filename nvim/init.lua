-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
 -- put this in your main init.lua file ( before lazy setup )
 vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require 'install-lazy'
require 'options'
require 'keymaps'

-- (method 1, For heavy lazyloaders)
 dofile(vim.g.base46_cache .. "defaults")
 dofile(vim.g.base46_cache .. "statusline")

-- document existing key chains
require('which-key').add {
  { '<leader>d', group = 'debug' },
  { '<leader>b', group = 'Buffers' },
  { 'leader>c', group = 'Code' },
  { 'leader>cc', group = 'Copilot' },
  { '<leader>f', group = 'Find' }, -- group
  { '<leader>g', group = 'Git' },
  { 'leader>h', group = 'harpoon' },
  { 'leader>m', group = 'Messages' },
  { 'leader>q', group = 'Diagnostic' },
  { 'leader>s', group = 'Session' },
  { 'leader>u', group = 'Treesitter' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
