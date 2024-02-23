local keymap = require('core.keymap')
local nmap = keymap.nmap
local silent, noremap = keymap.silent, keymap.noremap
local cmd = keymap.cmd
local opts = keymap.new_opts
local api = vim.api

nmap({
  { '<leader>xr', cmd('Telescope dap configurations'), opts('Debug: Run Something', noremap, silent) },
  { '<leader>xx', cmd('DapTerminate'), opts('Debug: Terminate Session', noremap, silent) },
  { '<leader>xb', cmd('DapToggleBreakpoint'), opts('Debug: Toggle Breakpoint', noremap, silent) },
  { '<leader>xl', cmd('DapContinue'), opts('Debug: Continue', noremap, silent) },
  { '<leader>xf', cmd('DapToggleRepl'), opts('Debug: Toggle Console', noremap, silent) },
})

local dap_python_keymap = api.nvim_create_augroup('dap_python_keymap', { clear = true })
api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  group = dap_python_keymap,
  callback = function()
    local dap_python = require('dap-python')
    nmap({
      { '<leader>xt', dap_python.test_method, opts('Debug: Nearest Test', noremap, silent) },
      { '<leader>xc', dap_python.test_class, opts('Debug: Nearest Class', noremap, silent) },
    })
  end,
})
