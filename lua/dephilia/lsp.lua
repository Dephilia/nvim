-- (c) 2026 Dephilia
-- MIT license (See LICENSE for details)

require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'clangd',
    'rust_analyzer',
    'bashls',
    'html',
    'ts_ls',
    'ruff',
  },
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- Brew-installed; mason-lspconfig only auto-enables mason packages.
vim.lsp.enable({ 'ruff', 'ty' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('dephilia_lsp', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end

    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, ev.buf)
    end

    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    local function bufmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    bufmap('n', 'gD', vim.lsp.buf.declaration, 'LSP declaration')
    bufmap('n', 'gd', vim.lsp.buf.definition, 'LSP definition')
    bufmap('n', 'K', vim.lsp.buf.hover, 'LSP hover')
    bufmap('n', 'gi', vim.lsp.buf.implementation, 'LSP implementation')
    bufmap('n', '<C-k>', vim.lsp.buf.signature_help, 'LSP signature')
    bufmap('n', '<space>D', vim.lsp.buf.type_definition, 'LSP type definition')
    bufmap('n', '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, 'LSP format')
    bufmap('x', '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, 'LSP format range')
    bufmap('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP code action')
    bufmap('n', '<leader>rn', vim.lsp.buf.rename, 'LSP rename')
  end,
})
