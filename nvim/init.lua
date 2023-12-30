-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('install-lazy')
require('options')
require('keymaps')

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
  ['<leader>q'] = { name = 'Diagnostic', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
  ['<leader>u'] = { name = 'Treesitter', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'harpoon', _ = 'which_key_ignore' },
  ['<leader>m'] = { name = 'Messages', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = 'Session Manager', _ = 'which_key_ignore' },
  ['<leader>b'] = { name = 'Buffers', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = 'Tests', _ = 'which_key_ignore' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
