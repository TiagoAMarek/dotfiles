return {
  -- quick fix for json and yaml
  {
    'gennaro-tedesco/nvim-jqx',
    ft = { 'json', 'yaml' },
  },
  -- Show diagnoteic in the right top corner
  {
    'dgagn/diagflow.nvim',
    -- event = 'LspAttach', This is what I use personnally and it works great
    opts = {},
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      auto_open = false,
      auto_close = true,
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>qx', '<cmd>Trouble diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>qL', '<cmd>Trouble loclist<cr>', desc = 'Location List (Trouble)' },
      { '<leader>qQ', '<cmd>Trouble quickfix<cr>', desc = 'Quickfix List (Trouble)' },
      -- {
      --   '[d',
      --   function()
      --     if require('trouble').is_open() then
      --       require('trouble').previous { skip_groups = true, jump = true }
      --     else
      --       local ok, err = pcall(vim.cmd.cprev)
      --       if not ok then
      --         vim.notify(err, vim.log.levels.ERROR)
      --       end
      --     end
      --   end,
      --   desc = 'Previous trouble/quickfix item',
      -- },
      -- {
      --   ']d',
      --   function()
      --     if require('trouble').is_open() then
      --       require('trouble').next { skip_groups = true, jump = true }
      --     else
      --       local ok, err = pcall(vim.cmd.cnext)
      --       if not ok then
      --         vim.notify(err, vim.log.levels.ERROR)
      --       end
      --     end
      --   end,
      --   desc = 'Next trouble/quickfix item',
      -- },
    },
  },
}
