require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({"eex", "elixir", "erlang", "heex", "html", "surface", "diff"})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    local max_filesize = 200 * 1024
    local size = vim.api.nvim_buf_get_offset(ev.buf, vim.api.nvim_buf_line_count(ev.buf))
    if size > max_filesize then
      vim.treesitter.stop(ev.buf)
      return
    end

    pcall(vim.treesitter.start, ev.buf)
  end,
})
