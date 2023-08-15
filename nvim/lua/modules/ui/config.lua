local config = {}

function config.nightfox()
  vim.cmd('colorscheme nightfox')
end

function config.lightline()
  vim.g.lightline = {
    colorscheme = 'nightfox',
    enable = {
      tabline = 0,
    },
    component_expand = {
     linter_infos = 'lightline#lsp#infos',
     linter_warnings = 'lightline#lsp#warnings',
     linter_errors = 'lightline#lsp#errors',
     linter_ok = 'lightline#lsp#ok',
    },
    component_function = {
      gitbranch = 'FugitiveHead'
    },
    component_type = {
      linter_infos = 'right',
      linter_warnings = 'warning',
      linter_errors = 'error',
      linter_ok = 'right',
    },
    active = {
      left = {
        { 'mode', 'page' },
        { 'gitbranch', 'readonly', 'filename', 'modified' }
      },
      right = {
        { 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' },
        { 'line_info' },
        { 'percent' },
        { 'fileformat', 'fileencoding', 'filetype' }
      }
    }
  }

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
