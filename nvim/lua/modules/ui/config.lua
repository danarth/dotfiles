local config = {}

function config.nightfox()
  vim.cmd('colorscheme duskfox')
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      hover = {
        enabled = true,
        delay = 50,
        reveal = {'close'},
      },
      separator_style = 'slope',
      always_show_bufferline = true,
      offsets = {
        { filetype = 'neo-tree', text = 'File Explorer', text_align = 'left' },
        { filetype = 'dbui', text = 'Databases', text_align = 'left' },
      },
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        local custom_map = {
          dap_repl = {
            icon = "",
            hl = "MiniIconsGreen",
          }
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
