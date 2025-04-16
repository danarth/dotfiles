local keymap = require('core.keymap')
local nmap = keymap.nmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

local telescope_builtin = require('telescope.builtin')

nmap({
  { '<leader>ff', cmd('Telescope find_files'), opts('Find files', noremap, silent) },
  { '<leader>fg', cmd('Telescope live_grep'), opts('Grep files', noremap, silent) },
  { '<leader>fc', cmd('Telescope git_status'), opts('Git status', noremap, silent) },
  { '<leader>fG', cmd('Telescope live_grep_args'), opts('Grep files (with args)', noremap, silent) },
  { '<leader>fb', cmd('Telescope buffers'), opts('Search open buffers', noremap, silent) },
  { '<leader>fr', cmd('Telescope registers'), opts('Search registers', noremap, silent) },
  { '<leader>fh', cmd('Telescope help_tags'), opts('Search help tags', noremap, silent) },
  { '<leader>fw', cmd('Telescope workspaces'), opts('Search workspaces', noremap, silent) },
  { '<leader>fd', cmd('Telescope picker_list'), opts('Search all pickers', noremap, silent) },

  -- LSP
  { '<leader>gu', telescope_builtin.lsp_references, opts('Find usages', noremap, silent) },
  { '<leader>gi', telescope_builtin.lsp_implementations, opts('Find implementations', noremap, silent) },
  { '<leader>gd', telescope_builtin.lsp_definitions, opts('Find definitions', noremap, silent) },
})
