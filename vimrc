"" Vim configuration

"" Credits:
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""   Mislav <mislav.uniqpath.com/2011/12/vim-revisited>
""

" Vim stuff
set nocompatible
filetype off
set clipboard+=unnamed

" START Vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Utils
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'wycats/nerdtree'
Bundle 'ddollar/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/ZoomWin'
Bundle 'L9'
Bundle 'tsaleh/vim-matchit'
Bundle 'godlygeek/tabular'
Bundle 'airblade/vim-gitgutter'
Bundle 'henrik/git-grep-vim'
Bundle 'henrik/vim-qargs'
Bundle 'Sirupsen/vim-execrus'
Bundle 'kien/ctrlp.vim'

" Syntaxes
Bundle 'tpope/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-rails'
Bundle 'taq/vim-rspec'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/html5.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'jnwhiteh/vim-golang'

" Themes
Bundle 'tpope/vim-vividchalk'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nanotech/jellybeans.vim'
Bundle 'mnoble/tomorrow-night-vim'
Bundle 'apeacox/vim-distinguished'
Bundle 'tomasr/molokai'

" END Vundle setup

" Editing
filetype plugin indent on

syntax enable
set encoding=utf-8
set fenc=utf-8
set number
set ruler
let mapleader=","
set mouse=a                       " enable mouse support
set visualbell                    " No beeping.

" Load local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Backups and swap files
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup

" Color scheme
" xterm not recognized right by vim (but not on Linux)
" set term=xterm
set t_Co=256
set background=dark
colorscheme distinguished

" When using tmux/screen, $TERM should be set to screen-256color. this is a
" fix to use arrow keys correctly
if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

set wrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
set scrolloff=3                   " provide some context when editing
set backspace=indent,eol,start    " allow backspacing over everything in insert mode

" Go with smartindent if there is no plugin indent file.
" set autoindent smartindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2
set showcmd                       " Display incomplete commands.

set showmode                      " Display the mode you're in.
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.

" ZoomWin
map <Leader><Leader> :ZoomWin<CR>
" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map \\ :NERDTreeToggle<CR>

"close NERDTree if open and delete current buffer
function! BufferCloser()
  NERDTreeClose
  :bdelete
endfunction
:noremap <C-D> :call BufferCloser()<CR>

" NERD_commenter
nmap <leader><space> <plug>NERDCommenterComment
nmap <leader>cc <plug>NERDCommenterToggle

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <Leader>brt :!bundle list --paths=true \| xargs ctags --extra=+f --exclude=.git --exclude=log -R *<CR><CR>

" git status bar plugin
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" gitgutter
let g:gitgutter_enabled = 0

" EasyGrep
" use system grep instead of vimgrep
let g:EasyGrepCommand=1

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
endfunction

function! s:clearWhitespaces()
  ma a
  :%s/\s\+$//e
  'a
endfunction

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " automatically clear whitespaces owhen saving buffer
  au BufWritePre * :call s:clearWhitespaces()

  " set ff=unix
  au BufRead,BufNewFile * :set ff=unix

  " use relative numbers when in insert mode
  autocmd InsertEnter * :set relativenumber
  autocmd InsertLeave * :set number
endif

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" Use modeline overrides
set modeline
set modelines=10

" hide highlited search
nmap <silent> <C-N> :silent noh<CR>

" re-indent entire file
map   <silent> <F5> mmgg=G'm
imap  <silent> <F5> <Esc> mmgg=G'm
vmap  <tab> =
nmap  <tab> ==

" navigate buffers
noremap <S-left> :bprev<CR>·
noremap <S-right> :bnext<CR>

" disable arrow keys, use hjkl
noremap  <Up> ""
noremap  <Down> ""
noremap  <Left> ""
noremap  <Right> ""

" navigate split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" FuzzyFinder (was CommandT) [DEPRECTED?]
" map <Leader>t :FufCoverageFile<CR>

" CtrlP
map <Leader>. :CtrlP<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlPMixed'

" toggle git gutter
map <Leader>g :ToggleGitGutter<CR>

" ignore Rubinius, Sass cache files
set wildignore+=*.rbc,*.scssc,*.sassc

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Execrus
map <C-E> :call g:Execrus()<CR>
map <C-\> :call g:Execrus('alternative')<CR>

" if has("gui_macvim")
if  has("gui_running")
	source ~/.vim/mvimrc
endif
