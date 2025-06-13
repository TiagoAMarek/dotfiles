return {
  "ravitemer/mcphub.nvim",
  build = "npm install -g mcp-hub@latest",
  config = function()
    local mcphub = require("mcphub")
    mcphub.setup({
      -- auto_approve = true,
      config = vim.fn.expand("/Users/tiagomarek/.config/mcphub/servers.json"),
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
    })

    mcphub.add_prompt("context", {
      name = "explain_code",
      handler = function(req, res)
        res:system():text("You are a code explanation assistant.")

        if req.caller and req.caller.type == "codecompanion" then
          local chat = req.caller.codecompanion and req.caller.codecompanion.chat or {}
          res:text("\nPrevious discussion:\n" .. (chat.history or ""))
        elseif req.caller and req.caller.type == "avante" then
          local code = req.caller.avante and req.caller.avante.code or ""
          res:text("\nSelected code:\n" .. code)
        end

        res:user():text("Explain this code"):llm():text("I'll explain the code in detail...")

        return res:send()
      end,
    })
    mcphub.add_prompt("test", {
      name = "generate_tests",
      handler = function(req, res)
        res
          :system()
          :text("@mcp You are a test generation assistant specialized in creating tests for new or modified code.")

        if req.caller and req.caller.type == "codecompanion" then
          local chat = req.caller.codecompanion and req.caller.codecompanion.chat or {}
          res:text("\nPrevious discussion:\n" .. (chat.history or ""))
        elseif req.caller and req.caller.type == "avante" then
          local code = req.caller.avante and req.caller.avante.code or ""
          res:text("\nSelected code:\n" .. code)
        else
          -- If we don't have specific code from the caller, try to get git changes
          local workspace_info = res:tool("neovim", "execute_lua", {
            code = [[
                local current_file = vim.api.nvim_buf_get_name(0)
                return "Current file: " .. current_file
              ]],
          })

          res:text("\nWorkspace context:\n" .. (workspace_info or "No workspace information available"))

          -- Get git status to identify changed files
          local git_changes = res:tool("git", "git_status", {
            repo_path = ".",
          })

          if git_changes then
            res:text("\nChanged files in repository:\n" .. git_changes)
          end
        end

        res:user():text("Generate tests for the new or changed code in context"):llm():text(
          "I'll analyze the code changes and generate appropriate tests focusing on the new or modified functionality. "
            .. "I'll consider best practices for the detected language and testing framework."
        )

        return res:send()
      end,
    })
  end,
}
