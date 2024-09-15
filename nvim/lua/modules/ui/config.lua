local config = {}

function config.dashboard()
  require('dashboard').setup({
    config = {
      week_header = {
        enable = true,
      },
      project = {
        enable = false,
      },
      shortcut = {
        {
          desc = ' Scatch File',
          group = 'DiagnosticHint',
          key = 's',
          action = 'Scratch',
        },
        {
          desc = ' Workspaces',
          group = 'Label',
          key = 'w',
          action = 'Telescope workspaces',
        },
        {
          desc = ' Files',
          group = 'Special',
          key = 'f',
          action = 'Telescope find_files',
        },
        {
          desc = ' Terminal',
          group = 'Number',
          key = 't',
          action = 'VimuxOpenRunner',
        },
        {
          desc = '󰗼 Exit',
          key = 'q',
          action = 'q',
        },
      },
      footer = {
        '',
        ' ',
      },
    },
  })
end

function config.nightfox()
  vim.cmd('colorscheme duskfox')
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      always_show_bufferline = false,
      offsets = {
        { filetype = 'neo-tree', text = 'File Explorer', text_align = 'left' },
        { filetype = 'dbui', text = 'Databases', text_align = 'left' },
      },
    },
  })
end

return config
