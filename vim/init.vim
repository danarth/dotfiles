let mapleader = ","


if has('ide')
    function! plug#begin(foo)
    endfunction

    function! plug#end()
    endfunction
endif

call plug#begin('~/.vim/plugged')

" Plugins supported by both IdeaVim and Vim
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/argtextobj.vim'
Plug 'kana/vim-textobj-entire'
Plug 'tommcdo/vim-exchange'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors' " Deprecated but supported by IdeaVim and Vim
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" Other plugins not yet supported by IntelliJ
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'kana/vim-textobj-user'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ryanolsonx/vim-xit'
Plug 'frazrepo/vim-rainbow'

if $TMUX != ''
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'preservim/vimux'
endif


" Colour schemes
if has('nvim')
    Plug 'navarasu/onedark.nvim'
    Plug 'EdenEast/nightfox.nvim'
else
    Plug 'joshdick/onedark.vim'
endif

" Plugins supported by nvim
if has('nvim')
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jay-babu/mason-null-ls.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'josa42/nvim-lightline-lsp'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'natecraddock/workspaces.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
    Plug 'michaelb/sniprun'
    Plug 'stevearc/dressing.nvim'
    Plug 'stevearc/aerial.nvim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'phaazon/hop.nvim'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'folke/trouble.nvim'
    Plug 'lewis6991/gitsigns.nvim'
else
    Plug 'airblade/vim-gitgutter'
    Plug 'easymotion/vim-easymotion'
    Plug 'dense-analysis/ale'
    Plug 'maximbaz/lightline-ale'
endif

call plug#end()

set number relativenumber

" Disable arrow keys to encourage good vim style
nmap <Up> <nop>
nmap <Down> <nop>
nmap <Left> <nop>
nmap <Right> <nop>

nmap DD ^D

set visualbell

" Editor exit shortcuts
nmap <leader>ww :w<cr>
nmap <leader>wa :wa<cr>
nmap <leader>wq :wq<cr>
nmap <leader>qq :q!<cr>

nmap Y y$

nmap H ^
nmap L $

nmap <space> i<space><esc>

imap jk <esc>

" visual maps
nmap <leader>iG ggVG
nmap <leader>iL ^v$

" Buffers
nmap <leader>bl :ls<cr>
nmap <leader>bwq :w<cr> :bp\|bd #<cr>
nmap <leader>bq :bp\|bd #<cr>
nmap <leader>bn :bn<cr>
nmap <leader>bp :bp<cr>
nmap <leader>bb :b #<cr>

" Tabs
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

if has('nvim')
    nmap <leader>fs :NvimTreeToggle<cr>
else
    nmap <leader>fs :NERDTree<cr>
endif

set scr=10

