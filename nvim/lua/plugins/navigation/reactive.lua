return {
  'rasulomaroff/reactive.nvim',
  config = function()
    require('reactive').add_preset {
      name = 'kanagawa',
      modes = {
        [{ 'i', 'niI' }] = {
          hl = {
            ReactiveCursor = { bg = '#98be65' },
            CursorLine = { bg = '#2f3b1e' },
            CursorLineNr = { fg = '#98be65', bg = '#2f3b1e' },
          },
        },
        n = {
          hl = {
            ReactiveCursor = { bg = '#ffffff' },
            CursorLine = { bg = '#21202e' },
            CursorLineNr = { fg = '#ffffff', bg = '#21202e' },
          },
        },
        no = {
          operators = {
            y = {
              hl = {
                ReactiveCursor = { bg = '#FFA066' },
                CursorLine = { bg = '#422006' },
                CursorLineNr = { fg = '#FFA066', bg = '#422006' },
              },
            },
            -- delete
            d = {
              hl = {
                ReactiveCursor = { bg = '#fca5a5' },
                CursorLine = { bg = '#350808' },
                CursorLineNr = { fg = '#fca5a5', bg = '#350808' },
              },
            },
            c = {
              hl = {
                ReactiveCursor = { bg = '#93c5fd' },
                CursorLine = { bg = '#202020' },
                CursorLineNr = { fg = '#ffffff', bg = '#303030' },
              },
            },
          },
        },
        [{ 'v', 'V', '\x16' }] = {
          hl = {
            ReactiveCursor = { bg = '#7E9CD8' },
            CursorLine = { bg = '#223249' },
            CursorLineNr = { fg = '#7E9CD8', bg = '#223249' },
          },
        },
        c = {
          hl = {
            ReactiveCursor = { bg = '#cbd5e1' },
            CursorLine = { bg = '#202020' },
            CursorLineNr = { fg = '#ffffff', bg = '#303030' },
          },
        },
        [{ 's', 'S', '\x13' }] = {
          hl = {
            ReactiveCursor = { bg = '#c4b5fd' },
            CursorLineNr = { fg = '#c4b5fd' },
            Visual = { bg = '#2e1065' },
          },
        },
        [{ 'R', 'niR', 'niV' }] = {
          hl = {
            ReactiveCursor = { bg = '#67e8f9' },
            CursorLine = { bg = '#083344' },
            CursorLineNr = { fg = '#67e8f9', bg = '#083344' },
          },
        },
      },
    }
    require('reactive').setup {
      builtin = {
        cursorline = true,
        cursor = true,
        modemsg = true,
      },
      load = { 'kanagawa' },
    }
  end,
}
