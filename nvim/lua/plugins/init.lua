return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    'lambdalisue/suda.vim',
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end,
  },
  {
    'nguyenvukhang/nvim-toggler',
    event = { 'User AstroFile', 'InsertEnter' },
    keys = {
      {
        '<leader>i',
        desc = 'Toggle CursorWord',
      },
    },
    opts = {},
  },
}
