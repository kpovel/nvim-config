require('tokyonight').setup({
  style = "moon",
  transparent = true,
  terminal_colors = true,
  italic_comments = true,
})

vim.cmd.colorscheme('tokyonight')

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
