-- progress data
local clients = {}
local progress = { '⠋', '⠙', '⠸', '⢰', '⣠', '⣄', '⡆', '⠇' }

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

-- check for lsp progress data
local function is_lsp_loading(client)
  return client and clients[client] and clients[client].percentage < 100
end

-- update lsp progress
local function update_lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  for _, message in ipairs(messages) do
    if not message.name then
      goto continue
    end

    local client_name = message.name

    if not clients[client_name] then
      clients[client_name] = { percentage = 0, progress_index = 0 }
    end

    if message.done then
      clients[client_name].percentage = 100
    else
      if message.percentage then
        clients[client_name].percentage = message.percentage
      end
    end

    if clients[client_name].percentage % 5 == 0 or clients[client_name].progress_index == 0 then
      vim.opt.statusline = vim.opt.statusline
      clients[client_name].progress_index = clients[client_name].progress_index + 1
    end

    if clients[client_name].progress_index > #progress then
      clients[client_name].progress_index = 1
    end

    ::continue::
  end
end

-- get lsp client name for buffer
local function get_lsp_client_name()
  local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local client_name

  if #active_clients > 0 then
    client_name = active_clients[1].name
  end
  return client_name
end

-- configure feline
local function config(_, opts)
  local colorscheme = vim.g.colors_name
  local palette = require('nightfox.palette').load(colorscheme)
  local feline = require('feline')
  local vi_mode = require('feline.providers.vi_mode')
  local separators = require('feline.defaults').statusline.separators.default_value
  local lsp = require('feline.providers.lsp')
  local dap = require('dap')

  local theme = {
    fg = palette.fg1,
    bg = palette.bg1,
    black = palette.black.base,
    skyblue = palette.blue.bright,
    cyan = palette.cyan.base,
    green = palette.green.base,
    oceanblue = palette.blue.base,
    magenta = palette.magenta.base,
    orange = palette.orange.base,
    red = palette.red.base,
    violet = palette.magenta.bright,
    white = palette.white.base,
    yellow = palette.yellow.base,
  }

  local function git_diff(type)
    ---@diagnostic disable-next-line: undefined-field
    local gsd = vim.b.gitsigns_status_dict
    if gsd and gsd[type] and gsd[type] > 0 then
      return tostring(gsd[type])
    end
    return nil
  end

  local c = {

    -- left
    vim_status = {
      provider = function()
        local s
        if require('lazy.status').has_updates() then
          s = require('lazy.status').updates()
        else
          s = ''
        end
        s = string.format(' %s ', s)
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.blue.base },
      right_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.blue.base, bg = palette.bg0 },
      },
    },

    file_name = {
      provider = {
        name = 'file_info',
        opts = { colored_icon = false },
      },
      hl = { fg = palette.bg0, bg = palette.white.base },
      left_sep = {
        always_visible = true,
        str = string.format('%s ', separators.slant_right),
        hl = { fg = palette.bg0, bg = palette.white.base },
      },
    },

    git_branch = {
      provider = function()
        local git = require('feline.providers.git')
        local branch, icon = git.git_branch()
        local s
        if #branch > 0 then
          s = string.format(' %s%s ', icon, branch)
        else
          s = string.format(' %s ', 'Untracked')
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.fg3 },
      left_sep = {
        always_visible = true,
        str = string.format('%s%s', separators.block, separators.slant_right),
        hl = { fg = palette.white.base, bg = palette.fg3 },
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.fg3, bg = palette.bg0 },
      },
    },

    git_added = {
      provider = function()
        local status = git_diff('added')
        local s
        if status then
          s = string.format(' %s %s ', '', status)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.green.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.bg0, bg = palette.green.base },
      },
    },

    git_changed = {
      provider = function()
        local status = git_diff('changed')
        local s
        if status then
          s = string.format(' %s %s ', '', status)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.yellow.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.green.base, bg = palette.yellow.base },
      },
    },

    git_removed = {
      provider = function()
        local status = git_diff('removed')
        local s
        if status then
          s = string.format(' %s %s ', '', status)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.red.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.yellow.base, bg = palette.red.base },
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.red.base, bg = palette.bg0 },
      },
    },

    lsp = {
      provider = function()
        if not lsp.is_lsp_attached() then
          return ' 󱏎 LSP '
        end

        local client_name = get_lsp_client_name()
        if is_lsp_loading(client_name) then
          return string.format(' %s LSP ', progress[clients[client_name].progress_index])
        else
          return ' 󱁛 LSP '
        end
      end,
      hl = function()
        if not lsp.is_lsp_attached() then
          return { fg = palette.bg0, bg = palette.fg3 }
        end

        local client_name = get_lsp_client_name()
        if is_lsp_loading(client_name) then
          return { fg = palette.bg0, bg = palette.yellow.base }
        end

        return { fg = palette.bg0, bg = palette.green.base }
      end,
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = function()
          if not lsp.is_lsp_attached() then
            return { fg = palette.bg0, bg = palette.fg3 }
          end

          local client_name = get_lsp_client_name()
          if is_lsp_loading(client_name) then
            return { fg = palette.bg0, bg = palette.yellow.base }
          end

          return { fg = palette.bg0, bg = palette.green.base }
        end,
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = function()
          if not lsp.is_lsp_attached() then
            return { fg = palette.fg3, bg = 'none' }
          end

          local client_name = get_lsp_client_name()
          if is_lsp_loading(client_name) then
            return { fg = palette.yellow.base, bg = 'none' }
          end

          return { fg = palette.green.base, bg = 'none' }
        end,
      },
    },

    lsp_error = {
      provider = function()
        local s
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
        if count > 0 then
          s = string.format(' %s %d ', '', count)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.red.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.bg0, bg = palette.red.base },
      },
    },

    lsp_warning = {
      provider = function()
        local s
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
        if count > 0 then
          s = string.format(' %s %d ', '', count)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.magenta.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.red.base, bg = palette.magenta.base },
      },
    },

    lsp_info = {
      provider = function()
        local s
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }))
        if count > 0 then
          s = string.format(' %s %d ', '', count)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.blue.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.magenta.base, bg = palette.blue.base },
      },
    },

    lsp_hint = {
      provider = function()
        local s
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }))
        if count > 0 then
          s = string.format(' %s %d ', '', count)
        else
          s = ''
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.orange.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.blue.base, bg = palette.orange.base },
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = { fg = palette.orange.base, bg = 'none' },
      },
    },

    dap = {
      provider = function()
        local status = dap.status()
        if status == '' then
          return ' 󰃤 Debug '
        elseif starts_with(status, 'Stopped') then
          return '  ' .. dap.status() .. ' '
        else
          return '  ' .. dap.status() .. ' '
        end
      end,
      hl = function()
        local status = dap.status()
        if status == '' then
          return { fg = palette.bg0, bg = palette.fg3 }
        elseif starts_with(status, 'Stopped') then
          return { fg = palette.bg0, bg = palette.yellow.base }
        else
          return { fg = palette.bg0, bg = palette.green.base }
        end
      end,
      left_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = function()
          local status = dap.status()
          if status == '' then
            return { fg = palette.bg0, bg = palette.fg3 }
          elseif starts_with(status, 'Stopped') then
            return { fg = palette.bg0, bg = palette.yellow.base }
          else
            return { fg = palette.bg0, bg = palette.green.base }
          end
        end,
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_right,
        hl = function()
          local status = dap.status()
          if status == '' then
            return { bg = palette.bg0, fg = palette.fg3 }
          elseif starts_with(status, 'Stopped') then
            return { bg = palette.bg0, fg = palette.yellow.base }
          else
            return { bg = palette.bg0, fg = palette.green.base }
          end
        end,
      },
    },

    -- right
    vi_mode = {
      provider = function()
        local mode = vi_mode.get_vim_mode()
        if vim.api.nvim_get_mode().mode == 'nt' then
          mode = 'NORMAL'
        end
        return string.format(' %s ', mode)
      end,
      hl = function()
        return { fg = palette.bg0, bg = vi_mode.get_mode_color() }
      end,
      left_sep = {
        always_visible = true,
        str = separators.slant_left,
        hl = function()
          return { fg = vi_mode.get_mode_color(), bg = 'none' }
        end,
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_left,
        hl = function()
          return { fg = palette.bg0, bg = vi_mode.get_mode_color() }
        end,
      },
    },

    macro = {
      provider = function()
        local s
        local recording_register = vim.fn.reg_recording()
        if #recording_register == 0 then
          s = ''
        else
          s = string.format(' Recording @%s ', recording_register)
        end
        return s
      end,
      hl = { fg = palette.bg0, bg = palette.fg3 },
      left_sep = {
        always_visible = true,
        str = separators.slant_left,
        hl = function()
          return { fg = palette.fg3, bg = palette.bg0 }
        end,
      },
    },

    search_count = {
      provider = function()
        if vim.v.hlsearch == 0 then
          return ''
        end

        local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
        if not ok then
          return ''
        end
        if next(result) == nil then
          return ''
        end

        local denominator = math.min(result.total, result.maxcount)
        return string.format(' [%d/%d] ', result.current, denominator)
      end,
      hl = { fg = palette.bg0, bg = palette.white.base },
      left_sep = {
        always_visible = true,
        str = separators.slant_left,
        hl = function()
          return { fg = palette.white.base, bg = palette.fg3 }
        end,
      },
      right_sep = {
        always_visible = true,
        str = separators.slant_left,
        hl = { fg = palette.bg0, bg = palette.white.base },
      },
    },

    cursor_position = {
      provider = {
        name = 'position',
        opts = { padding = true },
      },
      hl = { fg = palette.bg0, bg = palette.blue.base },
      left_sep = {
        always_visible = true,
        str = string.format('%s%s', separators.slant_left, separators.block),
        hl = function()
          return { fg = palette.blue.base, bg = palette.bg0 }
        end,
      },
      right_sep = {
        always_visible = true,
        str = ' ',
        hl = { fg = palette.bg0, bg = palette.blue.base },
      },
    },
  }

  local active = {
    { -- left
      c.vim_status,
      c.file_name,
      c.git_branch,
      c.git_added,
      c.git_changed,
      c.git_removed,
      c.lsp,
      c.lsp_error,
      c.lsp_warning,
      c.lsp_info,
      c.lsp_hint,
      c.dap,
    },
    { -- right
      c.vi_mode,
      c.macro,
      c.search_count,
      c.cursor_position,
    },
  }

  local inactive = {
    { -- left
    },
    { -- right
    },
  }

  opts.components = { active = active, inactive = inactive }
  opts.force_inactive = { filetypes = { '^help$', '^neotest*', '^neo-tree*$', '^qf$' } }
  opts.disable = { filetypes = { '^alpha$', '^neo-tree*$' } }

  feline.setup(opts)
  feline.use_theme(theme)
end

return {
  config = config,
  init = function()
    -- use a global statusline
    -- vim.opt.laststatus = 3

    -- update statusbar when there's a plugin update
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyCheck',
      callback = function()
        vim.opt.statusline = vim.opt.statusline
      end,
    })

    -- update statusbar with LSP progress
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LspProgressUpdate',
      callback = function()
        update_lsp_progress()
      end,
    })

    -- hide the mode
    vim.opt.showmode = false

    -- hide search count on command line
    vim.opt.shortmess:append({ S = true })
  end,
  opts = {},
}
