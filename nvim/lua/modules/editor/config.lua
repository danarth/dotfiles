local config = {}

function config.nvim_treesitter()
  require('nvim-treesitter.configs').setup({
    autotag = {
      enable = true,
    },
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['as'] = '@statement.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>sa'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>sA'] = '@parameter.inner',
        },
      },
    },
  })
end

return config
