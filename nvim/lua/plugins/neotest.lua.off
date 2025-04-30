return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    'thenbe/neotest-playwright',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup({

      adapters = {
        require('neotest-playwright').adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        }),
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
  keys = {
    { "<leader>t",  "",                                                                                 desc = "+test" },
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary (Neotest)" },
    { "<leader>to", "<CMD>Neotest output-panel<CR>", desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 desc = "Toggle Watch (Neotest)" },
  },
}
