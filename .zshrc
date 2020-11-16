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

# History behavior
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt NO_HIST_BEEP
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt NO_HIST_VERIFY
setopt BANG_HIST
setopt INTERACTIVE_COMMENTS
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 } # Don't save failed commands
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000


# ========================
# X Display For Arch Linux
# ========================
if [[ "$(uname -s)" = "Linux" && ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  command -v startx > /dev/null 2>&1 && exec startx
fi

if [ "$TERM" = "xterm-termite" ]; then
  export TERM=xterm-256color
fi


# ========================
# Environments
# ========================
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export CLICOLOR=1
export GPG_TTY=$(tty)

if [[ $(command -v nvim) ]]; then
    export EDITOR=nvim
else
    export EDITOR=vi
fi


export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_EDITOR=nvim

export PIPENV_IGNORE_VIRTUALENVS=1
export DOCKER_BUILDKIT=1

export GO111MODULE=auto
export GOPATH=$HOME/.go
if [[ $(command -v go) ]]; then
    export GOROOT=$(go env GOROOT)
fi

export PATH=$PATH:/usr/local/sbin:$HOME/.node_modules/bin:$GOPATH/bin:$HOME/.local/bin

# mirrors
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export PIPENV_PYPI_MIRROR=https://pypi.douban.com/simple
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles


# ------------------
#   zpinit plugins
# ------------------
if [[ ! -d ~/.zinit/bin ]]; then
  git clone --depth 1 https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light "zdharma/fast-syntax-highlighting"
zinit light "zsh-users/zsh-autosuggestions"
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit light "tinyRatP/ys"

# ------------
#    Alias
# ------------
alias zshconfig="source ~/.zshrc"

alias ls="exa -s type --group-directories-first"
alias l="ls -hl"
alias la="ls -ahl"

alias du="ncdu --color dark -rr -x --exclude .git"
alias share="python3 -m http.server"

if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
    alias vi='nvim'
fi

function proxy() {
    if [[ ! ${http_proxy} ]]; then
        export http_proxy=http://127.0.0.1:7890
        export https_proxy=$http_proxy
    fi
}

function pacmanfile() {
    comm -23 <(pacman -Qqe | sort) <({ pacman -Qqg base-devel; expac -l '\n' '%E' base; } | sort -u) > $HOME/.Pacmanfile
}

function brewfile() {
    brew bundle dump --global -f
}


# ----------------
#   fzf plugins
# ----------------
function install() {
    local inst=$(brew search | fzf -m)
    if [[ $inst ]]; then
        for prog in $(echo $inst); do
            brew install $prog
        done
    fi
}

function rmtree() {
    local uninstall=$(brew leaves | fzf -m)

    if [[ $uninstall ]]; then
        for prog in $(echo $uninstall); do
            brew rmtree  $prog
        done
    fi
}

function zap() {
    local uninstall=$(brew cask list | fzf -m)
    if [[ $uninstall ]]; then
        for prog in $(echo $uninstall); do
            brew cask zap $prog
        done
    fi
}

function fh() {
    eval $( (fc -l 1 || history) | fzf +s +x --tac --height 20% | sed 's/ *[0-9]* *//')
}

function fssh() {
    local ssh_name=$(awk '/Host / { for(i=2;i<=NF;i++) printf "%s\n", $i }' $HOME/.ssh/config | fzf -m --height 20%)

    if [[ $ssh_name ]]; then
        ssh $ssh_name
    fi
}

function __git() {
    curl -L -s https://gitignore.io/api/"$@"
}
function gi() {
    if [ "$#" -eq 0 ]; then
        IFS+=","
        for item in $(__git list); do
            echo $item
        done | fzf --height 20% --multi --ansi | paste -s -d "," - |
        { read result && __git "$result" ; } > ./.gitignore
    else
        __git "$@" > ./.gitignore
    fi
}

function ftmux() {
    [[ -n "$TMUX" ]] &&  change="switch-client" || change="attach-session"

    if [[ $1 ]]; then
        tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
    fi

    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No session found."
}

function fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

