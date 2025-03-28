local package = require('core.pack').package
local conf = require('modules.editor.config')

package('tpope/vim-commentary')
package('tpope/vim-surround')
package('tpope/vim-abolish')

package({
  'pteroctopus/faster.nvim',
  opts = {
    behaviours = {
      bigfile = {
        on = true,
        extra_patterns = {
          { filesize = 0.3, pattern = '*.json' }
        },
      }
    }
  }
})

package({
  'dhruvasagar/vim-table-mode',
  config = function ()
    vim.g.table_mode_corner = '-'
    vim.g.table_mode_disable_mappings = 1
    vim.g.table_mode_disable_tableize_mappings = 1
  end
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
        enable = true
      },
    })
  end,
})

package({
  'yamatsum/nvim-cursorline',
  config = function ()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      }
    }
  end
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

package('monaqa/dial.nvim')

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
  opts = {},
})
