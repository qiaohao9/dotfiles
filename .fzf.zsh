#=================
# Brew Management
#=================
function install () {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
      do
        brew install $prog
      done
  fi
}
function rmtree() {
  local uninstall=$(brew leaves | fzf -m)

  if [[ $uninstall ]]; then
    for prog in $(echo $uninstall);
    do
      brew rmtree $prog
    done
  fi
}
function zap () {
  local token
  token=$(brew cask list | fzf-tmux --query="$1" +m --preview "brew cask info {}")

  if [[ "x$token" != "x" ]]; then
    brew cask zap $token
  fi
}


#=================
# Command Support
#=================
# history
function fh () {
    eval $( cat ~/.zhistory | fzf +s +x --tac --height 20% | sed 's/ *[0-9]* *//')
}
function fkill () {
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
function fssh () {
    ssh_name=$( awk '/Host / { for(i=2;i<=NF;i++) printf "%s\n", $i }' $HOME/.ssh/config | fzf -m --height 20% )
    if [[ ${ssh_name} ]]; then
        ssh -C ${ssh_name}
    fi
}
# convert date to timestamp
function ts () {
  if [[ $# -ne 0 ]]; then
    date -d $1 +%s --utc
  else
    date +%s
  fi
}


#=================
# Git Support
#=================
function __gi() {
  curl -L -s https://www.gitignore.io/api/"$@"
}
function gi () {
    if  [ "$#" -eq 0 ]; then
        IFS+=","
        for item in $(__gi list);
        do
            echo $item
        done | fzf --height 20% --multi --ansi | paste -s -d "," - |
        { read result && __gi "$result" ; } > ./.gitignore
    else
        __gi "$@" > ./.gitignore
    fi
}
