require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "c", "lua", "rust", "go" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },
}

function Dif()
    local ts = require('nvim-treesitter.ts_utils')

    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the node at the cursor position
    local node = ts.get_node_at_cursor()

    -- Find the nearest ancestor function node
    while node do
        if node:type() == 'function_declaration' or node:type() == 'arrow_function' then
            break
        end
        node = node:parent()
    end

    -- If a function node is found, delete it
    if node then
        local start_row, _, end_row, _ = node:range()
        vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, false, {})
    else
        print('No function found under cursor')
    end
end

vim.api.nvim_set_keymap('n', 'dif', ':lua Dif()<CR>', { noremap = true, silent = true })

function Daf()
    local ts = require('nvim-treesitter.ts_utils')

    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the node at the cursor position
    local node = ts.get_node_at_cursor()


    -- Find the nearest ancestor function node
    while node do
        if node:type() == 'function_declaration' or node:type() == 'arrow_function' then
            break
        end
        node = node:parent()
    end


    if node then
        local delete_start, _, delete_end, _ = node:range()
        local prev_node = ts.get_previous_node(node, true, true);
        local next_node = ts.get_next_node(node, true, true);

        if prev_node then
          local _, _, prev_node_end, _ = prev_node:range();
          delete_start = prev_node_end + 1;
        end

        if next_node then
          local next_node_start, _, _, _ = next_node:range();
          delete_end = next_node_start - 2;
        end

        print(delete_start, delete_end);
        vim.api.nvim_buf_set_lines(bufnr, delete_start, delete_end + 1, false, {})
    else
        print('No function found under cursor')
    end
end

vim.api.nvim_set_keymap('n', 'daf', ':lua Daf()<CR>', { noremap = true, silent = true })

