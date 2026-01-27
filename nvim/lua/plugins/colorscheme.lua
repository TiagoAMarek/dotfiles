return {
  -- Configure LazyVim to load gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    priority = 1000,
    opts = {
      colorscheme = "catppuccin-mocha", -- or "onedark" or "onelight"
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },
}
