local builtin = require('telescope.builtin')
local telescope_actions = require "telescope.actions"

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set('n', 'td', builtin.lsp_type_definitions, {})
vim.keymap.set('n', '<leader>wd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, {})


require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-s>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist
      }
    }
  }
}
