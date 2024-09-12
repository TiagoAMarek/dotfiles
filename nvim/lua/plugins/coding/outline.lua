return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>co', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    -- Your setup opts here
  },
}
