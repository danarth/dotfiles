local is_tmux_session = require('core.helper').is_tmux_session

local config = {}

function config.workspaces()
  require('workspaces').setup({
    hooks = {
      open = {
        'Neotree',
        function()
          if is_tmux_session() then
            vim.cmd('VimuxOpenRunner')
          end
        end,
        function()
          local workspace_name = require('workspaces').name()
          if workspace_name ~= nil and is_tmux_session() then
            vim.fn.system('tmux rename-window ' .. workspace_name)
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
        }
      }
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  telescope.load_extension('fzy_native')
  telescope.load_extension('workspaces')
  telescope.load_extension('dap')
  telescope.load_extension('buku')
  telescope.load_extension('picker_list')
end

return config
