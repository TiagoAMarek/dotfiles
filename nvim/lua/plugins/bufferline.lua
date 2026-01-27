return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      always_show_bufferline = true,
      -- Increase tab width
      tab_size = 30, -- Default is 18
      max_name_length = 25, -- Default is 18
      -- Show parent directory for files with duplicate names
      name_formatter = function(buf)
        local filename = vim.fn.fnamemodify(buf.path, ":t")
        local parent = vim.fn.fnamemodify(buf.path, ":h:t")

        -- Count how many buffers have the same filename
        local same_name_count = 0
        for _, b in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
          if vim.fn.fnamemodify(b.name, ":t") == filename then
            same_name_count = same_name_count + 1
          end
        end

        -- If multiple files have same name, include parent directory
        if same_name_count > 1 and parent ~= "" and parent ~= "." then
          -- Truncate parent name if too long
          local max_parent_len = 10
          if #parent > max_parent_len then
            parent = parent:sub(1, max_parent_len - 1) .. "…"
          end
          return parent .. "/" .. filename
        end
        return filename
      end,
    },
  },
}
