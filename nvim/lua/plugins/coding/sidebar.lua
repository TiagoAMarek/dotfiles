return {
  'sidebar-nvim/sidebar.nvim',
  opts = {
    open = false,
    sections = { 'datetime', 'files', 'buffers', 'git', 'diagnostics' },
    datetime = {
      icon = '',
      format = '%a %b %d, %H:%M',
      clocks = {
        { name = 'local' },
      },
    },
    buffers = {
      icon = '',
      ignored_buffers = {}, -- ignore buffers by regex
      sorting = 'id', -- alternatively set it to "name" to sort by buffer name instead of buf id
      show_numbers = true, -- whether to also show the buffer numbers
      ignore_not_loaded = true, -- whether to ignore not loaded buffers
      ignore_terminal = true, -- whether to show terminal buffers in the list
    },
    files = {
      icon = '',
      show_hidden = false,
      ignored_paths = { '%.git$' },
    },
  },
}
