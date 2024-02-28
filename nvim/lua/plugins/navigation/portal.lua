return {
  'cbochs/portal.nvim',
  -- Optional dependencies
  dependencies = {
    'cbochs/grapple.nvim',
    'ThePrimeagen/harpoon',
  },
  config = function()
    vim.keymap.set('n', '<leader>jb', '<cmd>Portal jumplist backward<cr>')
    vim.keymap.set('n', '<leader>jf', '<cmd>Portal jumplist forward<cr>')
  end,
}
