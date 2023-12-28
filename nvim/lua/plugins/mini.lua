return {
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>e",
        function() require("mini.files").open() end,
        desc = "Explorer",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  { 'echasnovski/mini.cursorword', version = false },
  { 'echasnovski/mini.trailspace', version = false },
}
