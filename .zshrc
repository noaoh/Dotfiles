#!/bin/zsh

git_prompt() {
        local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ -n "$branch_name" ]; then
                echo "$branch_name"
        fi
}

j() {
        num=$1
        while [ $num -ne 0 ];do
                cd ..
                num=$( expr $num - 1 )
        done
}

setopt PROMPT_SUBST;

# Created by newuser for 5.8
PROMPT='%F{red}%n%f@%F{red}%m%F{white}:%f%f%F{green}%B%~%b%f%\:%F{yellow}$(git_prompt "(%s)")%F{white} '
#RPROMPT='[%F{yellow}%?%f]'
export PATH=$PATH:~/.bin
export PATH=$PATH:/usr/bin/i3
export NODE_ENV='development'
export EDITOR='neovim'
export PAGER='nvimpager'

no_proxy=localhost

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

autoload -Uz compinit
compinit

# Lines configured by zsh-newuser-install
# End of lines configured by zsh-newuser-install
