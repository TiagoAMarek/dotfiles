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
      { ft = 'qf', title = 'QuickFix' },
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
        ft = 'Copilot panel',
        title = 'Copilot',
        pinned = true,
        open = 'Copilot panel',
      },
      {
        ft = 'Outline',
        open = 'OutlineOpen',
      },
    },
  },
}
