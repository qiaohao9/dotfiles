if [[ -f $HOME/.shrc ]]; then
  source ~/.shrc
fi
alias zshconfig="source $HOME/.zshrc"

# Variable behaviors
setopt NO_ALL_EXPORT  # Don't export all variables to environment

# Directory changing
setopt auto_cd           # cd by typing directory name if it's not a command
setopt CDABLE_VARS       # Try to cd to variable value from ~ if no leading slash
setopt NO_AUTO_PUSHD     # Prevent all directories from being automatically pushed onto the stack
setopt PUSHD_IGNORE_DUPS # Directory only appears once on the stack
setopt PUSHD_TO_HOME     # pushd with no arguments goes to ~

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


# ========================
# Zplug
# ========================
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source $HOME/.zplug/init.zsh
zplug "rg3/youtube-dl"
zplug "vastpeng/fzf-tools"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "themes/ys",                   as:theme,   from:oh-my-zsh
zplug "rupa/z",                      as:plugin,  use:z.sh
zplug "dylanaraps/neofetch",         as:command, use:neofetch
zplug "junegunn/fzf",                as:command, use:bin/fzf-tmux
zplug "felixonmars/ydcv",            as:command, rename-to:ydcv, use:"src/ydcv.py"
zplug "rgcr/m-cli",                  as:command, use:m,          if:"[[ $OSTYPE == *darwin* ]]"
zplug "vastpeng/fx",                 as:command, use:bin/fx,     hook-build:"npm install"
zplug "tldr-pages/tldr-node-client", as:command, use:bin/tldr,   hook-build:"npm install"
zplug "lujiajing1126/redis-cli",     as:command, use:bin/rdcli,  rename-to:redis-cli, hook-build:"npm install"
zplug "junegunn/fzf-bin",            as:command, rename-to:fzf,  use:"*$(uname        | tr '[:upper:]' '[:lower:]')*amd64*", from:gh-r
if ! zplug check; then
    zplug install
fi
zplug load
