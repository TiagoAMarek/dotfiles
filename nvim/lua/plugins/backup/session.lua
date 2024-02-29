return {
    "Shatur/neovim-session-manager",
    keys = {
        { "<leader>sl", "<cmd>SessionManager load_session<cr>",         desc = "Load Session" },
        { "<leader>ss", "<cmd>SessionManager save_current_session<cr>", desc = "Save Session" },
        { "<leader>sd", "<cmd>SessionManager delete_session<cr>",       desc = "Delete Session" }
    }
}
-- return {
--     "echasnovski/mini.visits",
--     keys = {
--         {
--             "<leader>sl",
--             "<cmd>lua MiniVisits.select_path()<cr>"
--         }
--     },
--     config = function()
--         require('mini.visits').setup()
--     end
--
-- }
--
-- return {
--   'gnikdroy/projections.nvim',
--   config = function()
--     require("projections").setup({
--       workspaces = {       -- Default workspaces to search for
--         { "~/projects", { ".git" } },
--         -- { "~/Documents/dev", { ".git" } },        Documents/dev is a workspace. patterns = { ".git" }
--         -- { "~/repos", {} },                        An empty pattern list indicates that all subdirectories are considered projects
--         -- "~/dev",                                  dev is a workspace. default patterns is used (specified below)
--       },
--       -- patterns = { ".git", ".svn", ".hg" },      -- Default patterns to use if none were specified. These are NOT regexps.
--       -- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
--       -- restore_hooks = { pre = nil, post = nil }, -- pre and post hooks for restore_session, callable | nil
--       -- workspaces_file = "path/to/file",          -- Path to workspaces json file
--       -- sessions_directory = "path/to/dir",        -- Directory where sessions are stored
--     })
--   end
-- }
