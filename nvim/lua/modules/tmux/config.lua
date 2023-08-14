local keymap = require('core.keymap')
local nmap, cmd = keymap.nmap, keymap.cmd

local config = {}

function config.tmux_navigator()
  nmap({
    { '<c-j>', cmd('TmuxNavigateDown') },
    { '<c-h>', cmd('TmuxNavigateLeft') },
    { '<c-l>', cmd('TmuxNavigateRight') },
    { '<c-k>', cmd('TmuxNavigateUp') },
  })
end

function config.vimux()
  vim.g.VimuxHeight = 20
end

return config
