return {
  "wfxr/minimap.vim",
  build = "brew install code-minimap",
  lazy = false,
  cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
  keys = {
    { "<leader>um", "<cmd>MinimapToggle<CR>", desc = "Toggle minimap", mode = { "n" } },
  },
  init = function()
    vim.g.minimap_width = 15
    vim.g.minimap_auto_start = 1
    vim.g.minimap_auto_start_win_enter = 1
    vim.g.minimap_close_filetypes = { "oil" }
    vim.g.minimap_block_filetypes = {
      "NvimTree",
      "TelescopePrompt",
      "fugitive",
      "fzf",
      "lazy",
      "mason",
      "neo-tree",
      "nerdtree",
      "netrw",
      "noice",
      "notify",
      "prompt",
      "qf",
      "tagbar",
    }
    vim.g.minimap_highlight_search = 1
    vim.g.minimap_git_colors = 1
  end,
}
