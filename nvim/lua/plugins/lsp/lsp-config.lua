return {
  -- Setup Language servers
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'stevearc/conform.nvim',
    },
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'tsserver', 'eslint', 'jsonls', 'lua_ls' },
      }

      local lspconfig = require 'lspconfig'
      local null_ls = require 'null-ls'
      local util = require 'lspconfig.util'

      lspconfig.jsonls.setup {}
      lspconfig.tsserver.setup {}
      lspconfig.lua_ls.setup {}

      -- add formatting feature
      require('conform').setup {
        -- Map of filetype to formatters
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Conform will run multiple formatters sequentially
          -- Use a sub-list to run only the first available formatter
          javascript = { { 'eslint_d', 'eslint' } },
          typescript = { { 'eslint_d', 'eslint' } },
          json = { { 'eslint_d', 'eslint', 'fixjson' } },
        },
      }

      null_ls.setup {
        sources = {
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.diagnostics.eslint_d,
        },
      }

      -- keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
      vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Go to signature help' })
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      vim.keymap.set('n', '<leader>cf', function(bufnr)
        require('conform').format { bufnr = bufnr }
      end, { desc = 'Format' })
    end,
  },
}
