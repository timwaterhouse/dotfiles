let mapleader = "\<Space>"
let maplocalleader = ","

set nocompatible
set encoding=utf-8

" On Windows, use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" vim-plug
"------------
" Automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

if !empty(glob("~/.local.plugins.vim"))
  source ~/.local.plugins.vim
endif

Plug 'jalvesaq/Nvim-R'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/showmarks'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
Plug 'edkolev/tmuxline.vim'
Plug 'timwaterhouse/vim-nonmem'

" vim-plug gets 403 errors for these without full URLs for some reason
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-obsession.git'

Plug 'ryanoasis/vim-devicons'

call plug#end()

" Source a global configuration file if available
if filereadable("$VIM/.vimrc")
  source $VIM/.vimrc
endif

set nocompatible                " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing
set autoindent                  " always set autoindenting on
set linebreak                   " Don't wrap words by default
set textwidth=0                 " Don't wrap lines by default
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undofile
set undodir=~/.vim/undo
set viminfo='20,\"50            " read/write a .viminfo file, don't store more than 50 lines of registers
set history=200                 " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set nrformats=
set wildmenu                    " visual autocomplete for command menu
set noerrorbells                " Disable error bells
set visualbell                  " Stop the beeps!

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

syntax on

set background=dark
let g:solarized_termtrans=1
silent! colorscheme solarized

filetype plugin on
filetype indent on

augroup misc
  autocmd!
  autocmd ColorScheme * highlight SignColumn ctermbg=8
  " Change to the directory the file in your current buffer is in
  "autocmd BufEnter * silent! lcd %:p:h
  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" The following are commented out as they cause vim to behave a lot
" different from regular vi. They are highly recommended though.
set showcmd    " Show (partial) command in status line.
set showmatch    " Show matching brackets.
set ignorecase    " Do case insensitive matching
"set smartcase
set incsearch    " Incremental search
set hlsearch
set autowrite    " Automatically save before commands like :next and :make
set lazyredraw
set cursorline          " highlight current line


set hidden
set number

" Change cursor shape in different modes
" For tmux running in iTerm2 on OS X Edit
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

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

setlocal linebreak
setlocal display+=lastline
" indenting stuff
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set cinoptions=>2s,{1s

set display=lastline  " Show incomplete paragraphs even when they don'f fit on screen (avoid @'s)

" Show trailing whitespaces
set list
set listchars=tab:▸\ ,trail:¬,nbsp:.,extends:❯,precedes:❮
augroup FileTypes
  autocmd!
  autocmd filetype html,xml set listchars-=tab:▸\
augroup END

:nmap <Leader>sv :source ~/.vimrc<CR>
:nmap <Leader>ev :e ~/dotfiles/.vimrc<CR>

" ignore white space in diff
set diffopt+=iwhite

augroup rgroup
  autocmd!
  autocmd BufNewFile,BufRead *.R set filetype=r
  autocmd BufNewFile,BufRead *.ssc set filetype=r
  autocmd FileType r :iabbrev <buffer> >> %>%
augroup end

" For old version of vim-r-plugin
" "let vimrplugin_screenplugin = 0
" "let vimrplugin_tmux = 0
" "let vimrplugin_r_path = "rlwrap /usr/pk/software/bin/R"
" let r_path = "/lrlhps/apps/R/R_latest"
" let vimrplugin_r_prefix = "rlwrap"
 let R_args = ["--no-save"]
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
" Send lines (in Normal mode) and selections to R:
vmap <LocalLeader>. <Plug>RDSendSelection
nmap <LocalLeader>. <Plug>RDSendLine
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

" fzf
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>

let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" UltiSnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
"set t_Co=256

let g:airline_powerline_fonts = 1

:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
augroup airline_config
  autocmd!
  autocmd FileType * unlet! g:airline#extensions#whitespace#checks
  autocmd FileType markdown let g:airline#extensions#whitespace#checks = [ 'indent' ]
augroup END
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_enabled = 0  " disable ALE until toggled with :ALEToggle

let g:vimtex_view_enabled = 0  " don't start PDF viewer after compiling

:nnoremap <F5> :buffers<CR>:buffer<Space>


set number                     " Show current line number
set relativenumber             " Show relative line numbers
set cc=80                      " marker for 80th column

nnoremap H 0
nnoremap L $
inoremap jk <esc>

" Use mouse and make it play nice with tmux
set mouse+=a
if !has("nvim")
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
endif

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" tmuxline options
let g:tmuxline_preset = {
      \'a'       : '#S',
      \'win'     : ['#I', '#W#F'],
      \'cwin'     : ['#I', '#W#F'],
      \'y'       : ['%Y-%m-%d', '%H:%M'],
      \'z'       : '#h',
      \'options' : {'status-justify' : 'left'}}

" NONMEM
augroup nonmem
  autocmd!
  autocmd BufNewFile,BufRead *.ctl,*.lst set filetype=nonmem
augroup END

" Perl Speaks NONMEM SCM config files
augroup psn
  autocmd!
  autocmd BufNewFile,BufRead *.scm set filetype=config
augroup END

nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

"nnoremap <leader>l :call <SID>LocationToggle()<cr>
let g:location_is_open = 0
function! s:LocationToggle()
  if g:location_is_open
    lclose
    let g:location_is_open = 0
    execute g:location_return_to_window . "wincmd w"
  else
    let g:location_return_to_window = winnr()
    lopen
    let g:location_is_open = 1
  endif
endfunction

" Source a local configuration file if available
let $LOCALFILE = expand("~/.vimrc_local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif

