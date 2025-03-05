local keymap = require('core.keymap')
local nmap = keymap.nmap

if vim.env.TERM == 'xterm-ghostty' then
  nmap({
    { '<c-h>', '<c-w><c-h>'},
    { '<c-j>', '<c-w><c-j>'},
    { '<c-k>', '<c-w><c-k>'},
    { '<c-l>', '<c-w><c-l>'},
  })
end
