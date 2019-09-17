# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Aliases
alias ll="ls -lhA"
alias ll@="ll node_modules/@polleverywhere/"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'

# PE aliases
alias pe='pollev'
alias peb='pollev build'
alias ped='pollev deploy'
alias pedh='pollev deploy-history'
alias peul='pollev unlock'
alias pe-staging-dbtunnel='pollev database tunnel -p 3309 rails-app staging'
alias pe-prod-dbtunnel='pollev database tunnel -p 3308 rails-app production'
alias pe-localdb='mysql -u root -D polleverywhere_development'

# Git aliases
alias gitsha="git rev-parse HEAD | tr -d '\n' | pbcopy && pbpaste && printf '\n'"

# Set vim as default editor
export EDITOR=vim

# Modify the terminal prompt.
# https://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie/
export PS1="\e[1;35m[\A]$ \e[m"

# Add color to the OSX terminal.
# http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Homebrew path
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# pollev commandline
export PATH="$HOME/.pollev/bin:$PATH"

# Keep ssh key in user chain.
ssh-add -K ~/.ssh/id_rsa &>/dev/null

# Bash git prompt setup.
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

# FZF stuff
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Use FZF with ripgrep
export FZF_DEFAULT_COMMAND='rg --ignore-file .gitignore --glob !.git --files-with-matches --follow --smart-case --threads 4 --hidden --regexp ""'

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nodenv
[ -f "$(command -v nodenv)" ] && eval "$(nodenv init -)"

# Tmux, autostart. If not running interactively, do not do anything
if [[ -z "$TMUX" ]] ;then
  tmux attach || tmux new
fi
