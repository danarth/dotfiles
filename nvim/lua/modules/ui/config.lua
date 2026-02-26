local config = {}

function config.nightfox()
  require('nightfox').setup({
    options = {
      styles = {
        keywords = 'italic',
        comments = 'italic',
        conditionals = 'italic',
      },
    },
  })
  vim.cmd('colorscheme duskfox')
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      hover = {
        enabled = true,
        delay = 50,
        reveal = { 'close' },
      },
      always_show_bufferline = true,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'center',
        },
      },
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        local custom_map = {
          dap_repl = {
            icon = '',
            hl = 'MiniIconsGreen',
          },
        }
        if custom_map[element.filetype] then
          return custom_map[element.filetype].icon, custom_map[element.filetype].hl
        end
        return icon, hl
      end,
    },
  })
end

return config
