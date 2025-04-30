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
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = true
      })
      vim.keymap.set(
        "",
        "<Leader>l",
        require("lsp_lines").toggle,
        { desc = "Toggle lsp_lines" }
      )
    end,
  },
   "nvim-lua/plenary.nvim",
 { "nvim-tree/nvim-web-devicons", lazy = true },

 {
   "nvchad/ui",
    config = function()
      require "nvchad" 
    end
 },

 {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
 },

 "nvchad/volt", -- optional, needed for theme switcher
 -- or just use Telescope themes
}
