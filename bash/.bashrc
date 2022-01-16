# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Aliases
alias ll="ls -lhA"      # More useful list all
alias rm='rm -i'        # Warn before deleting
alias cp='cp -i'        # Warn before copying
alias mv='mv -i'        # Warn before moving
alias mkdir='mkdir -p'  # Prevents accidentally clobbering files.
alias h='history'       # See history
alias j='jobs -l'       # See running jobs
alias which='type -a'

# Git aliases
alias gitsha="git rev-parse HEAD | tr -d '\n' | pbcopy && pbpaste && printf '\n'"

# Alias vim to neovim to transition over slowly.
alias vi='nvim'
alias vim='nvim'

# Silence the warning message to switch shells to zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set vim as default editor
export EDITOR=vim

# Set "bat" config path to my dotfiles config
# https://github.com/sharkdp/bat
export BAT_CONFIG_PATH="$HOME/projects/dotfiles/bat/bat.conf"

# Use "bat" as the colorizing pager for "man"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Modify the terminal prompt.
# https://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie/
START_COLOR='\e[1;35m'
END_COLOR='\e[m'
export PS1="$START_COLOR[\A]$ $END_COLOR"

# Add color to the OSX terminal.
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Homebrew path
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Setup GPG
export GPG_TTY=$(tty)

# Bash git prompt setup.
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

# FZF stuff
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Configure FZF to use ripgrep
export FZF_DEFAULT_COMMAND='rg --ignore-file .gitignore --glob "!{.git,node_modules}/*" --files-with-matches --follow --smart-case --threads 4 --hidden --regexp ""'

# Tmux, autostart. If not running interactively, do not do anything
if [[ -z "$TMUX" ]] ;then
  tmux attach || tmux new
fi
