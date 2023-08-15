local is_tmux_session = require('core.helper').is_tmux_session
local package = require('core.pack').package
local conf = require('modules.tmux.config')

if is_tmux_session() then
  package({ 'christoomey/vim-tmux-navigator', config = conf.tmux_navigator })

  package({ 'preservim/vimux', config = conf.vimux })
end
