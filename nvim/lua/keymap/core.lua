local keymap = require('core.keymap')
local nmap, imap, vmap = keymap.nmap, keymap.imap, keymap.vmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

nmap({
  -- disable arrow keys
  { '<up>', '<nop>' },
  { '<down>', '<nop>' },
  { '<left>', '<nop>' },
  { '<right>', '<nop>' },

  -- exit editor
  { '<leader>ww', cmd('w') },
  { '<leader>wa', cmd('wa') },
  { '<leader>wq', cmd('wq') },
  { '<leader>qq', cmd('q!') },

  -- normal mode space
  { '<space>', 'i<space><esc>' },

  -- buffers
  { '<leader>bl', cmd('ls'), { desc = 'List all buffers' } },
  { '<leader>bq', cmd('Bdelete'), { desc = 'Close current buffer' } },
  { '<leader>bQ', cmd('BufferLineCloseOthers'), { desc = 'Close all buffers except current' } },
  { '<leader>bn', cmd('bn'), { desc = 'Goto next buffer' } },
  { '<leader>bp', cmd('bp'), { desc = 'Goto previous buffer' } },
  { '<leader>bb', cmd('b #'), { desc = 'Switch to previous buffer' } },
  { '<leader>bP' , cmd('BufferLinePick'), { desc = 'Pick buffer' } },

  -- disable annoying help shortcut
  { '<f1>', '<nop>' },

  -- LSP
  { '<leader>ce', vim.diagnostic.goto_next, opts(silent, noremap) },
  { '<leader>cE', vim.diagnostic.goto_prev, opts(silent, noremap) },
  { '<leader>cg', cmd('Gitsigns next_hunk'), opts(silent, noremap) },
  { '<leader>cG', cmd('Gitsigns prev_hunk'), opts(silent, noremap) },
  { '<leader>ca', vim.lsp.buf.code_action, opts(silent, noremap) },
  { '<leader>rr', vim.lsp.buf.rename, opts(silent, noremap) },
  { '<leader>ii', vim.lsp.buf.hover, opts(silent, noremap) },
  { '<leader>==', vim.lsp.buf.format, opts(silent, noremap) },
})

-- insert mode
imap({ 'jk', '<esc>' })

vmap({ '<leader>yl', cmd('RepoLink!'), { desc = 'Copy repository link' } })
