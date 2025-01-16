return {
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
      }
    end,
    keys = {
      { '<leader>ccp', '<cmd>Copilot panel<cr>', desc = 'Copilot - Suggestions panel' },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    opts = {
      show_help = 'yes', -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
      prompts = {
        Explain = 'Explain how it works.',
        Review = 'Review the following code and provide concise suggestions.',
        Tests = 'Briefly explain how the selected code works, then generate unit tests.',
        Refactor = 'Refactor the code to improve clarity and readability.',
      },
    },
    build = function()
      vim.notify "Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim."
    end,
    event = 'VeryLazy',
    keys = {
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
      { '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
    },
  },
}
