local config = {}

function config.nightfox()
  require('nightfox').setup({
    options = {
      styles = {
        keywords = 'italic',
        comments = 'italic',
        conditionals = 'italic'
      }
    }
  })
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
  local Offset = require("bufferline.offset")
  if not Offset.edgy then
    local get = Offset.get
    Offset.get = function()
      if package.loaded.edgy then
        local layout = require("edgy.config").layout
        local ret = { left = "", left_size = 0, right = "", right_size = 0 }
        for _, pos in ipairs({ "left", "right" }) do
          local sb = layout[pos]
          if sb and #sb.wins > 0 then
            local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
            ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
            ret[pos .. "_size"] = sb.bounds.width
          end
        end
        ret.total_size = ret.left_size + ret.right_size
        if ret.total_size > 0 then
          return ret
        end
      end
      return get()
    end
    Offset.edgy = true
  end
end

return config
