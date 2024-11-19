local keymap = require('core.keymap')
local nmap, cmd = keymap.nmap, keymap.cmd

local config = {}

function config.kitty_navigator()
  vim.g.kitty_navigator_no_mappings = 1
  nmap({
    { '<c-j>', cmd('KittyNavigateDown') },
    { '<c-h>', cmd('KittyNavigateLeft') },
    { '<c-l>', cmd('KittyNavigateRight') },
    { '<c-k>', cmd('KittyNavigateUp') },
  })
end

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
