return {
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   opts = {
  --     preview = {
  --       filetypes = { "markdown", "codecompanion" },
  --       ignore_buftypes = {},
  --     },
  --   },
  -- },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = function()
      local function conceal_tag(icon, hl_group)
        return {
          on_node = { hl_group = hl_group },
          on_closing_tag = { conceal = "" },
          on_opening_tag = {
            conceal = "",
            virt_text_pos = "inline",
            virt_text = { { icon .. " ", hl_group } },
          },
        }
      end

      return {
        html = {
          container_elements = {
            ["^buf$"] = conceal_tag("", "CodeCompanionChatVariable"),
            ["^file$"] = conceal_tag("", "CodeCompanionChatVariable"),
            ["^help$"] = conceal_tag("󰘥", "CodeCompanionChatVariable"),
            ["^image$"] = conceal_tag("", "CodeCompanionChatVariable"),
            ["^symbols$"] = conceal_tag("", "CodeCompanionChatVariable"),
            ["^url$"] = conceal_tag("󰖟", "CodeCompanionChatVariable"),
            ["^var$"] = conceal_tag("", "CodeCompanionChatVariable"),
            ["^tool$"] = conceal_tag("", "CodeCompanionChatTool"),
            ["^user_prompt$"] = conceal_tag("", "CodeCompanionChatTool"),
            ["^group$"] = conceal_tag("", "CodeCompanionChatToolGroup"),
          },
        },
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      }
    end,
  },
  {
    -- support for image pasting
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = true,
      },
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
  {
    "echasnovski/mini.diff", -- Inline and better diff over the default
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
}
