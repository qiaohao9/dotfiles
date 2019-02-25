# Background jobs
setopt AUTO_CONTINUE  # Ensure a stopped job is continued when disowned
setopt NO_BG_NICE     # Don't lower priority of background jobs
setopt CHECK_JOBS     # Report status of background jobs when exitting a shell
setopt LONG_LIST_JOBS # More verbose listing of jobs
setopt NOTIFY         # Notify of background job changes as soon as they happen

# Disable core dumps
limit coredumpsize 0
bindkey -v

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
export PATH=$PATH:$HOME/.node_modules/bin
export ZPLUG_HOME=$HOME/.zplug
export EDITOR="nvim"
export LANG='en_US.UTF-8'
export GOPATH=$HOME/.go
export PIPENV_PYPI_MIRROR="https://pypi.douban.com/simple"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=true
# export http_proxy=http://127.0.0.1:1087
# export https_proxy=http://127.0.0.1:1087

# ========================
# Zplug
# ========================
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source $ZPLUG_HOME/init.zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "tonyseek/oh-my-zsh-seeker-theme", as:theme
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "dylanaraps/neofetch", as:command, use:"neofetch"
zplug "felixonmars/ydcv", as:command, rename-to:ydcv, use:"src/ydcv.py"
zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*$(uname | tr '[:upper:]' '[:lower:]')*amd64*"
zplug "vastpeng/fzf-tools"
zplug "rgcr/m-cli", as:command, use:"m", if:"[[ $OSTYPE == *darwin*  ]]"
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
if ! zplug check; then
  zplug install
fi
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
