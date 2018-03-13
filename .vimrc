let mapleader = ","

set nocompatible

" vim-plug
"------------
call plug#begin('~/.vim/plugged')

"Plug 'scrooloose/nerdtree'
Plug 'jalvesaq/Nvim-R'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/showmarks'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'bling/vim-airline'

" vim-plug gets 403 errors for these without full URLs for some reason
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-obsession.git'

call plug#end()

" Source a global configuration file if available
if filereadable("$VIM/.vimrc")
  source $VIM/.vimrc
endif

set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

set autoindent	" always set autoindenting on
set linebreak		" Don't wrap words by default
set textwidth=0		" Don't wrap lines by default
set backup
set backupdir=~/vimtmp,.
set directory=~/vimtmp,.
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
" 50 lines of registers
set history=200		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set nrformats=
set wildmenu            " visual autocomplete for command menu

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

syntax on
au BufNewFile,BufRead *.R set filetype=r
au BufNewFile,BufRead *.ssc set filetype=r
au BufNewFile,BufRead *.scm set filetype=config


set background=light
colorscheme solarized

highlight SignColumn ctermbg=8
autocmd ColorScheme * highlight SignColumn ctermbg=8

if has("autocmd")
  filetype plugin on
  filetype indent on
  " Change to the directory the file in your current buffer is in
  " autocmd BufEnter * silent! lcd %:p:h
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif " has ("autocmd")

set autochdir

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*		set ft=mail
  au BufRead reportbug-*		set ft=mail
augroup END

" The following are commented out as they cause vim to behave a lot
" different from regular vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase
set incsearch		" Incremental search
set hlsearch
set autowrite		" Automatically save before commands like :next and :make
set lazyredraw
set cursorline          " highlight current line


set hidden
set number

map <silent> <up> gk
imap <silent> <up> <C-o>gk
map <silent> <down> gj
imap <silent> <down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <end> g<end>
imap <silent> <end> <C-o>g<end>

:map <C-Tab> :bn<CR>
:map <C-S-Tab> :bp<CR>

" Allow <C-p> and <C-n> to filter command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" mute search highlighting
noremap <silent> <C-l> :<C-u> nohlsearch <CR><C-l>

setlocal linebreak
setlocal nolist
setlocal display+=lastline
" indenting stuff
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set cinoptions=>2s,{1s

set display=lastline	" Show incomplete paragraphs even when they don'f fit on screen (avoid @'s)

:nmap <Leader>sv :source ~/.vimrc<CR>
:nmap <Leader>ev :e ~/.vimrc<CR>

" ignore white space in diff
set diffopt+=iwhite

" For old version of vim-r-plugin
" "let vimrplugin_screenplugin = 0
" "let vimrplugin_tmux = 0
" "let vimrplugin_r_path = "rlwrap /usr/pk/software/bin/R"
" let r_path = "/lrlhps/apps/R/R_latest"
" let vimrplugin_r_prefix = "rlwrap"
 let R_args = "--no-save"
" let vimrplugin_vimpager = "vertical"
 let r_indent_align_args = 0
" let vimrplugin_assign = 0
let R_assign = 0

"syntax enable

" Lines added by the Vim-R-plugin command :RpluginConfig (2014-Jun-01 23:00):
" Use Ctrl+Space to do omnicompletion:
if has("nvim") || has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
"
"imap <C-x><C-x> <Plug>RCompleteArgs

" Force Vim to use 256 colors if running in a capable terminal emulator:
if &term =~ "xterm" || &term =~ "256" || $DISPLAY != "" || $HAS_256_COLORS == "yes"
    set t_Co=256
endif

set nofoldenable

let marksCloseWhenSelected = 0
let showmarks_include = "abcdefghijklmnopqrstuvwxyz"

set timeoutlen=1000 ttimeoutlen=50

let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" UltiSnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

set encoding=utf-8

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
"set t_Co=256

let g:airline_powerline_fonts = 1

:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
autocmd FileType * unlet! g:airline#extensions#whitespace#checks
autocmd FileType markdown let g:airline#extensions#whitespace#checks = [ 'indent' ]
let g:airline#extensions#tabline#enabled = 1

:nnoremap <F5> :buffers<CR>:buffer<Space>


set number                     " Show current line number
set relativenumber             " Show relative line numbers
set cc=80                      " marker for 80th column

nnoremap H 0
nnoremap L $
inoremap jk <esc>

