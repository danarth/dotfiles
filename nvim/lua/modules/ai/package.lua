local package = require('core.pack').package

package({
  'github/copilot.vim',
  config = function()
    vim.g.copilot_filetypes = {
      ['copilot-chat'] = false,
    }
  end,
})

package({
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    'github/copilot.vim',
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  opts = {
    model = 'gpt-4',
    question_header = ' Me ',
    answer_header = ' Copilot ',
    error_header = ' Error ',
    providers = {
      copilot = {},
      github_models = {
        get_models = false,
      },
    },
  },
})
