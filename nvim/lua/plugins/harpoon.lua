return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "Harpoon" },
    keys = {
      { "<C-a>", function() require("harpoon.mark").add_file() end,        desc = "Add file" },
      { "<C-p>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle quick menu" },
      { "<C-,>",      function() require("harpoon.ui").nav_prev() end,          desc = "Goto previous mark" },
      { "<C-.>",      function() require("harpoon.ui").nav_next() end,          desc = "Goto next mark" },
      { "<leader>hm", "<cmd>Telescope harpoon marks<CR>",                       desc = "Show marks in Telescope" },
    },
  },
}
