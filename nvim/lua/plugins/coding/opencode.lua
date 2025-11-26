---@type NvPluginSpec
-- NOTE:  Opencode

return {
  "sudo-tee/opencode.nvim",
  event = "VeryLazy",
  opts = {
    ui = {
      input = {
        text = {
          wrap = true, -- Wraps text inside input window
        },
      },
    },
    keymap = {
      editor = {
        ["<leader>og"] = { "toggle", desc = "Toggle Opencode" },
        ["<leader>oi"] = { "open_input", desc = "Open input window in insert mode" },
        ["<leader>oI"] = { "open_input_new_session", desc = "Open input window and create new session" },
        ["<leader>oo"] = { "open_output", desc = "Open output window" },
        ["<leader>ot"] = { "toggle_focus", desc = "Toggle focus between Opencode and last window" },
        ["<leader>oq"] = { "close", desc = "Close UI windows" },
        ["<leader>os"] = { "select_session", desc = "Select and load Opencode session" },
        ["<leader>op"] = { "configure_provider", desc = "Configure provider and model" },
        ["<leader>od"] = { "diff_open", desc = "Open diff view of modified files" },
        ["<leader>o]"] = { "diff_next", desc = "Navigate to next file diff" },
        ["<leader>o["] = { "diff_prev", desc = "Navigate to previous file diff" },
        ["<leader>oc"] = { "diff_close", desc = "Close diff view" },
        ["<leader>ora"] = { "diff_revert_all_last_prompt", desc = "Revert all files since last prompt" },
        ["<leader>ort"] = { "diff_revert_this_last_prompt", desc = "Revert current file since last prompt" },
        ["<leader>orA"] = { "diff_revert_all", desc = "Revert all files since last session" },
        ["<leader>orT"] = { "diff_revert_this", desc = "Revert current file since last session" },
        ["<leader>orr"] = { "diff_restore_snapshot_file", desc = "Restore file to restore point" },
        ["<leader>orR"] = { "diff_restore_snapshot_all", desc = "Restore all files to restore point" },
        ["<leader>ox"] = { "swap_position", desc = "Swap Opencode pane position" },
        ["<leader>opa"] = { "permission_accept", desc = "Accept permission request" },
        ["<leader>opA"] = { "permission_accept_all", desc = "Accept all permissions" },
        ["<leader>opd"] = { "permission_deny", desc = "Deny permission request" },
      },
      input_window = {
        ["<cr>"] = { "submit_input_prompt", mode = { "n", "i" }, desc = "Submit prompt" },
        ["<esc>"] = { "close", desc = "Close UI windows" },
        ["<C-c>"] = { "cancel", desc = "Cancel Opencode request" },
        ["~"] = { "mention_file", mode = "i", desc = "Mention file in context" },
        ["@"] = { "mention", mode = "i", desc = "Insert mention (file/agent)" },
        ["/"] = { "slash_commands", mode = "i", desc = "Pick slash command" },
        ["<tab>"] = { "toggle_pane", mode = { "n", "i" }, desc = "Toggle between input and output panes" },
        ["<up>"] = { "prev_prompt_history", mode = { "n", "i" }, desc = "Previous prompt in history" },
        ["<down>"] = { "next_prompt_history", mode = { "n", "i" }, desc = "Next prompt in history" },
        ["<M-m>"] = { "switch_mode", desc = "Switch between modes (build/plan)" },
      },
      output_window = {
        ["<esc>"] = { "close", desc = "Close UI windows" },
        ["<C-c>"] = { "cancel", desc = "Cancel Opencode request" },
        ["]]"] = { "next_message", desc = "Next message in conversation" },
        ["[["] = { "prev_message", desc = "Previous message in conversation" },
        ["<tab>"] = { "toggle_pane", mode = { "n", "i" }, desc = "Toggle between input and output panes" },
        ["i"] = { "focus_input", "n", desc = "Focus input window" },
        ["<leader>oS"] = { "select_child_session", desc = "Select and load child session" },
        ["<leader>oD"] = { "debug_message", desc = "Debug message in new buffer" },
        ["<leader>oO"] = { "debug_output", desc = "Debug output in new buffer" },
        ["<leader>ods"] = { "debug_session", desc = "Debug session in new buffer" },
      },
    },
  },
}
-- return {
--   "cousine/opencode-context.nvim",
--   opts = {
--     tmux_target = nil, -- Manual override: "session:window.pane"
--     auto_detect_pane = true, -- Auto-detect opencode pane in current window
--   },
--   keys = {
--     { "<leader>aoc", "<cmd>OpencodeSend<cr>", desc = "Send prompt to opencode" },
--     { "<leader>aoc", "<cmd>OpencodeSend<cr>", mode = "v", desc = "Send prompt to opencode" },
--     { "<leader>aot", "<cmd>OpencodeSwitchMode<cr>", desc = "Toggle opencode mode" },
--     { "<leader>aop", "<cmd>OpencodePrompt<cr>", desc = "Open opencode persistent prompt" },
--   },
--   cmd = { "OpencodeSend", "OpencodeSwitchMode" },
-- }
