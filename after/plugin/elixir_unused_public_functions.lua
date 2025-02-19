local function appendFile(content)
  local f = io.open("../refs", "a")
  assert(f)
  f:write(content .. "\n")
  f:close()
end

local function feedkeys(key, mode)
  local keys = vim.api.nvim_replace_termcodes(key, true, true, true)
  vim.api.nvim_feedkeys(keys, mode, true)
end

local function count_references()
  vim.fn.execute("cnext")

  local row, _col = unpack(vim.api.nvim_win_get_cursor(0))
  local current = vim.fn.expand("%") .. ":" .. row .. vim.api.nvim_get_current_line()

  feedkeys("_", "n")
  feedkeys("w", "n")
  vim.defer_fn(function()
    vim.lsp.buf.references(nil, {
      on_list = function(refs)
        local msg = current .. " | References: " .. #refs.items
        appendFile(msg)
      end,
    })
  end, 0)

  vim.defer_fn(function()
    count_references()
  end, 5000)
end

vim.keymap.set("n", "<leader>lr", count_references)
