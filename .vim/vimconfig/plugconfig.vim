" CtrlP config
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" vim-angular mapping
imap <C-c> <CR><Esc>O

" autoformat mapping
noremap <F2> :Autoformat<CR>

" mustache/handlebars config
let g:mustache_abbreviations = 1

" ctags config
" let g:easytags_autorecurse = 1
" let g:easytags_by_filetype = "~/.tags"

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Emmet for html and css tag/selector completion config
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" javacompelte2 config and mapping
if has("autocmd")
  autocmd! Filetype java setlocal omnifunc=javacomplete#Complete
  autocmd! Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
endif

nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

" Actionscript support
" filetype association for actionscript
autocmd FileType actionscript set omnifunc=actionscriptcomplete#CompleteAS

" dictionary for actionscript
autocmd FileType actionscript :set dictionary=~/.vim/dict/actionscript.dict

" Vim Local History
let g:vlh_repository_dir = "~/.vim/localhistory"

" Vim Local History
" let g:historicBackupRepoLocation = "~/.vim/localhistory"

let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
let g:AutoPreview_enabled =1
let g:AutoPreview_allowed_filetypes = ["c","cpp"]
let g:email = "chhetrisushil@gmail.com"
let g:username = "Sushil Chhetri"
" let NERDTreeIgnore = ['\.pyc$']
" let g:clang_library_path = '/usr/lib/libclang.so'
" let g:clang_debug = 1
" let g:clang_user_options='|| exit 0'

" NERDTree Tab config
" disabling default enable use NERDTreeTabsOpen instead
" let g:nerdtree_tabs_open_on_console_startup=1
" let g:nerdtree_tabs_open_on_gui_startup=0

" JsHint error indicator
hi SpellBad cterm=underline,bold ctermbg=white ctermfg=black

" Autocompletion menu colors
hi Pmenu ctermfg=black ctermbg=white
hi PmenuSel ctermfg=black ctermbg=yellow

" vim-session config
let g:session_autosave='yes'
let g:session_autosave_periodic=3
let g:session_autosave_silent=1
let g:session_autosave_to=$VI_SERVER

" Paste from history key mappings
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" misc config
let g:tlist_javascript_settings='javascript;r:var;s:string;a:array;o:object;u:function'


" closetag.vim plugin config
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml,*.jsp"


" cosco.vim mappings
autocmd FileType javascript,css,YOUR_LANG nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css,YOUR_LANG imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)

" vim-airline config
let g:Powerline_symbols="unicode"
let g:airline_powerline_fonts=1

" vim-airline theme
let g:airline_theme='lucius'

" color scheme
colorscheme gruvbox

" ack.vim config to remap to ag (silver searcher)
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" disable vimwiki filetype for global md files.
let g:vimwiki_global_ext = 0
