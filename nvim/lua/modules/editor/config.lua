local config = {}

function config.nvim_treesitter()
  ---@diagnostic disable-next-line: missing-fields
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
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['ai'] = '@conditional.outer',
          ['ii'] = '@conditional.inner',
          ['=h'] = '@assignment.lhs',
          ['=l'] = '@assignment.rhs',
          ['a='] = '@assignment.outer',
          ['i='] = '@assignment.inner',
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
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']c'] = '@class.outer',
          [']l'] = '@loop.outer',
          [']i'] = '@conditional.outer',
          [']r'] = '@return.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']C'] = '@class.outer',
          [']L'] = '@loop.outer',
          [']I'] = '@conditional.outer',
          [']R'] = '@return.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[l'] = '@loop.outer',
          ['[i'] = '@conditional.outer',
          ['[r'] = '@return.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[L'] = '@loop.outer',
          ['[I'] = '@conditional.outer',
          ['[R'] = '@return.outer',
        },
      },
    },
  })
end

return config
