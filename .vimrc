set nocompatible
filetype off
"set rtp+=~/.vim/bundle/Vundle.vim

"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'pangloss/vim-javascript'
"Plugin 'vim-auto-save'
"Plugin 'romainl/flattened'
"Plugin 'morhetz/gruvbox'
"Plugin 'vimjas/vim-python-pep8-indent'
"Plugin 'elixir-lang/vim-elixir'
"Plugin 'stephpy/vim-yaml'
"Plugin 'mattboehm/vim-accordion'
"Plugin 'jakykong/vim-zim'
"Plugin 'articicestudio/nord-vim'
"Plugin 'zah/nim.vim'
"Plugin 'luochen1990/rainbow'
#call vundle#end()

filetype plugin indent on
syntax on

let mapleader = ";"
let localleader = ";;"

set noswapfile

"""Text settings"""
set expandtab
set textwidth=119
"set tabstop=8
"set softtabstop=4
"set shiftwidth=4
set autoindent
set number

"""Insert mode mappings"""
inoremap jj <esc>

"""Normal mode mappings"""
nnoremap <leader>r <c-r>
nnoremap <leader>h ^ 
nnoremap <leader>l $
""Search settings/mappings
set hlsearch
set incsearch
"switch off highlighting
nnoremap <leader>W :noh<cr>
""Window mappings""
nnoremap <leader>w <c-w>
nnoremap <leader>h# :sp #<cr>
nnoremap <leader>v# :vsp #<cr>
"Vim installation bindings
nnoremap <leader>pv :PluginInstall<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

set undofile
let g:auto_save = 1
let g:rainbow_active = 1
colorscheme nord 

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction
