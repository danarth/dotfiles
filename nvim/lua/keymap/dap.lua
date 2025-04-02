local keymap = require('core.keymap')
local nmap, tmap, vmap = keymap.nmap, keymap.tmap, keymap.vmap
local silent, noremap = keymap.silent, keymap.noremap
local cmd = keymap.cmd
local opts = keymap.new_opts
local api = vim.api

local function ts_highlight(ft)
  return function(input)
    local parser = vim.treesitter.get_string_parser(input, ft)
    local tree = parser:parse()[1]
    local query = vim.treesitter.query.get(ft, 'highlights')
    local highlights = {}
    for id, node, _ in query:iter_captures(tree:root(), input) do
      local _, cstart, _, cend = node:range()
      table.insert(highlights, { cstart, cend, '@' .. query.captures[id] })
    end
    return highlights
  end
end

local function set_conditional_breakpoint()
  vim.ui.input({
    prompt = ' Breakpoint condition:',
    default = '',
    highlight = ts_highlight(vim.bo.filetype),
  }, function(input)
    if input then
      require('dap').toggle_breakpoint(input)
    end
  end)
end

local function evaluate_expression()
  vim.ui.input({
    prompt = ' Evaluate expression:',
    default = '',
    highlight = ts_highlight(vim.bo.filetype),
  }, function(input)
    if input then
      require('dapui').eval(input)
    end
  end)
end

nmap({
  { '<leader>xr', cmd('Telescope dap configurations'), opts('Debug: Run Something', noremap, silent) },
  { '<leader>xx', cmd('DapTerminate'), opts('Debug: Terminate Session', noremap, silent) },
  { '<leader>xb', cmd('DapToggleBreakpoint'), opts('Debug: Toggle Breakpoint', noremap, silent) },
  { '<leader>xB', set_conditional_breakpoint, opts('Debug: Toggle Conditional Breakpoint', noremap, silent) },
  { '<leader>xe', evaluate_expression, opts('Debug: Evaluate Expression', noremap, silent) },
  { '<leader>xl', cmd('DapContinue'), opts('Debug: Continue', noremap, silent) },
  { '<leader>xf', cmd('DapToggleRepl'), opts('Debug: Toggle Console', noremap, silent) },
  {
    '<leader>xu',
    function()
      require('dapui').toggle()
    end,
    opts('Debug: Toggle UI', noremap, silent),
  },
})

tmap({ '<leader>xf', cmd('DapToggleRepl'), opts('Debug: Toggle Console', noremap, silent) })

vmap({
  '<leader>xe',
  function()
    require('dapui').eval()
  end,
  opts('Debug: Evaluate Selection', noremap, silent),
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
