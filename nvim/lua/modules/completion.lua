local package = require('core.pack').package

local on_attach = function()
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

package({
  'folke/lazydev.nvim',
  ft = 'lua',
  config = function()
    require('lazydev').setup({})
  end,
})

package({
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup({})
  end,
})

package({
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup({
      automatic_installation = false,
    })
  end,
})

package({
  'jay-babu/mason-null-ls.nvim',
  config = function()
    require('mason-null-ls').setup({
      automatic_installation = false,
      automatic_setup = true,
    })
  end,
})

package({
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.sqlfluff,
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
})

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

package({
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  dependencies = {
    'williamboman/mason.nvim',
    'hrsh7th/nvim-cmp',
    'neovim/nvim-lspconfig',
  },
  config = function()
    local jdtls = require('jdtls')
    local jdtls_setup = require('jdtls.setup')

    local on_attach = function()
      jdtls_setup.add_commands()
    end

    jdtls.start_or_attach({
      on_attach = on_attach,
      cmd = { 'jdtls' },
      root_dir = jdtls_setup.find_root({ 'gradlew', '.git', 'mvnw' }),
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = 'JavaSE-1.8',
                path = '/usr/lib/jvm/java-1.8.0-amazon-corretto',
              },
              {
                name = 'JavaSE-11',
                path = '/usr/lib/jvm/java-17-openjdk-amd64',
              },
            },
          },
        },
      },
    })
  end,
})

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = function()
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
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            })
          else
            fallback()
          end
        end),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nerdfont' },
        { name = 'vim-dadbod-completion' },
        { name = 'lazydev', group_index = 0 },
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
        return vim.bo.buftype ~= 'prompt' or require('cmp_dap').is_dap_buffer()
      end,
    })

    cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
      sources = {
        { name = 'dap' },
      },
    })
  end,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    { 'chrisgrieser/cmp-nerdfont' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' },
    { 'rcarriga/cmp-dap' },
  },
})

package({
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  event = 'InsertCharPre',
  config = function()
    local luasnip = require('luasnip')
    local types = require('luasnip.util.types')
    luasnip.config.set_config({
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
  end,
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
  },
})
