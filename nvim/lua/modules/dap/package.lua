local package = require('core.pack').package

package('mfussenegger/nvim-dap')

package('mfussenegger/nvim-dap-python')

package({
  'rcarriga/nvim-dap-ui',
  dependencies = 'mfussenegger/nvim-dap'
})
