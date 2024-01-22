return {

  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  priority = 10000,
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button('e', 'New file', '<cmd>ene <CR>'),
      dashboard.button('f', 'Find file', '<cmd>Telescope find_files<CR>'),
      dashboard.button('r', 'Recently opened files', '<cmd>Telescope oldfiles<CR>'),
      dashboard.button('w', 'Find word', '<cmd> Telescope live_grep<CR>'),
    }
    _Gopts = {
      position = 'center',
      hl = 'Type',
      -- wrap = "overflow";
    }

    local function footer()
      return 'Programming is an art of patience not talent'
    end

    dashboard.section.footer.val = footer()

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
