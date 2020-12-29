set -gx LANG     en_US.UTF-8
set -gx LC_ALL   en_US.UTF-8
set -gx CLICOLOR 1
set -gx GPG_TTY  (tty)

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME  $HOME/.cache

# HomeBrew
set -gx HOMEBREW_NO_ANALYTICS   1
set -gx HOMEBREW_NO_AUTO_UPDATE true
set -gx HOMEBREW_EDITOR         {$EDITOR}

set -gx PIPENV_IGNORE_VIRTUALENVS 1
set -gx DOCKER_BUILDKIT           1

set -gx GO111MODULE auto
set -gx GOPATH      {$HOME}/.go

# Mirrors
set -gx GOPROXY                https://goproxy.cn,direct
set -gx PIPENV_PYPI_MIRROR     https://pypi.douban.com/simple
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

alias fishconfig="source $HOME/.config/fish/config.fish"
alias ls="exa -s type --group-directories-first"
alias l="ls -hl"
alias la="ls -ahl"
alias du="ncdu --color dark -rr -x --exclude .git"

command -v nvim 2>&1 > /dev/null; and set -gx EDITOR nvim; or set -gx EDITOR vi
command -v go 2>&1 > /dev/null; and set -gx GOROOT (go env GOROOT)

test $TERM = "xterm-termite"; and set -gx TERM xterm-256color

switch (uname)
case "Linux"
    test {$XDG_VTNR} -eq 1; and ! test {$DISPLAY}; and exec startx 2>&1 > /dev/null  # startx in i3wm
case "*"
end


function add_path
    set -gx PATH $PATH $argv
end

add_path $HOME/.node_modules/bin
add_path $HOME/bin
add_path $HOME/.local/bin


function load_fish
    set -x file_path $HOME/.config/fish/functions/$argv
    test -e $file_path; and source $file_path
end

load_fish fzf_tools.fish
load_fish tools.fish

