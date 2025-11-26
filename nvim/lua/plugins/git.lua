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
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "nvim-mini/mini.pick", -- optional
      "folke/snacks.nvim", -- optional
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    keys = {
      { "<leader>gC", "<cmd>GitConflictRefresh<cr>", desc = "Refresh Conflict" },
    },
  },
  {
    "sindrets/diffview.nvim",
    config = true,
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
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
}
