return {
  "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
      require("custom.extmarks").setup()
    end,
    init = function()
      require("custom.spinner"):init()
    end,
    opts = {
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            picker = "snacks",
            enable_logging = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          },
        },
      },
      strategies = {
        chat = {
          keymaps = {
            close = {
              modes = { n = "<C-q>", i = "<C-q>" },
            },
          },
          adapter = {
            name = "copilot",
            model = "gpt-4.1",
          },
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                },
              },
            },
            ["fetch"] = {
              keymaps = {
                modes = {
                  i = "<C-f>",
                },
              },
            },
            ["help"] = {
              opts = {
                max_lines = 1000,
              },
            },
            ["image"] = {
              keymaps = {
                modes = {
                  i = "<C-i>",
                },
              },
              opts = {
                dirs = { "~/Documents/Screenshots" },
              },
            },
          },
        },
        inline = { adapter = "copilot" },
      },
      -- display = {
      --   action_palette = {
      --     prompt = "Prompt ", -- Prompt used for interactive LLM calls
      --     provider = "default", -- default|telescope|mini_pick
      --     opts = {
      --       show_default_actions = true, -- Show the default actions in the action palette?
      --       show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      --     },
      --   },
      -- },
    },
    keys = {
      { "<leader>Ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion - Chat" },
      { "<leader>Aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion - Actions" },
    },
  },
}
