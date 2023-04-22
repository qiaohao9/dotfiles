#
# ~/.bashrc
#

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h at \W]\$ '

[[ ${TERM} == "xterm-termite" ]] && export TERM=xterm-256color

command -v nvim &> /dev/null && export EDITOR=nvim
command -v exa &> /dev/null && alias ls="exa --header"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=11000
export HISTFILESIZE=11000

export HOMEBREW_EDITOR=${EDITOR}
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

export GO11MODULE=on
export GOPATH=${HOME}/.go
export GOPROXY=https://goproxy.cn,direct

export FZF_DEFAULT_OPTS="--height=20% --reverse"

function add_path() {
    export PATH=${PATH}:$1
}
add_path ${GOPATH}/bin
add_path ${HOME}/.local/bin
add_path ${HOME}/.node_modules/bin

alias unproxy="unset http{,s}_proxy"
function proxy() {
    target="http://127.0.0.1:7890"; [[ ! $1 == "" ]] && target=$1; export http{,s}_proxy=${target}
}


# Another CTRL-R script to insert the selected command from history into the command line/region
__fzf_history ()
{
    builtin history -a;
    builtin history -c;
    builtin history -r;
    builtin typeset \
        READLINE_LINE_NEW="$(
            HISTTIMEFORMAT= builtin history |
            command fzf --prompt 'history > ' +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
            [[ $(uname -s) == "Darwin" ]] && alias sed=gsed |
            command sed '
                /^ *[0-9]/ {
                    s/ *\([0-9]*\) .*/!\1/;
                    b end;
                };
                d;
                : end
            '
        )";

        if
                [[ -n $READLINE_LINE_NEW ]]
        then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        else
                builtin bind '"\er":'
                builtin bind '"\e^":'
        fi
}
builtin set -o histexpand;
builtin bind -x '"\C-x1": __fzf_history';
builtin bind '"\C-r": "\C-x1\e^\er"'

# copied from https://bit.ly/3ZhgVjz
function fssh() {
    host=$(grep "^Host " ${HOME}/.ssh/config | cut -b 6- | fzf --prompt="SSH > " --preview="awk -v HOST={} -f ~/.ssh/host2conf.awk ~/.ssh/config")
    [ $? -eq 0 ] && ssh ${host}
}

function fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias bashconfig="source ${HOME}/.bashrc"
alias ll="ls -lh"
alias la="ll -a"
alias brewfile="brew bundle dump --global -f"
