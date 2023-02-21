require("hop").setup()
require('nvim-autopairs').setup{}

require('nvim-treesitter.configs').setup{
    autotag = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
               ["af"] = "@function.outer",
               ["if"] = "@function.inner",
               ["ac"] = "@class.outer",
               ["ic"] = "@class.inner",
               ["aa"] = "@parameter.outer",
               ["ia"] = "@parameter.inner",
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>sa"] = "@parameter.inner"
            },
            swap_previous = {
                ["<leader>sA"] = "@parameter.inner"
            }
        }
    }
}

require("neotest").setup{
    adapters = {
        require("neotest-python"),
        require("neotest-vitest")
    },
    status = {
        enabled = true,
        signs = true
    },
    diagnostic = {
        enabled = true,
        severity = 1
    }
}

require("nvim-tree").setup({
    diagnostics = {
        enable = true
    }
})

require("bufferline").setup({
    options = {
        offsets = { { filetype = "NvimTree", text="File Explorer", text_align = "left" } },
    }
})

require("telescope").load_extension("workspaces")

require("aerial").setup{}

function IsTmuxSession()
    return os.getenv("TMUX") ~= nil
end

require("workspaces").setup{
    hooks = {
        open = {
            "NvimTreeOpen",
            "AerialOpenAll",
            function ()
                if IsTmuxSession() then
                    vim.cmd("VimuxOpenRunner")
                end
            end,
            function ()
                local workspace_name = require("workspaces").name()
                if workspace_name ~= nil and IsTmuxSession() then
                    vim.fn.system("tmux rename-window " .. workspace_name)
                end
            end
        },
    }
}


require("trouble").setup{}

require('colorizer').setup()

require('gitsigns').setup{}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require('mason').setup{}
require('mason-lspconfig').setup{
    automatic_installation = false,
}
require('mason-null-ls').setup{
    automatic_installation = false,
    automatic_setup = true
}
require('mason-nvim-dap').setup{
    automatic_installation = false,
    automatic_setup = true
}
require('mason-nvim-dap').setup_handlers()
require('dapui').setup{}

local null_ls = require('null-ls')
null_ls.setup{
    sources = {
        null_ls.builtins.code_actions.gitsigns
    }
}


local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
}),
  sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
  },
}

local on_attach = function (client, bufnr)
    local builtin = require('telescope.builtin')
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', '<leader>ft', ':Telescope tmux windows<cr>', bufopts)

    vim.keymap.set('n', '<leader>ce', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>cE', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ii', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', '<leader>gu', builtin.lsp_references, bufopts)
    vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, bufopts)
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, bufopts)

    local dap = require('dap')
    local neotest = require('neotest')
    vim.keymap.set('n', '<leader>xcr', neotest.run.run, bufopts)
    vim.keymap.set('n', '<leader>xr', neotest.run.run_last, bufopts)
    vim.keymap.set('n', '<leader>xb', dap.toggle_breakpoint, bufopts)
    vim.keymap.set('n', '<leader>xd', dap.continue, bufopts)

    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('n', '<leader><leader>f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR })
    end, {remap=true})
    vim.keymap.set('n', '<leader><leader>F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR })
    end, {remap=true})
    vim.keymap.set('n', '<leader><leader>t', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
    end, {remap=true})
    vim.keymap.set('n', '<leader><leader>T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
    end, {remap=true})
end


require'lspconfig'.terraformls.setup{
    on_attach = on_attach
}

require'lspconfig'.vimls.setup{
    on_attach = on_attach
}

require'lspconfig'.pyright.setup{
    on_attach = on_attach
}

require'lspconfig'.tsserver.setup{
    on_attach = on_attach
}

require'lspconfig'.eslint.setup{
    on_attach = on_attach
}

require'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

