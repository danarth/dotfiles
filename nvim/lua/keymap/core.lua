local keymap = require('core.keymap')
local nmap, imap, vmap, tmap = keymap.nmap, keymap.imap, keymap.vmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

nmap({
  -- disable arrow keys
  { '<up>', '<nop>' },
  { '<down>', '<nop>' },
  { '<left>', '<nop>' },
  { '<right>', '<nop>' },

  { '<C-i>', cmd('WhichKey'), { desc = 'WhichKey help' } },

  -- exit editor
  { '<leader>ww', cmd('w'), { desc = 'Write buffer' } },
  { '<leader>wa', cmd('wa'), { desc = 'Write all open buffers' } },
  { '<leader>wq', cmd('wq'), { desc = 'Write and close buffer' } },
  { '<leader>qq', cmd('q!'), { desc = 'Force close current buffer' } },

  -- normal mode space
  { '<space>', 'i<space><esc>' },

  -- buffers
  { '<leader>bl', cmd('ls'), { desc = 'List all buffers' } },
  { '<leader>bq', cmd('Bdelete'), { desc = 'Close current buffer' } },
  { '<leader>bQ', cmd('BufferLineCloseOthers'), { desc = 'Close all buffers except current' } },
  { '<leader>bn', cmd('bn'), { desc = 'Goto next buffer' } },
  { '<leader>bp', cmd('bp'), { desc = 'Goto previous buffer' } },
  { '<leader>bb', cmd('b #'), { desc = 'Switch to previous buffer' } },
  { '<leader>bP', cmd('BufferLinePick'), { desc = 'Pick buffer' } },
  { '<leader>ba', cmd('A'), { desc = 'Switch to alternate buffer' } },

  -- disable annoying help shortcut
  { '<f1>', '<nop>' },

  -- LSP
  { '<leader>ce', vim.diagnostic.goto_next, opts('Goto next diagnostic', silent, noremap) },
  { '<leader>cE', vim.diagnostic.goto_prev, opts('Goto previous diagnostic', silent, noremap) },
  { '<leader>cg', cmd('Gitsigns next_hunk'), opts('Goto next change', silent, noremap) },
  { '<leader>cG', cmd('Gitsigns prev_hunk'), opts('Goto previous change', silent, noremap) },
  { '<leader>ca', vim.lsp.buf.code_action, opts('Code actions', silent, noremap) },
  { '<leader>rr', vim.lsp.buf.rename, opts('Rename symbol', silent, noremap) },
  { '<leader>ii', vim.lsp.buf.hover, opts('Symbol information', silent, noremap) },
  { '<leader>II', vim.diagnostic.open_float, opts('Open diagnostic', silent, noremap) },
  { '<leader>==', vim.lsp.buf.format, opts('Format buffer', silent, noremap) },

  -- Toggle
  {
    '<leader>tt',
    function()
      Snacks.terminal()
    end,
    opts('Toggle terminal', silent, noremap),
  },
  { '<leader>tf', cmd('Neotree toggle'), opts('Toggle file explorer', silent, noremap) },
  { '<leader>tF', cmd('Neotree reveal'), opts('Reveal file in explorer', silent, noremap) },
  { '<leader>tc', cmd('CopilotChatToggle'), opts('Toggle Copilot chat', silent, noremap) },

  -- Other utils
  {
    ']]',
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    opts('Next reference', silent, noremap),
  },
  {
    '[[',
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    opts('Prev reference', silent, noremap),
  },
})

tmap({
  '<leader>tt',
  function()
    Snacks.terminal()
  end,
  opts('Toggle terminal', silent, noremap),
})

-- insert mode
imap({ 'jk', '<esc>' })

-- Use : instead of cmd() for visual map commands
vmap({ '<leader>yl', ':RepoLink!<CR>', opts('Copy repository link', silent, noremap) })
vmap({ '<leader>tc', ':CopilotChat<CR>', opts('Copilot: Chat with selection', silent, noremap) })
