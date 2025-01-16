return {
  { 'echasnovski/mini.cursorword', version = false },
  { 'echasnovski/mini.trailspace', version = false },
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup()
    end,
  },
}
