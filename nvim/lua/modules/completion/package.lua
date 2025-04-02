local package = require('core.pack').package
local conf = require('modules.completion.config')

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
  config = conf.nvim_lsp,
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
    vim.cmd([[
      augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require('modules.completion.jdtls').setup()
      augroup end
    ]])
  end,
})

-- package({
--   'danarth/sonarlint.nvim',
--   config = conf.sonarqube,
-- })

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    { 'chrisgrieser/cmp-nerdfont' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' },
    { 'rcarriga/cmp-dap' }
  },
})

package({
  'L3MON4D3/LuaSnip',
  version = "v2.*",
  build = "make install_jsregexp",
  event = 'InsertCharPre',
  config = conf.lua_snip,
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
  },
})
