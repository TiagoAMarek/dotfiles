return {
  -- Setup Language servers
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufReadPre', 'BufAdd' },
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
        gopls = {},
        jsonls = {},
        lua_ls = {},
        quick_lint_js = {},
      }
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }

      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      --   callback = function(ev)
      --     -- keymaps
      --     vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      --
      --     vim.keymap.set('n', 'gd', function()
      --       require('telescope.builtin').lsp_definitions { reuse_win = true }
      --     end, { desc = 'Go to definition' })
      --
      --     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
      --
      --     vim.keymap.set('n', 'gi', function()
      --       require('telescope.builtin').lsp_implementations { reuse_win = true }
      --     end, { desc = 'Go to implementation' })
      --
      --     vim.keymap.set('n', 'go', function()
      --       require('telescope.builtin').lsp_type_definitions { reuse_win = true }
      --     end, { desc = 'Go to type definition' })
      --
      --     -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
      --     vim.keymap.set('n', 'gr', function()
      --       require('telescope.builtin').lsp_references { reuse_win = true }
      --     end, { desc = 'Go to references' })
      --     vim.keymap.set('n', 'ds', function()
      --       require('telescope.builtin').lsp_document_symbols { reuse_win = true }
      --     end, { desc = 'Document Symbols' })
      --     vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Go to signature help' })
      --   end,
      -- })
    end,
  },
  {
    'DNLHC/glance.nvim',
    config = function()
      -- Lua configuration
      local glance = require 'glance'
      local actions = glance.actions

      glance.setup {
        height = 18, -- Height of the window
        zindex = 45,

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        -- detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        detached = function(winid)
          return vim.api.nvim_win_get_width(winid) < 100
        end,

        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = false, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
        list = {
          position = 'right', -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = false, -- Will generate colors for the plugin based on your current colorscheme
          mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ['j'] = actions.next, -- Bring the cursor to the next item in the list
            ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
            ['<Down>'] = actions.next,
            ['<Up>'] = actions.previous,
            ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['v'] = actions.jump_vsplit,
            ['s'] = actions.jump_split,
            ['t'] = actions.jump_tab,
            ['<CR>'] = actions.jump,
            ['o'] = actions.jump,
            ['l'] = actions.open_fold,
            ['h'] = actions.close_fold,
            ['<leader>l'] = actions.enter_win 'preview', -- Focus preview window
            ['q'] = actions.close,
            ['Q'] = actions.close,
            ['<Esc>'] = actions.close,
            ['<C-q>'] = actions.quickfix,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ['Q'] = actions.close,
            ['<Tab>'] = actions.next_location,
            ['<S-Tab>'] = actions.previous_location,
            ['<leader>l'] = actions.enter_win 'list', -- Focus list window
          },
        },
        hooks = {},
        folds = {
          fold_closed = '',
          fold_open = '',
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = '│',
        },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      }

      -- Lua
      vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>')
      vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>')
      vim.keymap.set('n', 'gD', '<CMD>Glance type_definitions<CR>')
      vim.keymap.set('n', 'gI', '<CMD>Glance implementations<CR>')
    end,
  },
}
