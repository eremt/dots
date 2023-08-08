# If not running interactively, don't do anything
[[ $- != *i* ]] && return

fg_faded='\e[38;5;241m\]'
fg_normal='\e[38;5;245m\]'
PS1="$fg_faded\u@\h:$fg_normal\w "

test -r $HOME/.config/shell/common && source $HOME/.config/shell/common
test -r $HOME/.config/shell/aliases && source $HOME/.config/shell/aliases

# history
HISTFILE=$XDG_DATA_HOME/shell_history
HISTSIZE=1000
HISTFILESIZE=1000
# no duplicates or lines starting with space
HISTCONTROL=ignoreboth

# completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion/ ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# fzf
if [ -f /usr/share/bash-completion/completions/fzf ]; then
  # Debian
  source /usr/share/bash-completion/completions/fzf
elif [ -f /usr/share/fzf/completion.bash ]; then
  # Arch
  source /usr/share/fzf/completion.bash
fi

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
  # Debian
  source /usr/share/doc/fzf/examples/key-bindings.bash
elif [ -f /usr/share/fzf/key-bindings.bash ]; then
  # Arch
  source /usr/share/fzf/key-bindings.bash
fi
