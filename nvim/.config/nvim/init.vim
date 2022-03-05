"so pynvim does not have to be installed in every environment
let g:python3_host_prog = '/home/fhchl/miniconda3/bin/python'
let mapleader = " "

"always copy to system clipboard
set clipboard+=unnamedplus
set mouse=a
set nowrap
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent autoindent
set nohlsearch
set number
set numberwidth=2
set hidden
set nobackup undofile
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set relativenumber
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" indent with tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-d> 
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" run python files
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

""" autocompletion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
 
"automatically install vim-plug on start
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatically install missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"define plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-sleuth'  "autodetect taps and spaces
Plug 'editorconfig/editorconfig-vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig' " get some keybindings like https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " for highlight. could also do indenting?
Plug 'godlygeek/tabular'  " required by vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'mg979/vim-visual-multi' " multiple cursers
call plug#end()

" markdown and pandoc
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_math = 1
set conceallevel=2
let g:pandoc#biblio#bibs = ["~/Zotero/wholebib.bib"]

set termguicolors
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

nnoremap <leader>ff :Files<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fl :Lines<cr>  
nnoremap <leader>fL :BLines<cr>   
nnoremap <leader>fh :Helptags<cr>  
nnoremap <leader>fm :Maps<cr>  
nnoremap <leader>fc :Commands<cr>  

"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" lsp
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics()<CR>

lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
