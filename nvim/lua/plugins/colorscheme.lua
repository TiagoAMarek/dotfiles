return {
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    priority = 1000,
    opts = {
      colorscheme = "tokyonight", -- or "onedark" or "onelight"
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },
}
