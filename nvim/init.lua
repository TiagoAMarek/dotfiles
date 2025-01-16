-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'install-lazy'
require 'options'
require 'keymaps'

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
