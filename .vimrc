set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'romainl/flattened'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-auto-save'
Plugin 'kovisoft/slimv'
Plugin 'elzr/vim-json'
call vundle#end()
filetype plugin indent on
syntax on

let mapleader = ";"
let localleader = ";;"

set noswapfile

"""Text settings"""
set expandtab
set textwidth=79
"set tabstop=8
"set softtabstop=4
"set shiftwidth=4
"font size and type
set guifont=Courier\ Prime\ Code\ 10
set autoindent
set number

"""Insert mode mappings"""
inoremap jj <esc>
"Completion mode
inoremap <leader>n <c-n>
inoremap <leader>p <c-p>
"Do normal command
inoremap <leader>o <c-o>

"""Normal mode mappings"""
nnoremap <leader>r <c-r>
nnoremap <leader>h ^ 
nnoremap <leader>l $
""Search settings/mappings
set hlsearch
set incsearch
"switch off highlighting
nnoremap <leader>W :noh<cr>
""Buffer mappings""
nnoremap <leader>b^ <c-^>
nnoremap <leader>b# :execute "rightbelow vsplit " . bufname("#")
""Window mappings""
nnoremap <leader>w <c-w>
nnoremap <leader>h# :sp #<cr>
nnoremap <leader>v# :vsp #<cr>
""Tab mappings""
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>te :tabe
nnoremap <leader>tc :tabc<cr>
nnoremap <leader>tm :tabmove
""Text openers""
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>ei :vsplit ~/Dropbox/writings/ideas.md<cr>
nnoremap <leader>ej :vsplit ~/Dropbox/writings/jokes.md<cr>
"Vim installation bindings
nnoremap <leader>pv :PluginInstall<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

let g:auto_save = 1
colorscheme flattened_light
