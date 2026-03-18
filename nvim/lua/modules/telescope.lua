local package = require('core.pack').package

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
