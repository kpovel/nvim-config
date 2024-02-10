local apm = require("vim-apm")

apm:setup({})
vim.keymap.set("n", "<leader>m", function() apm:toggle_monitor() end)
