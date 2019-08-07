# ================
# Brew Management
# ================
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
		for prog in $(echo $uninstall);do
			brew rmtree $prog
		done
	fi
}

function zap() {
	local token
	token=$(brew cask list | fzf +m)

	if [[ x"$token" != "x" ]]; then
		brew cask zap $token
	fi
}

#=================
# Command Support
#=================
function fh() {
    eval $( (fc -l 1 || history) | fzf +s +x --tac --height 20% | sed 's/ *[0-9]* *//')
}

function fssh() {
	ssh_name=$(awk '/Host / { for(i=2;i<=NF;i++) printf "%s\n", $i }' $HOME/.ssh/config | fzf -m --height 20%)
	
	if [[ $ssh_name ]]; then
		ssh -C $ssh_name
	fi
}

# gitignore.io
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

# tmux session
function tm() {
	[[ -n "$TMUX" ]] &&  change="switch-client" || change="attach-session"
	
	if [[ $1 ]]; then
		tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
	fi

	session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No session found."
}

function proxy() {
	if [[ ! ${http_proxy} ]]; then
		export http_proxy=http://127.0.0.1:1087
		export https_proxy=http://127.0.0.1:1087
	fi
}

# Kill process
# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
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
