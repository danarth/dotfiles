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

-- Feline repo has gone - this is a first pass at recreating
-- the functionality with lualine
local lualineConfig = require('modules.ui.lualine')
package({
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'EdenEast/nightfox.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = lualineConfig
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
  end,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
      end
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

package({
  'folke/edgy.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      right = { size = 70 },
    },
    left = {
      {
        title = "󰙅 File Explorer",
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'filesystem'
        end,
        pinned = true,
        size = { height = 0.5 },
        open = 'Neotree position=left filesystem'
      },
      {
        title = ' Git Changes',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'git_status'
        end,
        pinned = true,
        collapsed = false,
        open = "Neotree position=right git_status"
      },
      {
        title = ' Buffers',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'buffers'
        end,
        pinned = true,
        collapsed = true,
        open = "Neotree position=top buffers"
      },
      -- any other neo-tree windows
      'neo-tree'
    },
    right = {
      {
        title = ' Copilot',
        ft = 'copilot-chat',
        open = "CopilotChat"
      }
    },
    bottom = {
      {
        ft = 'snacks_terminal',
        size = { height = 0.4 },
        title = " %{b:snacks_terminal.id}: %{b:term_title}",
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == 'bottom'
            and vim.w[win].snacks_win.relative == 'editor'
            and not vim.w[win].trouble_preview
        end
      }
    }
  }
})
