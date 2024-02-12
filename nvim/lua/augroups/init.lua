local api = vim.api

local highlight_yank = api.nvim_create_augroup("highlight_yank", { clear = true})
api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  command = "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=300})",
})

