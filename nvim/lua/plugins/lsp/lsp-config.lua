return {
  -- Setup Language servers
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'SmiteshP/nvim-navic',
      'SmiteshP/nvim-navbuddy',
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

      local servers = {
        eslint = {},
        jsonls = {},
        lua_ls = {},
      }

      local on_attach = function(client, bufnr)
        -- add breadcrumbs
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
        -- breadcrumbs navigation
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navbuddy').attach(client, bufnr)
        end
      end

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }

      -- keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })

      vim.keymap.set('n', 'gd', function()
        require('telescope.builtin').lsp_definitions { reuse_win = true }
      end, { desc = 'Go to definition' })

      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })

      vim.keymap.set('n', 'gi', function()
        require('telescope.builtin').lsp_implementations { reuse_win = true }
      end, { desc = 'Go to implementation' })

      vim.keymap.set('n', 'go', function()
        require('telescope.builtin').lsp_type_definitions { reuse_win = true }
      end, { desc = 'Go to type definition' })

      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Go to signature help' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format' })
    end,
  },
}
