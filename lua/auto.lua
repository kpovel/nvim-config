local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

vim.api.nvim_exec2([[
    autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us
]], {})

vim.cmd([[autocmd BufEnter * set formatoptions-=o]])

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group =  augroup("TheGroup", {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
