local package = require('core.pack').package
local conf = require('modules.editor.config')

package('tpope/vim-commentary')
package('tpope/vim-abolish')

package({
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup()
  end,
})

package({
  'dhruvasagar/vim-table-mode',
  config = function()
    vim.g.table_mode_corner = '-'
    vim.g.table_mode_disable_mappings = 1
    vim.g.table_mode_disable_tableize_mappings = 1
  end,
})

package({
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup({
      chunk = {
        enable = true,
      },
      line_num = {
        enable = true,
      },
    })
  end,
})

package({
  'yamatsum/nvim-cursorline',
  config = function()
    require('nvim-cursorline').setup({
      cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
    })
  end,
})

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
  },
})

package({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup({})
  end,
})

package({
  'm-demare/hlargs.nvim',
  config = function()
    require('hlargs').setup({})
  end,
})

package({
  'smoka7/hop.nvim',
  config = function()
    require('hop').setup({})
  end,
})

package({
  'monaqa/dial.nvim',
  config = function()
    local augend = require('dial.augend')
    require('dial.config').augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%Y-%m-%d'],
        augend.date.alias['%m/%d'],
        augend.date.alias['%H:%M'],
        augend.constant.alias.bool,
      },
    })
  end,
})

package({
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = true,
})

package({
  'Wansmer/treesj',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('treesj').setup()
  end,
})

package('unblevable/quick-scope')

package({
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        sql = { 'pg_format' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
    })
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
})
