set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" :PluginInstall to install

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/twilight256.vim'
Plugin 'goodell/vim-mscgen'
Plugin 'pearofducks/ansible-vim'

call vundle#end()

colorscheme twilight256

filetype plugin indent on
filetype plugin on
syntax on

set t_Co=256
set background=dark

" Make backspace work
set backspace=indent,eol,start

set hlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent                                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set ts=4 sw=4 et

" vnoremap // y/<C-R>"<CR>
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

