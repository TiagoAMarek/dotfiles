local actions = require 'telescope.actions'

local dropdown = function()
  return require('telescope.themes').get_dropdown {
    layout_config = {
      width = 0.8,
      height = 0.5,
    },
  }
end

return {
  {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-project.nvim',
    },
    keys = {
      keys = {
        { '<leader>gf', require('telescope.builtin').git_files, desc = 'Find Git Files' },
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        pickers = {
          buffers = vim.tbl_extend('force', dropdown(), {
            show_all_buffers = true,
            sort_mru = true,
            mappings = {
              i = {
                ['<c-d>'] = 'delete_buffer',
              },
            },
          }),
          diagnostics = dropdown(),
          find_files = dropdown(),
          grep_string = dropdown(),
          help_tags = dropdown(),
          live_grep = dropdown(),
          oldfiles = dropdown(),
          resume = dropdown(),
        },
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }

      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'live_grep_args'
      require('telescope').load_extension 'project'
    end,
  },
  {
    -- makes telescope faster
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    config = function()
      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
