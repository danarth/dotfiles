local helper = require('core.helper')
local api = vim.api

-- Highlight yanked text
local highlight_yank = api.nvim_create_augroup('highlight_yank', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
  group = highlight_yank,
  command = "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=300})",
})

-- Load local .nvim.lua configuration file when nvim dir is changed
local exrc = api.nvim_create_augroup('exrc', { clear = true })
api.nvim_create_autocmd('DirChanged', {
  group = exrc,
  callback = function()
    local config_file = helper.path_join(vim.fn.getcwd(), '.nvim.lua')
    local is_secure = vim.secure.read(config_file)
    if is_secure then
      vim.cmd.source(config_file)
    end
  end,
})

local git_msg = api.nvim_create_augroup('git_msg', { clear = true })
api.nvim_create_autocmd('FileType', {
  group = git_msg,
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
  callback = function()
    vim.opt_local.bufhidden = 'delete'
  end,
})

-- Yank ring implementation
local function yank_shift()
  for i = 9, 1, -1 do
    vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
  end
end

local yank_ring = api.nvim_create_augroup('yank_ring', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_ring,
  callback = function()
    local event = vim.v.event
    if event.operator == 'y' then
      yank_shift()
    end
  end,
})
