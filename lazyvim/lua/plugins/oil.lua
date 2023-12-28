return {
  "stevearc/oil.nvim",
  opts = {},
  enabled = true,
  cmd = "Oil",
  keys = {
    { "<leader>o", function() require("oil").open() end, desc = "Open folder in Oil" },
  },
  init = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
        "size",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<S-l>"] = "actions.select",
        ["<M-v>"] = "actions.select_vsplit",
        ["<M-s>"] = "actions.select_split",
        ["<M-t>"] = "actions.select_tab",
        ["<M-p>"] = "actions.preview",
        ["<M-c>"] = "actions.close",
        ["<M-r>"] = "actions.refresh",
        ["<S-h>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
    })
  end
}
