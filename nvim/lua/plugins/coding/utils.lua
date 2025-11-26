return {
  -- {
  --   "mcauley-penney/visual-whitespace.nvim",
  --   config = true,
  --   event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
  --   opts = {},
  -- },
  {
    "dstein64/nvim-scrollview",
    config = function()
      require("scrollview").setup({
        -- current_only = true,
        -- base = "buffer",
        signs_on_startup = { "all" },
        diagnostics_error_symbol = "x",
        diagnostics_warn_symbol = "!",
        latestchange_symbol = "",
        cursor_symbol = "",
        search_symbol = "",
      })

      require("scrollview.contrib.gitsigns").setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
