local lsp = require("lsp-zero")

lsp.preset("recommended")
require 'lspconfig'.ocamllsp.setup {}

require "lspconfig".nextls.setup({
  cmd = { "nextls", "--stdio" },
  init_options = {
    extensions = {
      credo = { enable = true }
    },
    experimental = {
      completions = { enable = true }
    }
  }
})

require "lspconfig".tailwindcss.setup {
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          [[class= "([^"]*)]],
          [[class: "([^"]*)]],
          '~H""".*class="([^"]*)".*"""',
        },
      },
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

require 'lspconfig'.html.setup {
  capabilities = capabilities,
  filetypes = { "html", "templ", "heex" }
}

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {},
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      local lspconfig = require("lspconfig");
      lspconfig.lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.defaults.cmp_mappings({
  ["<Tab>"] = nil,
  ["<S-Tab>"] = nil,
})

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = "menu,menuone,noinsert,noselect"
  },
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
  })
})

local builtin = require("telescope.builtin")
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
  vim.keymap.set("n", "gr", builtin.lsp_references, {})
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
