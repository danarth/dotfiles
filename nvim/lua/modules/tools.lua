local package = require('core.pack').package
local helper = require('core.helper')
local is_kitty_session = helper.is_kitty_session
local is_tmux_session = helper.is_tmux_session

package({
  'natecraddock/workspaces.nvim',
  config = function()
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
  end,
})

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = function()
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
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'OliverChao/telescope-picker-list.nvim' },
    { 'danarth/telescope-buku.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
})

package({
  'glepnir/hlsearch.nvim',
  event = 'BufRead',
  config = function()
    require('hlsearch').setup()
  end,
})

package({
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
})

package({
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
})

package({
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
})

package('sindrets/diffview.nvim')

package('tpope/vim-projectionist')

package({
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  '9seconds/repolink.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = {
    'RepoLink',
  },
  config = function()
    -- Check for custom GitLab URL
    local url_builders = {}
    if os.getenv('GITLAB_HOSTNAME') then
      url_builders[os.getenv('GITLAB_HOSTNAME')] =
        require('repolink').url_builder_for_gitlab('https://' .. os.getenv('GITLAB_HOSTNAME'))
    end

    require('repolink').setup({
      url_builders = url_builders,
    })
  end,
})

package({
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
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
  end,
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
      end,
    })
  end,
})

package({
  'alex-popov-tech/store.nvim',
  dependencies = {
    'OXY2DEV/markview.nvim',
  },
  cmd = 'Store',
})
