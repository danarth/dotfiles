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
  'glepnir/hlsearch.nvim',
  event = 'BufRead',
  config = function()
    require('hlsearch').setup()
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
  'alex-popov-tech/store.nvim',
  dependencies = {
    'OXY2DEV/markview.nvim',
  },
  cmd = 'Store',
})
