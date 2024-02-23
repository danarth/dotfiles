local keymap = require('core.keymap')
local nmap = keymap.nmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

local telescope_builtin = require('telescope.builtin')

nmap({
  { '<leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<leader>fg', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<leader>fr', cmd('Telescope registers'), opts(noremap, silent) },
  { '<leader>fh', cmd('Telescope help_tags'), opts(noremap, silent) },
  { '<leader>fw', cmd('Telescope workspaces'), opts(noremap, silent) },
  { '<leader>fd', cmd('Telescope picker_list'), opts(noremap, silent) },
  { '<leader>fs', cmd('Telescope azure_devops work_items'), opts(noremap, silent) },

  -- LSP
  { '<leader>gu', telescope_builtin.lsp_references, opts(noremap, silent) },
  { '<leader>gi', telescope_builtin.lsp_implementations, opts(noremap, silent) },
  { '<leader>gd', telescope_builtin.lsp_definitions, opts(noremap, silent) },
})
