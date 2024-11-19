local helper = require('core.helper')
local package = require('core.pack').package
local conf = require('modules.tmux.config')

if helper.is_tmux_session() then
  package({ 'christoomey/vim-tmux-navigator', config = conf.tmux_navigator })

  package({ 'preservim/vimux', config = conf.vimux })
end

if helper.is_kitty_session() and not helper.is_tmux_session() then
  package({ 'knubie/vim-kitty-navigator', config = conf.kitty_navigator })
end
