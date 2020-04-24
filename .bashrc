#
# ~/.bashrc
#

[[ $- != *i* ]] && return
colors() { local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

gopath () {
        cdir=$PWD
        while [ "$cdir" != "/" ]; do
                if [ -e "$cdir/.gopath" ]; then
                        export GOPATH=$cdir
                        break
                fi
                cdir=$(dirname "$cdir")
        done
}

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.gem/ruby/2.5.0/bin
export GO111MODULE=auto
export PS1="\[\033[38;5;1m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]:\[$(tput sgr0)\]\[\033[38;5;28m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

export NVM_DIR="/home/noah/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$PATH:/home/noah/bin

source '/home/noah/lib/azure-cli/az.completion'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/serverless.bash ] && . /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/sls.bash ] && . /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/slss.bash ] && . /home/noah/Code/github.com/noaoh/sleepytime/node_modules/tabtab/.completions/slss.bash