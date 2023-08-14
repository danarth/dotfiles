local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag'
  },
})

package({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup{}
  end
})

package({
  'machakann/vim-highlightedyank',
  config = function()
    vim.g.highlightedyank_highlight_duration = 300
  end
})

package({
  'm-demare/hlargs.nvim',
  config = function()
    require('hlargs').setup{}
  end
})

package({
  'phaazon/hop.nvim',
  config = function()
    require('hop').setup{}
  end
})

package({
  'stevearc/aerial.nvim',
  dependencies = {
    'stevearc/dressing.nvim'
  },
  config = function()
    require('aerial').setup{}
  end
})
