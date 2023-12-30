-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
  opts = {
    -- disabled
    messages = { enabled = false },
    notify = { enabled = false },

    -- configs
    cmdline = {
      view = 'cmdline',
    },
    ---@type NoicePresets
    presets = {
      lsp_doc_border = true,
    },
    ---@type NoiceConfigViews
    views = {
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}