nmap <leader>cl ^D
nmap <leader>) F(%
map <F1> <Nop>

let g:highlightedyank_highlight_duration=300

" custom file types
autocmd! BufNewFile,BufRead .env.* setf sh

" highlight matches during search, not after
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" ideaVim only settings
if has('ide')

    " set ideaVim settings
    set ideajoin

    " x for eXecute:
    nmap <leader>xr <Action>(Run)
    nmap <leader>xd <Action>(Debug)
    nmap <leader>xe <Action>(editRunConfigurations)
    nmap <leader>xcr <Action>(RunClass)
    nmap <leader>xcd <Action>(DebugClass)

    " n for New files
    nmap <leader>nn <Action>(NewFile)
    nmap <leader>nc <Action>(NewClass)
    nmap <leader>ns <Action>(NewScratchFile)
    nmap <leader>nb <Action>(NewScratchBuffer)

    " m for Maven
    nmap <leader>mr <Action>(Maven.Reimport)
    nmap <leader>mg <Action>(Maven.ExecuteGoal)
    nmap <leader>mm <Action>(ActivateMavenToolWindow)

    " c for Code
    nmap <leader>cq <Action>(SonarLint.AnalyzeChangedFiles)
    nmap <leader>cg <Action>(Generate)
    nmap <leader>== <Action>(ReformatCode)
    nmap <leader>co <Action>(OptimizeImports)
    nmap <leader>ce <Action>(GotoNextError)
    nmap <leader>cE <Action>(GotoPreviousError)
    nmap <leader>ca <Action>(Annotate)

    " b for Breakpoint
    nmap <leader>bb <Action>(ToggleLineBreakpoint)
    nmap <leader>ba <Action>(ViewBreakpoints)

    nmap <leader>rr <Action>(RenameElement)
    nmap <leader>dd <Action>(SafeDelete)

    nmap <leader>pp <Action>(TogglePresentationMode)

    " Editor Commands
    nmap <leader>qQ <Action>(CloseAllEditorsButActive)
    nmap <leader>QQ <Action>(CloseAllEditors)
    nmap <leader>qh <Action>(CloseAllToTheLeft)
    nmap <leader>ql <Action>(CloseAllToTheRight)

    nmap <leader>ft <Action>(ActivateTerminalToolWindow)

    nmap <leader>gi <Action>(GotoImplementation)
    nmap <leader>gd <Action>(GotoDeclaration)
    nmap <leader>gt <Action>(GotoTest)
    nmap <leader>gu <Action>(ShowUsages)

    nmap <c-h> <c-w>h
    nmap <c-l> <c-w>l
    nmap <c-s-h> <Action>(PreviousTab)
    nmap <c-s-l> <Action>(NextTab)
else
    if &term =~ '^xterm'
        " solid underscore
        let &t_SI .= "\<Esc>[6 q"
        " solid block
        let &t_EI .= "\<Esc>[2 q"
        " 1 or 0 -> blinking block
        " 3 -> blinking underscore
        " Recent versions of xterm (282 or above) also support
        " 5 -> blinking vertical bar
        " 6 -> solid vertical bar
    endif
    set encoding=utf-8
    set expandtab tabstop=4 shiftwidth=4
    set splitright
    set noerrorbells
    set ff=unix

    set nowrap

    set re=0

    set noshowmode
    set laststatus=2
    
    let g:VimuxHeight = "20"
    let g:lightline = {}

    nmap <C-j> :TmuxNavigateDown<cr>
    nmap <C-h> :TmuxNavigateLeft<cr>
    nmap <C-l> :TmuxNavigateRight<cr>
    nmap <C-k> :TmuxNavigateUp<cr>

    if has('nvim')
        colorscheme nightfox
        let g:lightline.colorscheme = 'nightfox'

        let $NVIM_TUI_ENABLE_TRUE_COLOR=1

        let g:lightline.component_expand = {
        \  'linter_infos': 'lightline#lsp#infos',
        \  'linter_warnings': 'lightline#lsp#warnings',
        \  'linter_errors': 'lightline#lsp#errors',
        \  'linter_ok': 'lightline#lsp#ok',
        \ }
        " code navigation is set up in lspconfig.lua 
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        nnoremap <leader>fw <cmd>Telescope workspaces<cr>
    else
        colorscheme onedark
        let g:lightline.colorscheme = 'onedark'

        let g:lightline.component_expand = {
        \  'linter_infos': 'lightline#ale#infos',
        \  'linter_warnings': 'lightline#ale#warnings',
        \  'linter_errors': 'lightline#ale#errors',
        \  'linter_ok': 'lightline#ale#ok',
        \ }

        let g:ale_completion_enabled = 1
        set omnifunc=ale#completion#OmniFunc

        " code navigation
        nmap <leader>ce :ALENext<cr>
        nmap <leader>cE :ALEPrevious<cr>
        nmap <leader>co :ALEOrganizeImports<cr>

        nmap <leader>gi :ALEGoToImplementation<cr>
        nmap <leader>gd :ALEGoToDefinition<cr>
        nmap <leader>gu :ALEFindReferences<cr>
        nmap <leader>rr :ALERename<cr>
    endif


    let g:lightline.component_function = {
        \   'gitbranch': 'FugitiveHead'
        \ }

    let g:lightline.component_type = {
        \     'linter_infos': 'right',
        \     'linter_warnings': 'warning',
        \     'linter_errors': 'error',
        \     'linter_ok': 'right',
        \ }
    
    let g:lightline.enable = {
        \   'tabline': 0
        \ }

    let g:lightline.active = {
        \ 'left': [['mode', 'paste'],
        \       ['gitbranch', 'readonly', 'filename', 'modified']],
        \ 'right': [ ['linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
        \            [ 'lineinfo' ],
	    \            [ 'percent' ],
	    \            [ 'fileformat', 'fileencoding', 'filetype'] ]
        \ }


endif


