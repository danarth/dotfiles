local helper = require('core.helper')
local package = require('core.pack').package
local conf = require('modules.tmux.config')

package({
  'mrjones2014/smart-splits.nvim',
  config = conf.smart_splits,
})

package({ 'preservim/vimux', config = conf.vimux })
