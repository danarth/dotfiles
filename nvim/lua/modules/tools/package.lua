local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
    'natecraddock/workspaces.nvim',
    config = conf.workspaces,
})

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
})

package({
  'glepnir/hlsearch.nvim',
  event = 'BufRead',
  config = function()
    require('hlsearch').setup()
  end,
})

package({
  "LintaoAmons/scratch.nvim",
  event = 'VimEnter',
})

