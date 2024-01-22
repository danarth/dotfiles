local keymap = require('core.keymap')

local treesj = require('treesj')

keymap.nmap({
  {
    "gJ", treesj.join
  },
  {
    "gS", treesj.split
  }
})
