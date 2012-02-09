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
syntax enable
set encoding=utf-8
set fenc=utf-8
set number
set ruler
let mapleader=","
set mouse=a                       " enable mouse support

" Load local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

set visualbell                    " No beeping.
" xterm not recognized right by vim (but not on Linux)
set term=xterm
"set term=builtin_ansi

" Backups and swap files
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup

" Color scheme
set t_Co=256
set background=dark
colorscheme darkblue

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'pangloss/vim-javascript'
Bundle 'wycats/nerdtree'
Bundle 'ddollar/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-rails'
Bundle 'taq/vim-rspec'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'othree/html5.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'sjbach/lusty'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/ZoomWin'
" Bundle 'wincent/Command-T'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'tsaleh/vim-matchit'


" Editing
filetype plugin indent on
set wrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
set scrolloff=3                   " provide some context when editing
set backspace=indent,eol,start    " allow backspacing over everything in insert mode

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

" Command-T
" let g:CommandTMaxHeight=20

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" git status bar plugin
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P


function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
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

  " use relative numbers when NOT in insert mode
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
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
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

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
:noremap <C-left> :bprev<CR>·
:noremap <C-right> :bnext<CR>

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

" ConqueTerm
map <Leader>co :ConqueTerm zsh<CR>

" LustyBuffer Explorer
map <Leader>l :LustyBufferExplorer<CR>

" CommandT
" map <Leader>t :CommandT<CR>
map <Leader>t :FufCoverageFile<CR>

" ignore Rubinius, Sass cache files
set wildignore+=*.rbc,*.scssc,*.sassc

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>
