local keymap = require('core.keymap')

local treesj = require('treesj')

keymap.nmap({
  {
    'gJ',
    treesj.join,
    { desc = 'Join lines' },
  },
  {
    'gS',
    treesj.split,
    { desc = 'Split lines' },
  },
})
