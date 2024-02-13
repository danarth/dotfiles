local helper = require('core.helper')
local api = vim.api

-- Highlight yanked text
local highlight_yank = api.nvim_create_augroup("highlight_yank", { clear = true})
api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  command = "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=300})",
})

-- Load local .nvim.lua configuration file when nvim dir is changed
local exrc = api.nvim_create_augroup("exrc", { clear = true})
api.nvim_create_autocmd("DirChanged", {
  group = exrc,
  callback = function()
    local config_file = helper.path_join(vim.fn.getcwd(), '.nvim.lua')
    local is_secure = vim.secure.read(config_file)
    if is_secure then
      vim.cmd.source(config_file)
    end
  end
})
