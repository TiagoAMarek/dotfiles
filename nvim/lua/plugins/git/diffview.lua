return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
    { "<leader>gk", "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>", desc = "Kill Diff View" },
  },
}
