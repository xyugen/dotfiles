let mapleader=" "

" Example Neovim configuration file

" Use syntax highlighting
syntax on

" Set the tab width to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Show line numbers
set number

" Show the cursor position in the status line
set ruler

" Enable mouse support
set mouse=a

" Set the default file encoding to UTF-8
set encoding=utf-8

" ----------------------------
"  VIM PLUG
call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter' " Git changes
Plug 'nvim-treesitter/nvim-treesitter' " 
Plug 'terryma/vim-smooth-scroll' " 
Plug 'ap/vim-css-color' " CSS Color Preview
Plug 'preservim/nerdtree' " File explorer
Plug 'vim-airline/vim-airline' " Status bar
Plug 'rstacruz/vim-closer' " closes brackets
Plug 'Xuyuanp/nerdtree-git-plugin' " nerdtree shows git status
Plug 'tpope/vim-fugitive' " Git integration
Plug 'dense-analysis/ale' " Asynchronous Lint Engine
Plug 'scrooloose/nerdcommenter' " Commenting plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine
Plug 'bluz71/vim-moonfly-colors' " Moonfly theme
Plug 'gruvbox-community/gruvbox' " Gruvbox theme
Plug 'tc50cal/vim-terminal' " Vim Terminal

call plug#end()

" Configure plugin options

" nerdtree toggle
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>


" Vim-Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%3d'
let g:airline#extensions#tabline#show_tab_count = 1

" ALE
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'python': ['black'],
\   'javascript': ['prettier'],
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_sign_style_error = '✖'
let g:ale_sign_style_warning = '⚠'

" COC.nvim
let g:coc_global_extensions = [
\   'coc-tsserver',
\   'coc-eslint',
\]
let g:coc_node_path = '/usr/bin/node'
let g:coc_disable_startup_warning = 1

autocmd FileType * silent! call CocStart()
autocmd FileType * nmap <silent> <C-space> :call CocAction('snippet')<CR>
inoremap <expr><C-space> coc#refresh()

" use <tab> for trigger completion and navigate
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Moonfly
" set background=dark
" colorscheme moonfly

" GruvBox
colorscheme gruvbox

" __________________________________________
" Start NERDTree and put the curson back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() == 1 | quit | endif

" ------------------------------------------------------------------------
" CUSTOM COMMANDS
command PyRun term python %
" command CppRun !g++ % -o %< && ./%�kb�kr�kr��,��.^[<
" command CppRun !konsole -e \"bash -c 'g++ % -o %< && ./ %< && bash'\" -i
command CppRun belowright split | term bash -c 'g++ % -o %< && ./%< < /dev/tty && read -p "Press Enter to continue..."'
