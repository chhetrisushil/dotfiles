#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ ! $DISPLAY && $(tty) = /dev/tty1 ]]; then
	exec startx
fi
. "$HOME/.cargo/env"
