" Start plugins definition
call plug#begin($HOME.'/.vim/bundle')

Plug 'jiangmiao/auto-pairs'
Plug 'Rip-Rip/clang_complete'
Plug 'wincent/Command-T'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'davidhalter/jedi-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/neocomplcache.vim'

" Nerd tree plugin
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'

Plug 'ervandew/supertab'
" Plug 'scrooloose/syntastic'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/taglist.vim'
Plug 'aperezdc/vim-template'
Plug 'vim-scripts/tComment'

" Git Plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'pelodelfuego/vim-swoop'
Plug 'gko/vim-coloresque'
" Plug 'Lokaltog/vim-powerline'
" Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dylanaraps/wal.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'mrinterweb/vim-visual-surround'
Plug 'beyondmarc/opengl.vim'
Plug 'vim-scripts/TwitVim'
Plug 'vim-scripts/a.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'majutsushi/tagbar'
" Plug 'mileszs/ack.vim'
Plug 'sagarrakshe/ack.vim'
Plug 'jceb/vim-orgmode'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'

" Paste from history
Plug 'maxbrunsfeld/vim-yankstack'

" Plug 'beautify-web/js-beautify'
Plug 'maksimr/vim-jsbeautify'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'burnettk/vim-angular'
Plug 'sotte/presenting.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'marijnh/tern_for_vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'kchmck/vim-coffee-script'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" Plug 'xolox/vim-easytags'
Plug 'juneedahamed/svnj.vim'
" Plug 'lambdatoast/elm.vim'
Plug 'ElmCast/elm-vim'
Plug 'vimwiki/vimwiki'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Emmet for html and css tag/selector completion
Plug 'mattn/emmet-vim'

Plug 'artur-shaik/vim-javacomplete2'

" Javascript ES6 syntax support
Plug 'isRuslan/vim-es6'

" Node support
Plug 'moll/vim-node'

" Actionscript support
Plug 'jeroenbourgois/vim-actionscript'

" Calendar
Plug 'itchyny/calendar.vim'

" Vim Local History
" Note: install 'spec' and 'rspec' (rspec version 1.3.1)
" using command 'sudo gem install spec' and 'sudo gem install rspec -v 1.3.1'
Plug 'hjdivad/vimlocalhistory'

" Vim Local History
" Plug 'serby/vim-historic'

" Markdown Plugins
Plug 'suan/vim-instant-markdown'

"Display indentation level
Plug 'Yggdroot/indentLine'

" Plugin execute make on project root from anywhere
Plug 'airblade/vim-rooter'

" Interactive command execution in Vim
Plug 'Shougo/vimproc.vim', {'do': 'make'}

" Unite plugin
Plug 'Shougo/unite.vim'

" Typescript plugins
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jason0x43/vim-js-indent'
Plug 'Quramy/vim-dtsm'
Plug 'mhartington/vim-typings'

" auto tag closing plugin
Plug 'alvan/vim-closetag'

" adding semi-colon and command
Plug 'lfilho/cosco.vim'

" color scheme plugin
Plug 'trevordmiller/nova-vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'

" tag jump in new tab
Plug 'ipod825/TagJump'

call plug#end()
