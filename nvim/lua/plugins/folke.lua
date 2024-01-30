return {
  { 'folke/which-key.nvim', opts = {} },
  { 'folke/twilight.nvim' },
  {
    'koenverburg/peepsight.nvim',
    config = function()
      require('peepsight').setup {
        -- go
        'function_declaration',
        'method_declaration',
        'func_literal',

        -- typescript
        'class_declaration',
        'method_definition',
        'arrow_function',
        'function_declaration',
        'generator_function_declaration',
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    -- stylua: ignore
    keys = {
      {
        "<leader>j",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash"
      },
      {
        "<M-v>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash"
      },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
    },
  },
}
