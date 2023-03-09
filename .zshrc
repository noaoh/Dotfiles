#!/bin/zsh
# Created by newuser for 5.8
PROMPT='%F{red}%n%f@%F{red}%m%F{white}:%f%f%F{green}%B%~%b%f%  '
#RPROMPT='[%F{yellow}%?%f]'
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.gem/ruby/2.5.0/bin
export GO111MODULE=auto
export NODE_ENV='development'

export PATH=$PATH:/home/noah/bin
no_proxy=localhost

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/serverless.bash ] && . /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/sls.bash ] && . /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/slss.bash ] && . /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/slss.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

autoload -Uz compinit
compinit
# Lines configured by zsh-newuser-install
# End of lines configured by zsh-newuser-install
