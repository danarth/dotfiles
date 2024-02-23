local package = require('core.pack').package

package({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({})
  end,
})

package({
  'akinsho/git-conflict.nvim',
  config = function()
    require('git-conflict').setup({})
  end,
})
