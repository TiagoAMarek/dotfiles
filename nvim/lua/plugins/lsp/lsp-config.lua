return {
  -- Setup Language servers
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      require('mason').setup {
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
      require('mason-lspconfig').setup {
        ensure_installed = { 'tsserver', 'eslint', 'jsonls', 'lua_ls' },
      }

      local lspconfig = require 'lspconfig'

      lspconfig.jsonls.setup {}
      -- lspconfig.tsserver.setup {}
      -- lspconfig.eslint.setup {}
      lspconfig.lua_ls.setup {}

      -- keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
      vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Go to signature help' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format' })
    end,
  },
}
