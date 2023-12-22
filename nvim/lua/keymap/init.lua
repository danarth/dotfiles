local keymap = require('core.keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap, remap = keymap.silent, keymap.noremap, keymap.remap
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

  -- LSP
  { '<leader>ce', vim.diagnostic.goto_next, opts(silent, noremap) },
  { '<leader>cE', vim.diagnostic.goto_prev, opts(silent, noremap) },
  { '<leader>ca', vim.lsp.buf.code_action, opts(silent, noremap) },
  { '<leader>rr', vim.lsp.buf.rename, opts(silent, noremap) },
  { '<leader>ii', vim.lsp.buf.hover, opts(silent, noremap) },
  { '<leader>==', vim.lsp.buf.format, opts(silent, noremap) }
})

-- insert mode
imap({ 'jk', '<esc>' })

local hop = require('hop')
local directions = require('hop.hint').HintDirection
local telescope_builtin = require('telescope.builtin')


-- usage of plugins
nmap({
  -- launch file tree
  { '<leader>fs', cmd('NvimTreeToggle') },

  -- Telescope
  { '<leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<leader>fg', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<leader>fr', cmd('Telescope registers'), opts(noremap, silent) },
  { '<leader>fh', cmd('Telescope help_tags'), opts(noremap, silent) },
  { '<leader>fw', cmd('Telescope workspaces'), opts(noremap, silent) },

  -- Telescope LSP
  { '<leader>gu', telescope_builtin.lsp_references, opts(noremap, silent) },
  { '<leader>gi', telescope_builtin.lsp_implementations, opts(noremap, silent) },
  { '<leader>gd', telescope_builtin.lsp_definitions, opts(noremap, silent) },

  -- Hop
  {
    '<leader><leader>f',
    function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR })
    end,
    opts(remap)
  },
  {
    '<leader><leader>F',
    function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR })
    end,
    opts(remap)
  },
  {
    '<leader><leader>t',
    function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
    end,
    opts(remap)
  },
  {
    '<leader><leader>T',
    function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = -1 })
    end,
    opts(remap)
  },
})
