local function starts_with(str, start)
  return str:sub(1, #start) == start
end

local function git_diff(type)
  ---@diagnostic disable-next-line: undefined-field
  local gsd = vim.b.gitsigns_status_dict
  if gsd and gsd[type] and gsd[type] > 0 then
    return tostring(gsd[type])
  end
  return ''
end

return function()
  local dap = require('dap')
  local colorscheme = vim.g.colors_name
  local palette = require('nightfox.palette').load(colorscheme)

  local theme = {
    normal = {
      a = { fg = palette.fg1, bg = palette.bg1 },
      b = { fg = palette.fg1, bg = palette.bg1 },
      c = { fg = palette.fg1, bg = palette.bg1 },
      x = { fg = palette.bg1, bg = palette.green.base },
      y = { fg = palette.fg1, bg = palette.bg1 },
      z = { fg = palette.fg1, bg = palette.bg1 },
    },
    insert = {
      x = { fg = palette.bg1, bg = palette.red.base },
    },
    visual = {
      x = { fg = palette.bg1, bg = palette.blue.base },
    },
    replace = {
      x = { fg = palette.bg1, bg = palette.magenta.base },
    },
    terminal = {
      x = { fg = palette.bg1, bg = palette.orange.base },
    },
  }

  require('lualine').setup({
    options = {
      theme = theme,
      icons_enabled = true,
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = {
        {
          function()
            return ''
          end,
          color = {
            fg = palette.bg1,
            bg = palette.blue.bright,
          },
          separator = {
            right = '',
          },
        },
        {
          function()
            return ''
          end,
          draw_empty = true,
          color = {
            fg = palette.blue.bright,
            bg = palette.bg1,
          },
          separator = {
            right = '',
          },
        },
        {
          'filetype',
          icon_only = true,
          color = {
            bg = palette.white.base,
            fg = palette.bg1,
          },
          padding = {
            left = 1,
            right = 0,
          },
          separator = {
            left = '',
            right = '',
          },
        },
        {
          'filename',
          color = {
            bg = palette.white.base,
            fg = palette.bg1,
          },
          padding = {
            left = 0,
            right = 1,
          },
          separator = {
            left = '',
            right = '',
          },
        },
        {
          'branch',
          icon = '',
          color = {
            fg = palette.bg0,
            bg = palette.fg3,
          },
          separator = {
            right = '',
          },
        },
        {
          function()
            return ''
          end,
          draw_empty = true,
          color = {
            fg = palette.fg3,
            bg = palette.bg1,
          },
          separator = {
            right = '',
          },
        },
        {
          function()
            return git_diff('added')
          end,
          icon = '',
          draw_empty = true,
          color = {
            fg = palette.bg0,
            bg = palette.green.base,
          },
          separator = {
            right = '',
          },
        },
        {
          function()
            return git_diff('modified')
          end,
          icon = '',
          draw_empty = true,
          color = {
            fg = palette.bg0,
            bg = palette.yellow.base,
          },
          separator = {
            right = '',
          },
        },
        {
          function()
            return git_diff('removed')
          end,
          icon = '',
          draw_empty = true,
          color = {
            fg = palette.bg0,
            bg = palette.red.base,
          },
          separator = {
            right = '',
          },
        },
        {
          function()
            return ''
          end,
          draw_empty = true,
          color = {
            fg = palette.red.base,
            bg = palette.bg1,
          },
          separator = {
            right = '',
          },
        },
      },
      lualine_b = {
        -- TODO: LSP Indicator
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error' },
          symbols = { error = ' ' },
          colored = false,
          update_in_insert = true,
          always_visible = false,
          draw_empty = true,
          separator = {
            right = '',
          },
          color = {
            bg = palette.red.base,
            fg = palette.bg1,
          },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'warn' },
          symbols = { warn = ' ' },
          colored = false,
          update_in_insert = true,
          always_visible = false,
          draw_empty = true,
          separator = {
            right = '',
          },
          color = {
            bg = palette.magenta.base,
            fg = palette.bg1,
          },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'info' },
          symbols = { info = ' ' },
          colored = false,
          update_in_insert = true,
          always_visible = false,
          draw_empty = true,
          separator = {
            right = '',
          },
          color = {
            bg = palette.blue.base,
            fg = palette.bg1,
          },
        },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'hint' },
          symbols = { hint = ' ' },
          colored = false,
          update_in_insert = true,
          always_visible = false,
          draw_empty = true,
          separator = {
            right = '',
          },
          color = {
            bg = palette.orange.base,
            fg = palette.bg1,
          },
        },
        {
          function()
            return ''
          end,
          draw_empty = true,
          color = {
            fg = palette.orange.base,
            bg = palette.bg1,
          },
          separator = {
            right = '',
          },
        },
      },
      lualine_c = {
        {
          function()
            local status = dap.status()
            if status == '' then
              return '󰃤 Debug'
            elseif starts_with(status, 'Stopped') then
              return ' ' .. dap.status()
            else
              return ' ' .. dap.status()
            end
          end,
          color = function()
            local status = dap.status()
            if status == '' then
              return { fg = palette.bg0, bg = palette.fg3 }
            elseif starts_with(status, 'Stopped') then
              return { fg = palette.bg0, bg = palette.yellow.base }
            else
              return { fg = palette.bg0, bg = palette.green.base }
            end
          end,
          separator = {
            right = '',
          },
          on_click = function()
            require('telescope').extensions.dap.configurations()
          end,
        },
      },
      lualine_x = {
        {
          'mode',
          separator = {
            left = '',
          },
        },
      },
      lualine_y = {
        {
          function()
            return ''
          end,
          draw_empty = true,
          color = {
            fg = palette.fg3,
            bg = palette.bg1,
          },
          separator = {
            left = '',
          },
        },
        {
          function()
            local s
            local recording_register = vim.fn.reg_recording()
            if #recording_register == 0 then
              s = ''
            else
              s = string.format('Recording @%s', recording_register)
            end
            return s
          end,
          draw_empty = true,
          color = {
            fg = palette.bg0,
            bg = palette.fg3,
          },
          separator = {
            left = '',
          },
        },
        {
          'searchcount',
          draw_empty = true,
          color = {
            bg = palette.white.base,
            fg = palette.bg1,
          },
          separator = {
            left = '',
          },
        },
      },
      lualine_z = {
        {
          function()
            return ''
          end,
          draw_empty = true,
          color = {
            fg = palette.blue.bright,
            bg = palette.bg1,
          },
          separator = {
            left = '',
          },
        },
        {
          'location',
          color = {
            fg = palette.bg1,
            bg = palette.blue.bright,
          },
          separator = {
            left = '',
          },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })
end
