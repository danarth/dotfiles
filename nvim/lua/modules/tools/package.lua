local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'natecraddock/workspaces.nvim',
  config = conf.workspaces,
})

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
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
  'LintaoAmons/scratch.nvim',
  event = 'VimEnter',
  config = function()
    require('scratch').setup({
      filetypes = { 'md', 'lua', 'python', 'json', 'yaml' },
    })
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
  config = conf.snacks,
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
