# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export EDITOR="vim"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git svn mercurial zsh-autosuggestions zsh-syntax-highlighting zsh-z)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/.cabal/bin:/usr/local/go/bin:$HOME/.local/bin:$PATH"
export TERM=xterm-256color
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# load local alias files
if [[ -f ~/.zshrc_local && -r ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="vim"
alias tpOff="synclient TouchpadOff=1"
alias tpOn="synclient TouchpadOff=0"
alias ltp="alock -bg none -c glyph"
alias lbg="alock -bg image:file=$LOCK_BG -c glyph"
alias soff="xset dpms force off"

# function lock-screen-tp {
#   ltp
# }
# 
# function lock-screen-bg {
#   lbg
# }
# 
# zle -N lock-screen-tp
# zle -N lock-screen-bg
# 
# bindkey '^[^L' lock-screen-bg
# bindkey '^[^T' lock-screen-tp

# emacs alias for terminal
alias emacs="emacs -nw"

# Set the name of vim session the terminal is tied up to
eset(){
  # example server name `/tmp/<name of the server>`
  export NVIM_SERVER=$1
}

# Fire up a new server according to the argument supplied
vs(){
  eset $1
  nvim --listen $NVIM_SERVER "${@:2}"
}

# Open up the files in the environment Vim server.
es(){
  nvim --server $NVIM_SERVER --remote-silent $*
}

# Open up the files in the environment Vim server in a tab
est(){
  nvim --server $NVIM_SERVER --remote-tab-silent $*
}

# Reuse Vim ZSH completions for vim completions
compdef _vim es
compdef _vim est

# Set custom title to terminal window
settitle() {
  export DISABLE_AUTO_TITLE="true"
  echo -e "\033];$1\007"
}

# execute command without cd'ing to the directory
exe() {
  pushd $1 > /dev/null;
  shift;
  eval $@;
  popd > /dev/null;
}

# vi bindings in terminal
set -o vi
bindkey -v
