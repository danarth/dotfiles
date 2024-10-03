local package = require('core.pack').package

package('mfussenegger/nvim-dap')

package('mfussenegger/nvim-dap-python')

package({
  'theHamsta/nvim-dap-virtual-text',
  dependencies = 'mfussenegger/nvim-dap',
  config = function()
    require('nvim-dap-virtual-text').setup()
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'ErrorMsg' })
    vim.fn.sign_define('DapLogPoint', { text = '󰋽' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'ErrorMsg' })
    vim.fn.sign_define(
      'DapStopped',
      { text = '󰁔', texthl = '@comment.note', linehl = '@comment.note', numhl = '@comment.note' }
    )
  end,
})

package({
  'LiadOz/nvim-dap-repl-highlights',
  config = function()
    require('nvim-dap-repl-highlights').setup()
  end,
})

package({
  'rcarriga/nvim-dap-ui',
  dependencies = 'mfussenegger/nvim-dap',
})
