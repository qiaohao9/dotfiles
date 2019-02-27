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
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=true

export LANG='en_US.UTF-8'

export ZPLUG_HOME=$HOME/.zplug
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.node_modules/bin:$GOPATH/bin

export PIPENV_PYPI_MIRROR="https://pypi.douban.com/simple"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"


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
