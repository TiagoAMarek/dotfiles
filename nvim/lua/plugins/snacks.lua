return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- explorer = { enabled = false },
    picker = {
      formatters = {
        file = {
          truncate = 60,
        },
      },
      sources = {
        explorer = {
          auto_close = true,
          layout = {
            layout = {
              width = 80,
            },
          },
        },
      },
    },
  },
}
