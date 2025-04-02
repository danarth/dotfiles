local package = require('core.pack').package

package('mfussenegger/nvim-dap')

package({
  'mfussenegger/nvim-dap-python',
  dependencies = 'mfussenegger/nvim-dap',
})

package({
  'mxsdev/nvim-dap-vscode-js',
  dependencies = 'mfussenegger/nvim-dap',
})

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
  dependencies = 'mfussenegger/nvim-dap',
  config = function()
    require('nvim-dap-repl-highlights').setup()
  end,
})

package({
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('dapui').setup()
  end,
})
