return {
  {
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
          prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
          provider = "default",                 -- default|telescope|mini_pick
          opts = {
            show_default_actions = true,        -- Show the default actions in the action palette?
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
      { '<leader>ccc', '<cmd>CodeCompanionChat<cr>',    desc = 'CodeCompanion - Chat' },
      { '<leader>cca', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion - Actions' },
    }

  },
  -- {
  --   "github/copilot.vim",
  --   cmd = "Copilot"
  -- },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = true,
          layout = {
            position = 'right', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
            enabled = true,
            auto_trigger = false,
            hide_during_completion = true,
            debounce = 75,
            trigger_on_accept = true,
            keymap = {
              accept = "<M-l>",
              accept_word = false,
              accept_line = false,
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
          },
        -- suggestion = {
        --   enabled = true,
        --   auto_trigger = true,
        --   hide_during_completion = false,
        --   debounce = 75,
        --   keymap = {
        --     accept = "<C-l>",
        --     accept_word = false,
        --     accept_line = false,
        --     next = "<C-]>",
        --     prev = "<C-[>",
        --     dismiss = "<C-d>",
        --   },
        -- },
        workspace_folders = {
          "/Users/tiagomarek/Projects/optimized-cx-du/frontend/cx-monorepo",
        }
      }
    end,
    keys = {
      { '<leader>ccp', '<cmd>Copilot panel<cr>', desc = 'Copilot - Suggestions panel' },
    },
  },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   opts = {
  --     show_help = 'yes',         -- Show help text for CopilotChatInPlace, default: yes
  --     debug = false,             -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
  --     disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
  --     prompts = {
  --       Explain = 'Explain how it works.',
  --       Review = 'Review the following code and provide concise suggestions.',
  --       Tests = 'Briefly explain how the selected code works, then generate unit tests.',
  --       Refactor = 'Refactor the code to improve clarity and readability.',
  --     },
  --   },
  --   build = function()
  --     vim.notify "Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim."
  --   end,
  --   event = 'VeryLazy',
  --   keys = {
  --     { '<leader>cco', '<cmd>CopilotChatOpen<cr>',     desc = 'CopilotChat - Open' },
  --     { '<leader>cce', '<cmd>CopilotChatExplain<cr>',  desc = 'CopilotChat - Explain code' },
  --     { '<leader>cct', '<cmd>CopilotChatTests<cr>',    desc = 'CopilotChat - Generate tests' },
  --     { '<leader>ccr', '<cmd>CopilotChatReview<cr>',   desc = 'CopilotChat - Review code' },
  --     { '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
  --   },
  -- },
}
