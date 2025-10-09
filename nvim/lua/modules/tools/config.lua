local helper = require('core.helper')
local is_kitty_session = helper.is_kitty_session
local is_tmux_session = helper.is_tmux_session

local config = {}

function config.workspaces()
  require('workspaces').setup({
    hooks = {
      open = {
        function()
          vim.o.laststatus = 3 -- global statusline
          -- require('edgy').open()
          vim.cmd('Neotree')
        end,
        function()
          local workspace_name = require('workspaces').name()
          vim.o.titlestring = workspace_name
          if workspace_name ~= nil and is_tmux_session() then
            vim.fn.system('tmux rename-window ' .. workspace_name)
          elseif workspace_name ~= nil and is_kitty_session() then
            vim.fn.system('kitten @ set-tab-title ' .. workspace_name)
          end
        end,
      },
    },
  })
end

function config.telescope()
  local select_one_or_multi = function(prompt_bufnr)
    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
      require('telescope.actions').close(prompt_bufnr)
      for _, j in pairs(multi) do
        if j.path ~= nil then
          vim.cmd(string.format('%s %s', 'edit', j.path))
        end
      end
    else
      require('telescope.actions').select_default(prompt_bufnr)
    end
  end
  local telescope = require('telescope')
  local lga_actions = require('telescope-live-grep-args.actions')
  telescope.setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      mappings = {
        i = {
          ['<CR>'] = select_one_or_multi,
        },
      },
    },
    extensions = {
      live_grep_args = {
        mappings = {
          i = {
            ['<C-k>'] = lga_actions.quote_prompt(),
          },
        },
      },
    },
  })
  telescope.load_extension('workspaces')
  telescope.load_extension('dap')
  telescope.load_extension('buku')
  telescope.load_extension('picker_list')
  telescope.load_extension('live_grep_args')
end

function config.snacks()
  local snacks = require('snacks')
  ---@type snacks.Config
  local opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = ' ', key = 'w', desc = 'Open Workspace', action = ':Telescope workspaces' },
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'Lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup', padding = 1 },
        {
          text = {
            { ' ', hl = 'Number', align = 'center' },
          },
        },
      },
    },
    image = {
      enabled = true,
    },
    input = {
      enabled = true,
    },
    bigfile = {
      enabled = true,
    },
    picker = {
      enabled = true,
    },
    quickfile = {
      enabled = true,
    },
    statuscolumn = {
      enabled = true,
    },
    words = {
      enabled = true,
    },
  }
  snacks.setup(opts)
end

return config
