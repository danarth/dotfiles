local package = require('core.pack').package

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
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.config').setup({
      autotag = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['as'] = '@statement.outer',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',
            ['=h'] = '@assignment.lhs',
            ['=l'] = '@assignment.rhs',
            ['a='] = '@assignment.outer',
            ['i='] = '@assignment.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>sa'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>sA'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']c'] = '@class.outer',
            [']l'] = '@loop.outer',
            [']i'] = '@conditional.outer',
            [']r'] = '@return.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']C'] = '@class.outer',
            [']L'] = '@loop.outer',
            [']I'] = '@conditional.outer',
            [']R'] = '@return.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[l'] = '@loop.outer',
            ['[i'] = '@conditional.outer',
            ['[r'] = '@return.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[L'] = '@loop.outer',
            ['[I'] = '@conditional.outer',
            ['[R'] = '@return.outer',
          },
        },
      },
    })
  end,
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
