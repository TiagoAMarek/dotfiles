return {
  "olimorris/codecompanion.nvim",
  config = true,
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "copilot",
      },
    },
    display = {
      action_palette = {
        prompt = "Prompt ", -- Prompt used for interactive LLM calls
        provider = "default", -- default|telescope|mini_pick
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
      -- diff = {
      --   enabled = true,
      --   close_chat_at = 240,      -- Close an open chat buffer if the total columns of your display are less than...
      --   layout = "vertical",      -- vertical|horizontal split for default provider
      --   opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      --   provider = "mini_diff",     -- default|mini_diff
      -- },
    },
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion - Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion - Actions" },
  },
}
