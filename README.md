dotfiles
========
This repo is just to store my dot config files for example .vimrc etc

reference: https://github.com/sagarrakshe/dotvim, https://github.com/sagarrakshe/dotfiles

## Autolock 'alock'
install alock from https://github.com/chhetrisushil/alock

## Drop-down terminal 'yakuake'
install 'yakuake' for drop-down terminal

## mpv for mac os
- Install `mpv` for mac os using brew run the following command `brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/mpv.rb`

## Nerd font
- Install nerd font from https://github.com/ryanoasis/nerd-fonts#font-installation
- Install nerd devicons for fancy nerd tree icons https://github.com/ryanoasis/vim-devicons#installation
- Install `Meslo LG S Italic for Powerline Nerd Font.ttf` font to the system for linux
- For linux place the font in `/usr/share/font/` folder and rebuild the font cache `fc-cache -f -v`
- For Mac install font from `./mac-Meslo-Nerd-Font/Meslo LG S Italic for Powerline Nerd Font.ttf`

## Powerline font for 'agnoster' zsh theme and vim-airline
- Install powerline font from https://github.com/powerline/fonts
- set the font `Meslo LG S DZ for Powerline` in the terminal (_italic_ preferably)

## cobalt2 zsh-theme for iterm
- Follow the instruction in this repo https://github.com/wesbos/Cobalt2-iterm

## Instant markdown for instant preview
- Follow install instructions from https://github.com/suan/vim-instant-markdown

## Install ack-grep for ack.vim support
- Run command `sudo apt-get install ack-grep` to install ack. _symlink ack-grep to ack if needed_`ln -s /usr/bin/ack-grep /usr/bin/ack`

## For fish like auto completion in zsh
- Install zsh-autosuggestions from https://github.com/zsh-users/zsh-autosuggestions
- Run the following command `git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions`
- Plugin is already mapped in `.zshrc` file

## Install xcape to map Caps_Lock to ctrl (on long press) and esc (on tap)
- Try `sudo apt-get install xcape` first (ubuntu 15 and above)
- Install xcape from https://github.com/alols/xcape before setting up the environment

## Install `jsctags` for javascript ctags
- `jsctags` for ctags generation for vim read more at https://www.npmjs.com/package/jsctags
- Run the following command to create tags file `find <path to directory containing javascript files> -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > tags`
- set the tags option to the tag file in local.vim e.g. `set tags+=./tags`

## Install the_silver_searcher
- Install `the_silver_searcher` which is aliased to command `ag` for searching
- `ag` is also used in vim config for inside vim searching
- Repo for the_silver_searcher https://github.com/ggreer/the_silver_searcher

## Install `elm-format`
- Install `elm-format` by running command `npm i -g elm-format`
- Repo for `elm-format` as reference: https://github.com/avh4/elm-format
- `elm-format` is enabled for vim on save

## Install `elm`
- Install `elm` by running `npm i -g elm`
- Elm reference site https://guide.elm-lang.org/
- Introduciton to Elm https://www.gitbook.com/book/evancz/an-introduction-to-elm/details

## Neovim setup
- Copy `nvim` folder to `~/.config`
- NOTE: vim's `.vim` folder and `.vimrc` should alredy be setup before copying nvim folder

**NOTES:** 
  - Before setting up vim copy `.vim` folder to `~/.vim`
  - Install `typescript` `dtsm` `typings` by running `sudo npm install -g typescript dtsm typings` for typescripts plugin to work properly
  - location of most of the config is HOME directory (i.e. ~/) except for .gitconfig which resides in the project directory
  - location for `.ackrc` is home directory (i.e. ~/) e.g. `~/.ackrc`
  - Keep colors folder inside `~/.vim` folder
  - Create a ".tags" folder in home directory
  - Run npm install after installing tern plugin
  - Run git submodule update --init --recursive in vim-jsbeautify plugin folder
  - Map actionscript.dict in .vimrc properly
  - Path to xmonad.desktop `/usr/share/xsessions/xmonad.desktop`
  - Ultisnips to work create a directory `mkdir -p ~/.vim/ftdetect` and run this command `ln -s ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect/`
  - `jsctags` for ctags generation for vim read more at https://www.npmjs.com/package/jsctags
  - use https://github.com/gpakosz/.tmux for tmux configuration
  - set locale to utf8 in linux for powerline fonts to work properly in tmux, run `sudo localectl set-locale LANG="en_IN.utf8"`, choose utf8 locale by running `localectl list-locales`. Once the locale is set a reboot is required.
  - Install `eslint`, run `npm install -g eslint`
  - `.tmux/` folder is customized copy of `oh-my-tmux`
  - install `reattach-to-user-namespace` in macos for tmux and clipboard binding and `xclip` for Linux
