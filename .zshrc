# Variable behaviors
setopt NO_ALL_EXPORT  # Don't export all variables to environment

# Directory changing
setopt auto_cd           # cd by typing directory name if it's not a command
setopt CDABLE_VARS       # Try to cd to variable value from ~ if no leading slash
setopt NO_AUTO_PUSHD     # Prevent all directories from being automatically pushed onto the stack
setopt PUSHD_IGNORE_DUPS # Directory only appears once on the stack
setopt PUSHD_TO_HOME     # pushd with no arguments goes to ~

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
if [[ "$OSTYPE" = "linux-gnu" && ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
if [ "$TERM" = "xterm-termite" ]; then 
  export TERM=xterm-256color
fi


# ========================
# Environments
# ========================
export LANG='en_US.UTF-8'

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

export GOPATH=$HOME/.go
export GOROOT=$(go env GOROOT)
export PATH=$PATH:$HOME/.node_modules/bin:$GOPATH/bin

export PIPENV_PYPI_MIRROR="https://pypi.douban.com/simple"


# ========================
# Zplug
# ========================
source $HOME/.zplug/init.zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "themes/ys", as:theme, from:oh-my-zsh
zplug "dylanaraps/neofetch", as:command, use:"neofetch"
zplug "felixonmars/ydcv", as:command, rename-to:ydcv, use:"src/ydcv.py"
zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*$(uname | tr '[:upper:]' '[:lower:]')*amd64*"
zplug "vastpeng/fzf-tools"
zplug "rgcr/m-cli", as:command, use:"m", if:"[[ $OSTYPE == *darwin*  ]]"
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug load


# ========================
# Alias
# ========================
alias zshconfig="source ~/.zshrc"

alias l="ls -hlHG"
alias la="ls -ahlHG"

alias vi="nvim"
alias vim="nvim"

alias ping="prettyping --nolegend"
alias du="ncdu --color dark -rr -x --exclude .git"

alias dm="docker-machine"
