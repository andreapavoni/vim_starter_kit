" color vwilight
" set guifont=Menlo\ Regular:h14
" set linespace=2
set antialias

" Default gui color scheme
set background=dark
colorscheme vividchalk

" Don't beep
set visualbell

set guioptions-=T "remove toolbar
set guioptions-=r " remove right scrollbar
set guioptions-=m " remove menubar

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
end

" Include gvim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif

" ConqueTerm wrapper
function StartTerm()
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \
endfunction

" Project Tree
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  if directory
    " NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

