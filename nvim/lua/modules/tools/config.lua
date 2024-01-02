local is_tmux_session = require('core.helper').is_tmux_session

local config = {}

function config.workspaces()
  require("workspaces").setup{
      hooks = {
          open = {
              "Neotree",
              function ()
                  if is_tmux_session() then
                      vim.cmd("VimuxOpenRunner")
                  end
              end,
              function ()
                  local workspace_name = require("workspaces").name()
                  if workspace_name ~= nil and is_tmux_session() then
                      vim.fn.system("tmux rename-window " .. workspace_name)
                  end
              end
          },
      }
  }
end

function config.telescope()
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('workspaces')
end

return config
