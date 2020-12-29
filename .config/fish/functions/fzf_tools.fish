function fssh -d "Fuzzy-find ssh host via ag and ssh into it."
    awk '/Host / { for(i=2; i<=NF; i++) printf "%s\n", $i }' $HOME/.ssh/config | fzf +m --height 20% | read -l ssh_target; and ssh "$ssh_target"
end

function ftmux -d "Fuzzy-switch tmux session."
    if test -n $TMUX
        set -x change switch-client
        echo "hello"
    end

    tmux list-sessions -F "#{session_name}" | fzf +m --height 20% | read -l session; and tmux $change -t $session
end

