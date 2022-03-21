" Start plugins definition
call plug#begin($HOME.'/.vim/bundle')

Plug 'jiangmiao/auto-pairs'
Plug 'Lokaltog/vim-easymotion'
Plug 'davidhalter/jedi-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/neocomplcache.vim'

" Dev icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'ervandew/supertab'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/taglist.vim'
Plug 'aperezdc/vim-template'
Plug 'vim-scripts/tComment'

" Git Plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

Plug 'pelodelfuego/vim-swoop'
Plug 'gko/vim-coloresque'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dylanaraps/wal.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'mrinterweb/vim-visual-surround'
Plug 'milkypostman/vim-togglelist'
Plug 'preservim/tagbar'
Plug 'sagarrakshe/ack.vim'
" Plug 'jceb/vim-orgmode'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'pangloss/vim-javascript'

" Paste from history
Plug 'maxbrunsfeld/vim-yankstack'

Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Chiel92/vim-autoformat'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" Plug 'lambdatoast/elm.vim'
" Plug 'ElmCast/elm-vim'
Plug 'vimwiki/vimwiki'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Emmet for html and css tag/selector completion
Plug 'mattn/emmet-vim'

Plug 'artur-shaik/vim-javacomplete2'

" Javascript ES6 syntax support
Plug 'isRuslan/vim-es6'

" Node support
Plug 'moll/vim-node'

" Calendar
Plug 'itchyny/calendar.vim'

" Vim Local History
" Note: install 'spec' and 'rspec' (rspec version 1.3.1)
" using command 'sudo gem install spec' and 'sudo gem install rspec -v 1.3.1'
Plug 'hjdivad/vimlocalhistory'

" Markdown Plugins
Plug 'suan/vim-instant-markdown'

"Display indentation level
Plug 'Yggdroot/indentLine'

" Plugin execute make on project root from anywhere
Plug 'airblade/vim-rooter'

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

" telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" lsp plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim6.0' }
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'onsails/lspkind-nvim'

Plug 'github/copilot.vim'

" which-key
Plug 'folke/which-key.nvim'

" terminal plugin
Plug 'akinsho/toggleterm.nvim'

" trouble
Plug 'folke/trouble.nvim'

" show context using treesitter
Plug 'romgrk/nvim-treesitter-context'

" nvim tree
Plug 'kyazdani42/nvim-tree.lua'

" neovim greeter
Plug 'goolord/alpha-nvim'

" focus the code you are editing with limelight
Plug 'junegunn/limelight.vim'

" rust support
Plug 'simrat39/rust-tools.nvim'

" git lens
Plug 'APZelos/blamer.nvim'

call plug#end()
