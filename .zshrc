# Variable behaviors
setopt NO_ALL_EXPORT  # Don't export all variables to environment

# completion
setopt MENU_COMPLETE # Cycle through completions by completing in place
setopt NO_LIST_BEEP  # Prevent beeping on ambiguous completion

# Globbing
setopt EXTENDED_GLOB # Allow globbing qualifiers and other extensions
setopt COMPLETE_IN_WORD
setopt GLOB_DOTS     # Patterns may match without leading periods
setopt NOMATCH       # Throw error if a glob fails to match

# Background jobs
setopt AUTO_CONTINUE  # Ensure a stopped job is continued when disowned
setopt NO_BG_NICE     # Don't lower priority of background jobs

# Miscellaneous
setopt nocorrectall # not to correct command
setopt NO_BEEP      # Do not beep on line editor errors
bindkey -v          # use vi mode to bind keys

# Disable core dumps
limit coredumpsize 0


# ========================
# X Display For Arch Linux
# ========================
if [[ "$(uname -s)" = "Linux" && ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

if [ "$TERM" = "xterm-termite" ]; then
  export TERM=xterm-256color
fi


# ========================
# Environments
# ========================
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_EDITOR=nvim
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
if [[ $(command -v go) ]]; then
    export GOROOT=$(go env GOROOT)
fi
export PATH=$PATH:$HOME/.node_modules/bin:$GOPATH/bin:$HOME/.local/bin

export PIPENV_PYPI_MIRROR="https://pypi.douban.com/simple"


# ========================
# Zplug
# ========================
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source $HOME/.zplug/init.zsh
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "themes/ys",                   as:theme,   from:oh-my-zsh
zplug "iikira/BaiduPCS-Go",          as:command, rename-to:baidupan, use:"*$(uname | tr '[:upper:]' '[:lower:]')*amd64*", from:gh-r
if ! zplug check; then
    zplug install
fi
zplug load
[[ -f ~/.fzf-tools.zsh ]] && source ~/.fzf-tools.zsh

# ========================
# Alias
# ========================
alias zshconfig="source ~/.zshrc"

alias l="ls -hlHG"
alias la="ls -ahlHG"

alias du="ncdu --color dark -rr -x --exclude .git"

