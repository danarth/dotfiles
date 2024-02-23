local package = require('core.pack').package

package({
  'jim-fx/sudoku.nvim',
  cmd = 'Sudoku',
  config = function()
    require('sudoku').setup({})
  end,
})
