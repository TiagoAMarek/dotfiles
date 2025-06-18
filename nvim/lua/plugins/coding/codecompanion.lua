return {
  "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
      "echasnovski/mini.diff",
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
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
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
            model = "claude-3.5-sonnet",
            -- model = "gpt-4.1",
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
      display = {
        action_palette = {
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- default|telescope|mini_pick
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
        diff = {
          enabled = true,
          --   close_chat_at = 240,      -- Close an open chat buffer if the total columns of your display are less than...
          -- layout = "horizontal", -- vertical|horizontal split for default provider
          --   opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        },
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion - Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion - Actions" },
    },
  },
}
