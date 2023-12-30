return {
  "vim-test/vim-test",
  keys = {
    { "<leader>tf", "<cmd>TestFile -strategy=kitty<cr>", desc = "Test File" },
    { "<leader>tn", "<cmd>TestNearest -strategy=kitty<cr>", desc = "Test Nearest" }
  }
}
