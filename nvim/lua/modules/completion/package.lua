local package = require('core.pack').package
local conf = require('modules.completion.config')

package({
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup{}
  end
})

package({
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup{
      automatic_installation = false
    }
  end
})

package({
  'jay-babu/mason-null-ls.nvim',
  config = function()
    require('mason-null-ls').setup{
      automatic_installation = false,
      automatic_setup = true,
    }
  end
})

package({
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup{
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.sqlfluff,
      }
    }
  end
})

package({
  'neovim/nvim-lspconfig',
  config = conf.nvim_lsp,
})

package({
  'danarth/sonarlint.nvim',
  config = conf.sonarqube,
})

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
  },
})

package({
  'L3MON4D3/LuaSnip',
  event = 'InsertCharPre',
  config = conf.lua_snip
})
