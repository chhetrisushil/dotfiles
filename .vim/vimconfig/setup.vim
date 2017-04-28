" First to come, use ViM defaults and not Vi (be iMproved)
set nocompatible

" Hightlight syntax
syntax on
filetype off                   " required!
filetype plugin on
filetype plugin indent on

" set omnicomplete on
" use <C-x><C-o> for completion in insert mode
set omnifunc=syntaxcomplete#Complete
set smartindent
" show line number by default
set number
set relativenumber
" set nonumber        " don't show line numbers
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting
set tabstop=2       " tab is 2 spaces
set shiftwidth=2    " number of spaces to use for autoindenting
set expandtab       " use appropriate number of spaces when tabbing
set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase      " ignore case while search
set incsearch       " show search matches as you type
set smartcase       " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop
set noswapfile      " disable swap file creation
set history=1000    " remember more commands and search history
set undolevels=1000 " use many muchos levels of undo
set title           " change the terminal's title
set ruler           " show the cursor position all the time
set showcmd         " show current command in bottom line
set laststatus=2    " Always display the statusline in all windows
set showtabline=2   " Always display the tabline, even if there is only one tab
set noshowmode      " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set wildignore=*.swp,*.bak,*.pyc,*.class,*/migrations/*,*/blackhole__/*,*/tmp/*,*/search*/*
" set wildignore+=*/target/*,*/test-coverage/*,*/node_modules/*

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.  " highlight whitespace
set viminfo='20,\"50 " Tell vim to remember certain things when we exit

set hidden        " allow buffers to be hidden
set mouse=a      " Enable mouse support in console if you are into weird shit
set dictionary+=/usr/share/dict/words
                    " use system dictionary for auto-completion of english words

" disable auto comment insertion on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Cool tab completion stuff while entering commands
set wildmenu
set wildmode=list:longest,full
" autoread to check for changes on disk
set autoread
" set search hightlighting on
" set hlsearch

" Setting Font
" Programming Font
if has("gui_running")
  if has("gui_gtk")
    set guifont=Meslo\ LG\ S\ DZ\ Italic\ for\ Powerline\ 9
    " set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 9
    set guioptions-=m
    set guioptions-=T
  elseif has("gui_macvim")
    set guifont=Meslo\ LG\ S\ DZ\ Italic\ for\ Powerline:h12
    " set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
  elseif has("gui_win32")
    set guifont=Meslo\ LG\ S\ DZ\ Italic\ for\ Powerline:h11
    " set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
  endif
endif

colorscheme molokai
set encoding=utf-8

" Code Folding Settings
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1         " this is just what i use

" auto-reload vim once changed
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END }"


" trying vimscript
function! Myscript()
python<<EOF
import vim
try:
    import vlc
    vim.current.buffer.append("Math")
except:
    vim.current.buffer.append("No Math")
EOF
endfunction

" Press Enter to turn off highlighting and clear any message already displayed.
" nnoremap <CR> :nohlsearch<Bar>:echo<CR>

" just the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============

" just highlight the match in red...
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" Show Tab numbers
if has("gui_running")
 set showtabline=2 " always show tabs in gvim, but not vim
 " set up tab labels with tab number, buffer name, number of windows
 function! GuiTabLabel()
   let label = ''
   let bufnrlist = tabpagebuflist(v:lnum)
   " Add '+' if one of the buffers in the tab page is modified
   for bufnr in bufnrlist
     if getbufvar(bufnr, "&modified")
       let label = '+'
       break
     endif
   endfor
   " Append the tab number
   let label .= v:lnum.': '
   " Append the buffer name
   let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
   if name == ''
     " give a name to no-name documents
     if &buftype=='quickfix'
       let name = '[Quickfix List]'
     else
       let name = '[No Name]'
     endif
   else
     " get only the file name
     let name = fnamemodify(name,":t")
   endif
   let label .= name
   " Append the number of windows in the tab page
   let wincount = tabpagewinnr(v:lnum, '$')
   return label . '  [' . wincount . ']'
 endfunction
 set guitablabel=%{GuiTabLabel()}
else
 set tabline=%!MyTabLine()  " custom tab pages line
 function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ': '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
  endfunction
endif

" source custom config from home directory
" if filereadable("~/.vim.custom")
"   so ~/.vim.custom
" endif

" source custom config from current directory
" if filereadable(".vim.custom")
"   so .vim.custom
" endif
