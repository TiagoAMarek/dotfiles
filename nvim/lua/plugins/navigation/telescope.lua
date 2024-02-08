local actions = require 'telescope.actions'

local dropdown = function()
  return require('telescope.themes').get_dropdown {
    layout_config = {
      width = 0.9,
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
      local fb_actions = require('telescope').extensions.file_browser.actions
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
          git_files = dropdown(),
          grep_string = dropdown(),
          help_tags = dropdown(),
          live_grep = dropdown(),
          lsp_definitions = dropdown(),
          lsp_implementations = dropdown(),
          lsp_references = dropdown(),
          lsp_type_definitions = dropdown(),
          marks = dropdown(),
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
          file_browser = {
            theme = 'dropdown',
            layout_config = {
              width = 0.8,
              height = 0.5,
            },
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ['i'] = {
                ['<C-b>'] = fb_actions.goto_parent_dir,
                ['<C-l>'] = fb_actions.open_dir,
                -- your custom insert mode mappings
              },
              ['n'] = {
                -- your custom normal mode mappings
              },
            },
          },
        },
      }

      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'file_browser'
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
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      -- open file_browser
      vim.api.nvim_set_keymap('n', '<space>b', ':Telescope file_browser grouped=true prompt_path=true<CR>', { noremap = true, desc = 'Browse files' })
      -- open file_browser with the path of the current buffer
      vim.api.nvim_set_keymap(
        'n',
        '<space>fd',
        ':Telescope file_browser path=%:p:h select_buffer=true grouped=true prompt_path=true<CR>',
        { noremap = true, desc = 'Browse files in current dir' }
      )
    end,
  },
}
