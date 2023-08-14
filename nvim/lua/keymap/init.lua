local keymap = require('core.keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

vim.g.mapleader = ','

nmap({
  -- disable arrow keys
  { '<up>', '<nop>' },
  { '<down>', '<nop>' },
  { '<left>', '<nop>' },
  { '<right>', '<nop>' },

  -- clear line
  { 'DD', '^D' },

  -- exit editor
  { '<leader>ww', cmd('w') },
  { '<leader>wa', cmd('wa') },
  { '<leader>wq', cmd('wq') },
  { '<leader>qq', cmd('q!') },

  -- normal mode space
  { '<space>', 'i<space><esc>' },

  -- buffers
  { '<leader>bl', cmd('ls') },
  { '<leader>bq', cmd('bp|bd #') },
  { '<leader>bn', cmd('bn') },
  { '<leader>bp', cmd('bp') },
  { '<leader>bb', cmd('b #') },


  -- disable annoying help shortcut
  { '<f1>', '<nop>' },
})

-- insert mode
-- TODO why is this not working?
imap({
  { 'jk', '<esc>' },
})

-- usage of plugins
nmap({
  -- launch file tree
  { '<leader>fs', cmd('NvimTreeToggle') },

  -- Telescope
  { '<leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<leader>fg', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<leader>fh', cmd('Telescope help_tags'), opts(noremap, silent) },
  { '<leader>fw', cmd('Telescope workspaces'), opts(noremap, silent) },
})
