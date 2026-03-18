local helper = require('core.helper')
local package = require('core.pack').package
local keymap = require('core.keymap')
local nmap, tmap, cmd = keymap.nmap, keymap.tmap, keymap.cmd

package({
  'mrjones2014/smart-splits.nvim',
  config = function()
    local smart_splits = require('smart-splits')
    smart_splits.setup({
      ignored_filetypes = {
        'neo-tree',
      },
    })

    nmap({
      { '<c-h>', smart_splits.move_cursor_left },
      { '<c-j>', smart_splits.move_cursor_down },
      { '<c-k>', smart_splits.move_cursor_up },
      { '<c-l>', smart_splits.move_cursor_right },
    })
    tmap({
      { '<c-h>', smart_splits.move_cursor_left },
      { '<c-j>', smart_splits.move_cursor_down },
      { '<c-k>', smart_splits.move_cursor_up },
      { '<c-l>', smart_splits.move_cursor_right },
    })

    nmap({
      { '<m-h>', smart_splits.resize_left },
      { '<m-j>', smart_splits.resize_down },
      { '<m-k>', smart_splits.resize_up },
      { '<m-l>', smart_splits.resize_right },
    })
  end,
})

package({
  'preservim/vimux',
  config = function()
    vim.g.VimuxHeight = 20
  end,
})
