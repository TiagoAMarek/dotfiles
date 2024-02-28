return {
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
      auto_open = true,
      auto_close = true,
      position = 'right',
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>qx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>qX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>qL', '<cmd>TroubleToggle loclist<cr>', desc = 'Location List (Trouble)' },
      { '<leader>qQ', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix List (Trouble)' },
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
