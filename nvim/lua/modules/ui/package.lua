local package = require('core.pack').package
local conf = require('modules.ui.config')

package({
  'nvim-tree/nvim-web-devicons',
  opts = {}
})

package({
  'Bekaboo/dropbar.nvim',
  config = function()
    require('dropbar').setup({})
  end,
})

package({ 'EdenEast/nightfox.nvim', config = conf.nightfox })

local felineConfig = require('modules.ui.feline')

package({
  'freddiehaddad/feline.nvim',
  dependencies = {
    'EdenEast/nightfox.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = felineConfig.config,
  init = felineConfig.init,
  opts = felineConfig.opts,
})

package({
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup({})
  end,
})

package({
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim'
  },
  opts = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require('neo-tree.events')
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
  end
})

package({
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require('window-picker').setup({
      hint = 'floating-big-letter',
    })
  end,
})

package({
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({})
  end,
})

package({
  'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({ 'famiu/bufdelete.nvim' })

package('stevearc/dressing.nvim')

package({
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "[w]"
        },
        opts = { skip = true }
      }
    }
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
})
