local keymap = require('core.keymap')
local nmap = keymap.nmap
local remap = keymap.remap
local opts = keymap.new_opts

local hop = require('hop')
local directions = require('hop.hint').HintDirection

nmap({
  {
    '<leader><leader>f',
    function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR })
    end,
    opts(remap)
  },
  {
    '<leader><leader>F',
    function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR })
    end,
    opts(remap)
  },
  {
    '<leader><leader>t',
    function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
    end,
    opts(remap)
  },
  {
    '<leader><leader>T',
    function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = -1 })
    end,
    opts(remap)
  }
})
