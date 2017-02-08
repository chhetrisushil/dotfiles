" change the mapleader from \ to ,
let mapleader=","

" Toggle line number
map <leader>ln :setlocal number!<CR>

" Toggle paste mode
map <leader>o :set paste!<CR>

" forward cycling through tabs
map <C-Tab> gt
" backward cycling through tabs
map <C-S-Tab> gT

" key mapping to switch between the split buffers
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-u> <C-w>l

" Move current line up and down normal mode
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==

" Move current line up and down insert mode
inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi

" Move selected block up and down Visual mode
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

" shortcut to close buffer
map Q :q!<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Cycle through buffers
map <c-b> :CtrlPBuffer<CR>
" Search for text through open buffer
map <leader>/ :CtrlPLine<CR>

" Ack key binding
" Open a new tab before searching through the project
map <leader>a :tab split<CR>:Ack ""<Left>
" Search for the word under the cursor in new tab
map <leader>A :tab split<CR>:Ack <C-r><C-w><CR>

" Insert Mode Mapping
imap jj <Esc>

" append semi-colon at the end
inoremap ;<cr> <end>;

inoremap )) <ESC>f)i<Right>

" Normal Mode Mapping
" open vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR> 
" open gvimrc
nmap <silent> <leader>eg :e $MYGVIMRC<CR> 

" source vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" source gvimrc
nmap <silent> <leader>sg :so $MYGVIMRC<CR>

" set syntax highlighting to javascript
nmap <silent> <leader>js :set syntax=javascript<CR>

" formatter for javascript files
nmap <silent> <leader>fj :call JsBeautify()<CR>
" formatter for HTML files
nmap <silent> <leader>fh :call HtmlBeautify()<CR>
" formatter for CSS files
nmap <silent> <leader>fc :call CSSBeautify()<CR>
" jsdoc shortcut
nmap <silent> <leader>jsd <Plug>(jsdoc)

" toggle NERDTree
nmap <silent> <C-D> :NERDTreeToggle<CR>

" toggle Tagbar
nmap <F8> :TagbarToggle<CR>

" toggle syntastic checker
nmap <F3> :SyntasticToggleMode<CR>

" Faster switching to tabs (works in gvim) (Eg. alt+1 goes to tab 1)
nmap <M-1> :tabnext 1<CR>
nmap <M-2> :tabnext 2<CR>
nmap <M-3> :tabnext 3<CR>
nmap <M-4> :tabnext 4<CR>
nmap <M-5> :tabnext 5<CR>

" nmap gmail :!vmail<CR>
" nmap bash :ConqueTermSplit bash<CR>
" nmap python :ConqueTermSplit ipython<CR>

" Magically move up and down in the same wrapped line!
noremap j gj
noremap k gk

noremap <silent> <C-S> :update<CR>
noremap <silent> <C-N> :tabnew<CR>

noremap <C-L> :nohl<CR><C-L>

" save keystroke
nnoremap ; :

" Arrow keys are evil
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Visual Move Mapping
" put bracket/quotes around the selected text
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
vnoremap { <ESC>`>a}<ESC>`<i{<ESC>
vnoremap ) <ESC>`>a)<ESC>`<i(<ESC>
vnoremap } <ESC>`>a}<ESC>`<i{<ESC>
vnoremap " <ESC>`>a"<ESC>`<i"<ESC>
vnoremap ' <ESC>`>a'<ESC>`<i'<ESC>

" Command-line Mapping
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Save file as root from vim
cmap w!! w !sudo tee % >/dev/null

"match OverLength /\%81v.\+/
highlight OverLength ctermbg=red ctermfg=white guibg=#592929

" mapped <F5> to display error in quickfix window
function! ToggleQuickFix()
  if exists("g:qwindow")
    lclose
    unlet g:qwindow
  else
    try
      Errors
      let g:qwindow = 1
    catch
      echo "No Errors found!"
    endtry
  endif
endfunction
nmap <script> <silent> <F5> :call ToggleQuickFix()<CR>

" Toggle Maximize
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

nnoremap <C-o>z :call MaximizeToggle()<CR>

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" Mapping to open register
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
inoremap <A-b> <C-o>b
inoremap <A-w> <C-o>w
