command -v nvim 2>&1 > /dev/null; and set -gx EDITOR nvim; or set -gx EDITOR vi
command -v go 2>&1 > /dev/null; and set -gx GOROOT (go env GOROOT)

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
set -gx PIPENV_PYPI_MIRROR     https://pypi.douban.com/simple
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

alias fishconfig="source $HOME/.config/fish/config.fish"
alias ls="exa -s type --group-directories-first"
alias l="ls -hl"
alias la="ls -ahl"
alias du="ncdu --color dark -rr -x --exclude .git"

test $TERM = "xterm-termite"; and set -gx TERM xterm-256color

switch (uname)
case "Linux"
    set -q XDG_VTNR; and test {$XDG_VTNR} -eq 1; and ! test {$DISPLAY}; and exec startx 2>&1 > /dev/null
case "*"
end


function add_path
    set -gx PATH $PATH $argv
end
add_path $HOME/.node_modules/bin
add_path $GOPATH/bin
add_path $HOME/.local/bin

function proxy -d "You know what the GFW is."
    set -gx http_proxy  http://( ifconfig en0| grep "inet[ ]" | awk '{print $2}' ):7890
    set -gx https_proxy {$http_proxy}
end

# Download the GeoIP2-CN for clash.
function geoip -d "Update the Country.mmdb."
    curl -o $HOME/.config/clash/Country.mmdb -L "https://github.com/Hackl0us/GeoIP2-CN/raw/release/Country.mmdb"
end

function brewfile -d "Backup applications installed by HomeBrew."
    brew bundle dump --global -f
end

function wttr -d "Just show the weather."
    curl -L "https://wttr.in/chengdu?format=3"
end

# -------------------------------
#           fzf tools
# -------------------------------
function fssh -d "Fuzzy-find ssh host via ag and ssh into it."
    awk '/^Host [a-zA-Z0-9\-_]+$/ { for(i=2; i<=NF; i++) printf "%s\n", $i }' $HOME/.ssh/config | fzf +m --height 20% | read -l ssh_target; and ssh "$ssh_target"
end

function ftmux -d "Fuzzy-switch tmux session."
    set -q TMUX; and set -l change switch-client; or set -l change attach-session
    tmux list-sessions -F "#{session_name}" | fzf +m --height 20% | read -l session; and tmux $change -t $session
end
