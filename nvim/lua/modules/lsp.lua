local package = require('core.pack').package

local on_attach = function()
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

package({
  'neovim/nvim-lspconfig',
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.config('jsonls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('terraformls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('bashls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('vimls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('basedpyright', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('eslint', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('yamlls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('ruff', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { 'ruff', 'server' },
    })

    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim', 'Snacks' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })

    vim.lsp.config('stylua3p_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})
