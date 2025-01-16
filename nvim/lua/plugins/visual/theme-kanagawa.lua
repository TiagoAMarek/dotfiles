return {
  {
    'xiyaowong/transparent.nvim',
    priority = 1000,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    -- opts = { integrations = { mini = true } },
    priority = 1000,
    lazy = false,
    config = function()
      require('kanagawa').setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        transparent = true, -- set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        theme = 'dragon', -- Load "wave" theme when 'background' option is not setlocal
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- AutoComplete colors
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Mini files
            -- MiniFilesNormal = { bg = 'none' },
            MiniFilesBorder = { fg = theme.ui.fg, bg = 'none' },
            MiniFilesNormal = { fg = theme.ui.fg, bg = 'none' },
            MiniFilesBorderModified = { fg = theme.ui.fg, bg = 'none' },
            MiniFilesTitle = { fg = theme.ui.fg, bg = 'none' },
            MiniFilesTitleFocused = { fg = theme.ui.fg, bg = 'none' },
            MinifilesFile = { fg = theme.ui.fg, bg = 'none' },

            -- telescope
            TelescopeBorder = { fg = theme.ui.fg, bg = 'none' },
            TelescopeNormal = { fg = theme.ui.fg, bg = 'none' },
            TelescopeTitle = { fg = theme.ui.fg, bg = 'none' },

            TelescopePromptBorder = { fg = theme.ui.fg, bg = 'none' },
            TelescopePromptCounter = { fg = theme.ui.fg, bg = 'none' },
            TelescopePromptNormal = { fg = theme.ui.fg, bg = 'none' },
            TelescopePromptPrefix = { fg = theme.ui.fg, bg = 'none' },
            TelescopePromptTitle = { fg = theme.ui.fg, bg = 'none' },

            TelescopeResultsBorder = { fg = theme.ui.fg, bg = 'none' },
            TelescopeResultsNormal = { fg = theme.ui.fg, bg = 'none' },
            TelescopeResultsTitle = { fg = theme.ui.fg, bg = 'none' },

            TelescopePreviewBorder = { fg = theme.ui.fg, bg = 'none' },
            TelescopePreviewNormal = { fg = theme.ui.fg, bg = 'none' },
            TelescopePreviewTitle = { fg = theme.ui.fg, bg = 'none' },

            -- Noice
            NoicePopupmenuBorder = { fg = theme.ui.fg, bg = 'none' },

            -- Glance Preview
            GlancePreviewNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            GlancePreviewMatch = { fg = theme.ui.fg_reverse, bg = theme.vcs.changed },

            -- Glance List
            GlanceListCount = { fg = theme.syn.regex, bg = 'none' },
            GlanceListFilename = { fg = theme.syn.string, bg = 'none' },
            GlanceListMatch = { fg = theme.ui.fg_reverse, bg = theme.vcs.changed },
            GlanceListNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m2 },
            glanceListFilepath = { fg = theme.syn.type, bg = 'none' },

            -- Glance Preview
            GlanceWinbarFilename = { fg = theme.syn.string, bg = theme.ui.bg_m3 },
            GlanceWinbarFilepath = { fg = theme.syn.type, bg = theme.ui.bg_m3 },
            GlanceWinBarTitle = { fg = theme.syn.special1, bg = theme.ui.bg_m3 },

            IlluminatedWordText = { fg = 'none', bg = theme.ui.bg_p2 },
            IlluminatedWordRead = { fg = 'none', bg = theme.ui.bg_p2 },
            IlluminatedWordWrite = { fg = 'none', bg = theme.ui.bg_p2 },

            ModesCopy = { fg = 'none', bg = theme.diag.warning },
            ModesInsert = { fg = 'none', bg = theme.diag.ok },
            ModesDelete = { fg = 'none', bg = theme.diag.error },
          }
        end,
      }
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}
