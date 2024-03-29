local package = require('core.pack').package
local conf = require('modules.editor.config')

package('tpope/vim-commentary')
package('tpope/vim-surround')
package('tpope/vim-abolish')

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
  'simrat39/symbols-outline.nvim',
  config = function()
    require('symbols-outline').setup({})
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
