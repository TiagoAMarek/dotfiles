return {
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
        win = {
          layout = "float",
        },
      },
    },
    keys = {
      {
        "<leader>al",
        function()
          require("sidekick.cli").send({ msg = "{line}" })
        end,
        desc = "Send Line to Sidekick",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").send({ msg = "{diagnostics}" })
        end,
        desc = "Send Diagnostics to Sidekick",
      },
      {
        "<leader>ab",
        function()
          require("sidekick.cli").send({ msg = "{buffers}" })
        end,
        desc = "Send Buffers to Sidekick",
      },
    },
  },
}
