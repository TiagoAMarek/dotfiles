return {
  'nvim-focus/focus.nvim',
  version = '*',
  config = function()
    require('focus').setup {
      autoresize = {
        enable = false,
      },
    }

    vim.keymap.set('n', '\\', '<cmd>FocusSplitRight<cr>', { desc = 'Vertical Split' })

    vim.keymap.set('n', '<leader>sa', function()
      require('focus').focus_autoresize()
    end, { desc = 'Autoresize windows' })

    vim.keymap.set('n', '<leader>se', function()
      require('focus').focus_equalise()
    end, { desc = 'Equalise windows' })

    vim.keymap.set('n', '<leader>sm', function()
      require('focus').focus_maximise()
    end, { desc = 'Maximise window' })

    vim.keymap.set('n', '<leader>sn', function()
      require('focus').split_nicely()
    end, { desc = 'Split nicely' })
  end,
}
