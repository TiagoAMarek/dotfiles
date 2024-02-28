return {
  -- Setup Language servers
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall', 'Mason' },
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

      local servers = {
        eslint = {},
        quick_lint_js = {},
        jsonls = {},
        lua_ls = {},
      }

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
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

          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
          vim.keymap.set('n', 'gr', function()
            require('telescope.builtin').lsp_references { reuse_win = true }
          end, { desc = 'Go to references' })
          vim.keymap.set('n', 'ds', function()
            require('telescope.builtin').lsp_document_symbols { reuse_win = true }
          end, { desc = 'Document Symbols' })
          vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Go to signature help' })
        end,
      })
    end,
  },
}
