function fssh -d "Fuzzy-find ssh host via ag and ssh into it."
    awk '/^Host [a-zA-Z0-9\-_]+$/ { for(i=2; i<=NF; i++) printf "%s\n", $i }' $HOME/.ssh/config | fzf +m --height 20% | read -l ssh_target; and ssh "$ssh_target"
end

function ftmux -d "Fuzzy-switch tmux session."
    set -q TMUX; and set -l change switch-client; or set -l change attach-session
    tmux list-sessions -F "#{session_name}" | fzf +m --height 20% | read -l session; and tmux $change -t $session
end

