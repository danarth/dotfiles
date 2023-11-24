local package = require('core.pack').package

package({ 'prisma/vim-prisma' })

package({
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/nvim-cmp",
    "neovim/nvim-lspconfig",
  }
})
