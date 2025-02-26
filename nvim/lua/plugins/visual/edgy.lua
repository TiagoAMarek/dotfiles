return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = 'screen'
  end,
  opts = {
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      'Trouble',
      { ft = 'qf',            title = 'QuickFix' },
      {
        ft = 'help',
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == 'help'
        end,
      },
      { ft = 'spectre_panel', size = { height = 0.4 } },
    },
    left = {
      {
        ft = 'Outline',
        open = 'OutlineOpen',
      },
      {
        ft = 'copilot-chat',
        open = 'CopilotChat',
        size = { width = 70 },
      },
      {
        ft = 'fugitive',
        title = 'Git Fugitive',
        open = 'Git',
        size = { width = 70 }
      },
      { title = "Neotest Output", ft = "neotest-output-panel", size = { width = 70 } },

    },
    top = {
    }
  },
}
