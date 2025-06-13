return {
  "fang2hou/blink-copilot",
  "saghen/blink.compat",
  -- {
  --   "saghen/blink.cmp",
  --   version = not vim.g.lazyvim_blink_main and "*",
  --   build = vim.g.lazyvim_blink_main and "cargo build --release",
  --   opts_extend = {
  --     "sources.completion.enabled_providers",
  --     "sources.compat",
  --     "sources.default",
  --   },
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     --     "fang2hou/blink-copilot",
  --     -- add blink.compat to dependencies
  --     {
  --       "saghen/blink.compat",
  --       optional = true, -- make optional so it's only enabled if any extras need it
  --       opts = {},
  --       version = not vim.g.lazyvim_blink_main and "*",
  --     },
  --   },
  --   event = "InsertEnter",
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     snippets = {
  --       expand = function(snippet, _)
  --         return LazyVim.cmp.expand(snippet)
  --       end,
  --     },
  --     appearance = {
  --       -- sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release, assuming themes add support
  --       use_nvim_cmp_as_default = false,
  --       -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = "mono",
  --     },
  --     completion = {
  --       accept = {
  --         -- experimental auto-brackets support
  --         auto_brackets = {
  --           enabled = true,
  --         },
  --       },
  --       menu = {
  --         draw = {
  --           treesitter = { "lsp" },
  --         },
  --       },
  --       documentation = {
  --         auto_show = true,
  --         auto_show_delay_ms = 200,
  --       },
  --       ghost_text = {
  --         enabled = vim.g.ai_cmp,
  --       },
  --     },
  --
  --     -- experimental signature help support
  --     -- signature = { enabled = true },
  --
  --     sources = {
  --       -- adding any nvim-cmp sources here will enable them
  --       -- with blink.compat
  --       compat = {
  --         "avante_commands",
  --         "avante_mentions",
  --         "avante_files",
  --       },
  --       default = { "copilot", "lsp", "path", "snippets", "buffer" },
  --       copilot = {
  --         name = "copilot",
  --         module = "blink-copilot",
  --         score_offset = 100,
  --         async = true,
  --       },
  --     },
  --
  --     cmdline = {
  --       enabled = false,
  --     },
  --
  --     keymap = {
  --       preset = "enter",
  --       ["<C-y>"] = { "select_and_accept" },
  --     },
  --   },
  --   ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  --   config = function(_, opts)
  --     -- setup compat sources
  --     local enabled = opts.sources.default
  --     for _, source in ipairs(opts.sources.compat or {}) do
  --       opts.sources.providers[source] = vim.tbl_deep_extend(
  --         "force",
  --         { name = source, module = "blink.compat.source" },
  --         opts.sources.providers[source] or {}
  --       )
  --       if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
  --         table.insert(enabled, source)
  --       end
  --     end
  --
  --     -- add ai_accept to <Tab> key
  --     if not opts.keymap["<Tab>"] then
  --       if opts.keymap.preset == "super-tab" then -- super-tab
  --         opts.keymap["<Tab>"] = {
  --           require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
  --           LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
  --           "fallback",
  --         }
  --       else -- other presets
  --         opts.keymap["<Tab>"] = {
  --           LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
  --           "fallback",
  --         }
  --       end
  --     end
  --
  --     -- Unset custom prop to pass blink.cmp validation
  --     opts.sources.compat = nil
  --
  --     -- check if we need to override symbol kinds
  --     for _, provider in pairs(opts.sources.providers or {}) do
  --       ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
  --       if provider.kind then
  --         local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
  --         local kind_idx = #CompletionItemKind + 1
  --
  --         CompletionItemKind[kind_idx] = provider.kind
  --         ---@diagnostic disable-next-line: no-unknown
  --         CompletionItemKind[provider.kind] = kind_idx
  --
  --         ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
  --         local transform_items = provider.transform_items
  --         ---@param ctx blink.cmp.Context
  --         ---@param items blink.cmp.CompletionItem[]
  --         provider.transform_items = function(ctx, items)
  --           items = transform_items and transform_items(ctx, items) or items
  --           for _, item in ipairs(items) do
  --             item.kind = kind_idx or item.kind
  --             item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
  --           end
  --           return items
  --         end
  --
  --         -- Unset custom prop to pass blink.cmp validation
  --         provider.kind = nil
  --       end
  --     end
  --
  --     require("blink.cmp").setup(opts)
  --   end,
  -- },
  "Kaiser-Yang/blink-cmp-avante",
  "xzbdmw/colorful-menu.nvim",
  {
    "saghen/blink.cmp",
    dependencies = {
      "fang2hou/blink-copilot",
      "Kaiser-Yang/blink-cmp-avante",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- in your blink configuration
      keymap = {
        preset = "enter",
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
      },
      completion = {
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 3 } },
            components = {
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
          },
        },
        list = { selection = { preselect = false } },
      },
      sources = {
        default = { "copilot", "avante" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },
    },
  },
}

-- return {
--   "saghen/blink.cmp",
--   dependencies = {
--     "fang2hou/blink-copilot",
--   },
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     -- in your blink configuration
--     keymap = {
--       preset = "enter",
--     },
--     completion = {
--       list = { selection = { preselect = false } },
--     },
--     sources = {
--       -- Add 'avante' to the list
--       compat = {
--         "avante_commands",
--         "avante_mentions",
--         "avante_files",
--       },
--       default = { "copilot" },
--       providers = {
--         copilot = {
--           name = "copilot",
--           module = "blink-copilot",
--           score_offset = 100,
--           async = true,
--         },
--       },
--     },
--   },
-- }
