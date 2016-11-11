dotfiles
========
This repo is just to store my dot config files for example .vimrc etc

reference: https://github.com/sagarrakshe/dotvim, https://github.com/sagarrakshe/dotfiles

## Autolock 'alock'
install alock from https://github.com/chhetrisushil/alock

## Drop-down terminal 'yakuake'
install 'yakuake' for drop-down terminal

## Nerd font
- Install nerd font from https://github.com/ryanoasis/nerd-fonts#font-installation
- Install nerd devicons for fancy nerd tree icons https://github.com/ryanoasis/vim-devicons#installation

## Instant markdown for instant preview
- Follow install instructions from https://github.com/suan/vim-instant-markdown

## Install ack-grep for ack.vim support
- Run command `sudo apt-get install ack-grep` to install ack. _symlink ack-grep to ack if needed_`ln -s /usr/bin/ack-grep /usr/bin/ack`

**NOTES:** 
  - location of most of the config is HOME directory (i.e. ~/) except for .gitconfig which resides in the project directory
  - Keep colors folder inside `~/.vim` folder
  - Create a ".tags" folder in home directory
  - Run npm install after installing tern plugin
  - Run git submodule update --init --recursive in vim-jsbeautify plugin folder
  - Map actionscript.dict in .vimrc properly
  - Path to xmonad.desktop `/usr/share/xsessions/xmonad.desktop`
  - Ultisnips to work create a directory `mkdir -p ~/.vim/ftdetect` and run this command `ln -s ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect/`
