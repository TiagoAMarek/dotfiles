return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      -- See `:help gitsigns.txt`
      current_line_blame = true,
    },
  },
  {
    "chrisgrieser/nvim-tinygit",
    -- dependencies = "nvim-telescope/telescope.nvim", -- only for interactive staging
  },
}
