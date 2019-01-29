## ZSH-specific shell environment flags only relvant to interactive shells
# Variable behaviors
setopt NO_ALL_EXPORT  # Don't export all variables to environmento

# Directory changing
setopt AUTO_CD           # cd to a directory if it's given without a command
setopt CDABLE_VARS       # Try to cd to variable value from ~ if no leading slash
setopt NO_AUTO_PUSHD     # Prevent all directories from being automatically pushed onto the stack
setopt PUSHD_IGNORE_DUPS # Directory only appears once on the stack
setopt PUSHD_TO_HOME     # pushd with no arguments goes to ~

# Completion
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
setopt CHECK_JOBS     # Report status of background jobs when exitting a shell
setopt LONG_LIST_JOBS # More verbose listing of jobs
setopt NOTIFY         # Notify of background job changes as soon as they happen

# ========================
# Key Map Binding
# ========================
bindkey '[D' backward-word
bindkey '[C' forward-word

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
# Environment variables
# ========================
export PATH=$PATH:$HOME/.node_modules_global/bin
export ZPLUG_HOME=$HOME/.zplug
export EDITOR="nvim"
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export GOPATH=$HOME/.go
export GOROOT=$(go env GOROOT)
export PIPENV_PYPI_MIRROR="https://pypi.douban.com/simple"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
# export http_proxy=http://127.0.0.1:1087
# export https_proxy=http://127.0.0.1:1087

# ========================
# Zplug
# ========================
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source $ZPLUG_HOME/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "tonyseek/oh-my-zsh-seeker-theme", as:theme
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug "AlDanial/cloc", as:command
zplug "dylanaraps/neofetch", as:command, use:"neofetch"
zplug "felixonmars/ydcv", as:command, rename-to:ydcv, use:"src/ydcv.py"
zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*$(uname | tr '[:upper:]' '[:lower:]')*amd64*"
zplug "rgcr/m-cli", as:command, use:"m", if:"[[ $OSTYPE == *darwin*  ]]"
if ! zplug check; then
  zplug install
fi
zplug load
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

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
alias yt="youtube-dl -f bestvideo+bestaudio -o \"%(title)s.%(ext)s\""
