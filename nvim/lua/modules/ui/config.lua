local config = {}

function config.dashboard()
  require('dashboard').setup {
    config = {
      week_header = {
        enable = true
      },
      project = {
        enable = false,
      },
      shortcut = {
        {
          desc = ' Workspaces',
          group = 'Label',
          key = 'w',
          action = 'Telescope workspaces'
        },
        {
          desc = ' Files',
          group = 'DiagnosticHint',
          key = 'f',
          action = 'Telescope find_files'
        },
        {
          desc = ' Terminal',
          group = 'Number',
          key = 't',
          action = 'VimuxOpenRunner'
        }
      },
      footer = {
        '',
        '  '
      }
    }
  }
end

function config.nightfox()
  vim.cmd('colorscheme nightfox')
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      always_show_bufferline = false,
      offsets = {
        { filetype = "NvimTree", text="File Explorer", text_align = "left" }
      },
    },
  })
end

return config
