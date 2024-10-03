local config = {}

local on_attach = function()
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

function config.nvim_lsp()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.terraformls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.vimls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.basedpyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.powershell_es.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    bundle_path = vim.fn.expand('$MASON/packages/powershell-editor-services'),
  })

  lspconfig.omnisharp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { vim.fn.expand('$MASON/packages/omnisharp/omnisharp') },
  })

  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig.lua_ls.setup({
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
          globals = { 'vim' },
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
end

-- function config.sonarqube()
--   require('sonarlint').setup({
--     server = {
--       on_attach = on_attach,
--       cmd = {
--         'sonarlint-language-server',
--         '-stdio',
--         '-analyzers',
--         -- paths to the analyzers you need, using those for python and java in this example
--         vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarpython.jar'),
--         vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarjava.jar'),
--         vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarjs.jar'),
--         vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarhtml.jar'),
--         vim.fn.expand('$MASON/share/sonarlint-analyzers/sonarxml.jar'),
--       },
--     },
--     filetypes = {
--       -- Tested and working
--       'python',
--       'javascript',
--       'javascript.jsx',
--       'javascriptreact',
--       'typescript',
--       'typescript.tsx',
--       'typescriptreact',
--       'java',
--     },
--   })
-- end

function config.nvim_cmp()
  local luasnip = require('luasnip')
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nerdfont' },
      { name = 'vim-dadbod-completion' },
    },
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        options = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })

  cmp.setup({
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
          or require("cmp_dap").is_dap_buffer()
    end
  })

  cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })

end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

return config
