return {
  "folke/noice.nvim",
  event = "VeryLazy",
  lazy = false,
  keys = {
    {
      "<leader>md",
      "<cmd>NoiceDismiss<cr>",
      desc = "Dismiss messages",
    },
    {
      "<leader>mm",
      "<cmd>Noice<cr>",
      desc = "Messages",
    },

  },
  config = function()
    require("notify").setup({
      background_colour = "#fff",
    })
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
}
