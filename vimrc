set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'noahfrederick/Hemisu'
Plugin 'fatih/molokai'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'bling/vim-airline'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'wting/rust.vim'
Plugin 'fatih/vim-go'
Plugin 'mxw/vim-jsx'
Plugin 'rking/ag.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()

filetype plugin indent on

set noerrorbells visualbell
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set smartindent smarttab smartcase
set number
set nowrap
set lazyredraw
set hidden
set title
set mouse=

" fkn .swp
set backupdir=~/dotfiles/vim-tmp
set undodir=~/dotfiles/vim-tmp
set directory=~/dotfiles/vim-tmp

let mapleader=";"
map K <Nop>
map Y y$
map <silent> <Leader>s :nohlsearch<CR>
map <silent> <Leader>p :set paste!<CR>
map <silent> <Leader>n :set number!<CR>
cmap %/ <C-R>=expand("%:p:h")."/"<CR>
cmap %% <C-R>=expand("%")<CR>

noremap <leader>t :CtrlP<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>d :NERDTreeToggle<CR>
noremap <leader>f :NERDTreeFind<CR>
noremap <leader>a :Ag<space>

" powerline fonts suck.
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''

" colors
colorscheme molokai
set background=dark
