local keymap = require('core.keymap')
local nmap, tmap = keymap.nmap, keymap.tmap

if vim.env.TERM == 'xterm-ghostty' then
  nmap({
    { '<c-h>', '<c-w><c-h>' },
    { '<c-j>', '<c-w><c-j>' },
    { '<c-k>', '<c-w><c-k>' },
    { '<c-l>', '<c-w><c-l>' },
  })
  tmap({
    { '<c-h>', '<c-\\><c-n><c-w><c-h>' },
    { '<c-j>', '<c-\\><c-n><c-w><c-j>' },
    { '<c-k>', '<c-\\><c-n><c-w><c-k>' },
    { '<c-l>', '<c-\\><c-n><c-w><c-l>' },
    { '<esc>', '<c-\\><c-n>' },
  })
end
