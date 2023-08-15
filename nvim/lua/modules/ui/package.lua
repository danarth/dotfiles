local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'EdenEast/nightfox.nvim', config = conf.nightfox })

package({
  'josa42/nvim-lightline-lsp',
  config = conf.lightline,
  dependencies = { 'itchyny/lightline.vim' },
})

package({
    'folke/trouble.nvim',
    config = function()
        require('trouble').setup{}
    end
})

package({
    'nvim-tree/nvim-tree.lua',
    config = function()
        require('nvim-tree').setup{
            diagnostics = {
                enable = true
            }
        }
    end
})

package({
    'norcalli/nvim-colorizer.lua',
    config = function ()
        require('colorizer').setup{}
    end
})

package({
  'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
