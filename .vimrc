

" NERD TREE " {{{
" notes:
"
" o       Open selected file, or expand selected dir               
" go      Open selected file, but leave cursor in the NERDTree     
" t       Open selected node in a new tab                          
" T       Same as 't' but keep the focus on the current tab        
" <tab>   Open selected file in a split window                     
" g<tab>  Same as <tab>, but leave the cursor on the NERDTree      
" !       Execute the current file                                 
" O       Recursively open the selected directory                  
" x       Close the current nodes parent                           
" X       Recursively close all children of the current node       
" e       Open a netrw for the current dir                         

" default <leader> is '\'
"--------------------------------------------------------------------------------------
map <leader>e :NERDTreeToggle<CR>
an 50.20 &View.File\ Viewer<Tab><F5> <ESC>:NERDTreeToggle<CR>
map <F5> <ESC>:NERDTreeToggle<CR> " Toggles NERD Tree view (file viewer)an 50.20 &View.File\ Viewer<Tab><F5> <ESC>:NERDTreeToggle<CR>
map <F5> <ESC>:NERDTreeToggle<CR> " Toggles NERD Tree view (file viewer)
"--------------------------------------------------------------------------------------

"}}}


let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
"set background=light
set background=dark

" ------------------------------------------------------------------------------
"  Color setting
" ------------------------------------------------------------------------------
" {{{
"colorscheme miko
"set t_Co=256
"colorscheme torte
"colorscheme maroloccio
" Yes, it show the magic
" http://mike.bailey.net.au/2011/02/making-vim-look-like-textmate-again/
" ref : http://www.vim.org/scripts/script.php?script_id=3436 (twlight color scheme)
colorscheme twilight256
" ref http://www.vim.org/scripts/script.php?script_id=2340
" colorscheme molokai
" let g:molokai_original = 0
" let g:molokai_original = 1
" Color scheme scroll plugin
" ref http://www.vim.org/scripts/script.php?script_id=1488
" Color scheme pack
" http://www.vim.org/scripts/script.php?script_id=625
" colorscheme wombat

syntax on                  "turns on syntax highlighting
" }}}


" ------------------------------------------------------------------------------
"  Editor setting
" ------------------------------------------------------------------------------
" {{{
set number
set incsearch

set hlsearch			   "Highlight searach
set smarttab               "Uses shiftwidth instead of tabstop at start of lines
set tabstop=4              "4 space tab
set shiftwidth=4           "The amount to block indent when using < and >
set softtabstop=4          "Causes backspace to delete 4 spaces = converted <TAB>
set backspace=indent,eol,start
"set bs=2                   "Default backspace like normal

set foldmethod=syntax      " Marker
set foldnestmax=10


" Tab settings, ref:
" http://mateusz.loskot.net/2005/11/06/vim-indentation-for-c-cpp-explained/
set expandtab    "Use this option if you want every TAB to be expanded to spaces.
"set smarttab     "set TAB command shifts line to right and BACKSPACE shifts line to left
"set softtabstop  "interpret TAB as an indent command instead of insert-a-TAB command.
"set tabstop      "it instructs Vim how many space characters Vim counts for every TAB command. 

"set cin                    "C indent
"set autoindent             "always set autoindenting on
set smartindent            " Automatically indents a new line to the same indentation used by previous line 
filetype indent on         "new in vim 6.0+; file type specific indenting

"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 
set guifont=Monaco:h9:cANSI

set showmatch              "Show matching parenthese.

set completeopt=longest,menu "Avoid poping up scratch/preview window for OmniCppComplete (AutoComplete)

" Donot jump to TabBar windows. Always jump to below window of TabBar
autocmd! BufEnter * nested call Test()
func! Test()
    if bufname("%") == "-TabBar-"
        wincmd j
    endif
endfunction
" let g:Tb_VSplit = 1
let g:Tb_MinSize = 1
let g:Tb_MaxSize = 2
let g:Tb_TabWrap = 1
" }}}


map<F1> :tabprev<CR>
map<F2> :tabnext<CR>

map<F5> :e!<CR>

"map <F6> <ESC>:TlistToggle<CR>:wincmd p <CR>
"map <F9> <ESC>:wincmd p<CR>

nmap <silent> <C-N> :silent noh<CR>

highlight Search ctermfg=White ctermbg=Red cterm=NONE

set tags  =./tags,../tags,../../tags,../../../tags
set tags +=~/.vim/stl_tags

"map <F11> :q!<CR>
"map <F10> :w<CR>
"map <F12> :wq<CR>

hi Folded ctermfg=blue ctermbg=255


autocmd BufEnter * let &titlestring = expand("%:t")
if &term == "screen"
	set t_ts=k
	set t_fs=\
	set title
endif
"if &term != "builtin_gui"
"	let &titleold = substitute(getcwd(), "/home/pokia", "~", "g")
	"let &titleold = "`basename ${PWD}"
	"substitute(system("uname"),'\(.*\)\n','%\1%','')
"	set title
"endif


" This is to active AutoComplete
set nocp
filetype plugin on

" This is color setting for AutoComplete
:hi PmenuSel   ctermfg=Black   ctermbg=White cterm=Bold guifg=White guibg=DarkBlue gui=Bold
":hi Pmenu      ctermfg=Cyan    ctermbg=Blue cterm=None guifg=Cyan guibg=DarkBlue
":hi PmenuSel   ctermfg=White   ctermbg=Blue cterm=Bold guifg=White guibg=DarkBlue gui=Bold
":hi PmenuSbar                  ctermbg=Cyan            guibg=Cyan
":hi PmenuThumb ctermfg=White                           guifg=White

"Support vim paste code from webpages
" set pastetoggle=<F3>
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

" This highlights the background in a subtle red for text that goes over the 80
" column limit 
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
" match OverLength /\%81v.\+/
" match OverLength /\%>81v.\+/
"  match OverLength /\%>80v.\+/ ctermbg=red ctermfg=white guibg=#592929
"	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/


" Column limit
"if exists('+colorcolumn')
"	set colorcolumn=80
"else
"    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"    match OverLength /\%>80v.\+/ 
"	set columns=76
"	set textwidth=80
"	set number=80
"	set numberwidth=80
"else
"	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Label with red background for exceeding column limits
"if exists('+colorcolumn')
"	set colorcolumn=80
"else
"    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"    match OverLength /\%>80v.\+/ 
"endif
"
"


"let $VIM = '/home/chiahsun/.vim/'
"let $OCAMLSPOTVIMRC = '/home/chiahsun/.vim/ocamlspot.vim'
"if filereadable ($OCAMLSPOTVIMRC)
"	source ($OCAMLSPOTVIMRC)
"endif

" set rtp+=~/.vam/vim-addon-manager
" call vam#ActivateAddons(["AutoComplPop"])
"call vam#ActivateAddons([AutoComplPop], {'auto_install' : 0})
"set g:vim_addon_manager.source_missing_plugins = 0
" call vam#ActivateAddons(["FuzzyFinder"])
" call vam#ActivateAddons(["AutoComplPop"])
" let scm['jscomplete-vim'] = {'type': 'git', 'url': 'git://github.com/teramako/jscomplete-vim'}
"set nocompatible
" put this line first in ~/.vimrc
au BufRead,BufNewFile *.g set syntax=antlr3
au BufRead,BufNewFile *.g4 set syntax=antlr3

" tmux automatic renaming
" autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window" expand("%:t"))
" au BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title
