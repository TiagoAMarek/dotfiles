return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPost' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall', 'Mason' },
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jay-babu/mason-null-ls.nvim',
    'nvim-lua/plenary.nvim',
  },
  lazy = false,
  config = function()
    local mason_null_ls = require 'mason-null-ls'
    local null_ls = require 'null-ls'
    local null_ls_utils = require 'null-ls.utils'

    mason_null_ls.setup {
      ensure_installed = {
        'eslint_d',
        'prettierd', -- prettier formatter
      },
    }

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup {
      debug = true,

      root_dir = null_ls_utils.root_pattern('.null-ls-root', 'Makefile', '.git', 'package.json'),

      sources = {
        -- require 'none-ls.code_actions.eslint_d',
        -- require 'none-ls.diagnostics.eslint_d',
        require 'none-ls.formatting.eslint_d',
        code_actions.gitsigns,
        formatting.prettierd,
      },
      -- configure format on save
      -- on_attach = function(current_client, bufnr)
      --   if current_client.supports_method 'textDocument/formatting' then
      --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format {
      --           filter = function(client)
      --             --  only use null-ls for formatting instead of lsp server
      --             return client.name == 'null-ls'
      --           end,
      --           bufnr = bufnr,
      --         }
      --       end,
      --     })
      --   end
      -- end,
    }
  end,
}
