local keymap = require('core.keymap')
local nmap = keymap.nmap
local silent, noremap = keymap.silent, keymap.noremap
local cmd = keymap.cmd
local opts = keymap.new_opts

nmap({
  { '<leader>xr', cmd('Telescope dap configurations'), opts("Debug: Run Something", noremap, silent) },
  { '<leader>xx', cmd('DapTerminate'), opts("Debug: Terminate Session", noremap, silent) },
  { '<leader>xb', cmd('DapToggleBreakpoint'), opts("Debug: Toggle Breakpoint", noremap, silent) },
  { '<leader>xl', cmd('DapContinue'), opts("Debug: Continue", noremap, silent) },
  { '<leader>xf', cmd('DapToggleRepl'), opts("Debug: Toggle Console", noremap, silent) }
})
