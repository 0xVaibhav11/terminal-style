#!/usr/bin/env bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;


# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias rbash="source ~/.bash_profile"
alias webdev="cd ~/Projects/Coding/Webdev"
alias noob="cd ~/Projects"
alias cls="clear"

prompt_git() {
	local branchName='';

	# Check if the current directory is in a Git repository.
	git rev-parse --is-inside-work-tree &>/dev/null || return;

	# Check for what branch we’re on.
	# Get the short symbolic ref. If HEAD isn’t a symbolic ref, get a
	# tracking remote branch or tag. Otherwise, get the
	# short SHA for the latest commit, or give up.
	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
		git describe --all --exact-match HEAD 2> /dev/null || \
		git rev-parse --short HEAD 2> /dev/null || \
		echo '(unknown)')";

	

	echo -e "(${1}${branchName}${2})";
}

#Colors
col1=$(tput setaf 195);
col2=$(tput setaf 242);
col3=$(tput setaf 128);
col4=$(tput setaf 79);
yell=$(tput setaf 228);
cyan=$(tput setaf 80);
red=$(tput setaf 203);
violet=$(tput setaf 61);
white=$(tput setaf 15);
blue=$(tput setaf 33);
bold=$(tput bold);
reset=$(tput sgr0);

#\h style
if [[ "${SSH_TTY}" ]]; then
	hostStyle="$bold$red";
else
	hostStyle="$col4";
fi;

PS1="\n";
PS1+="\[$col2\]⎾[\[$bold\]\[$col3\]\T\[$reset\]\[$col2\]";
PS1+="\[$col2\]-[\[$col1\]@\[$hostStyle\]\h\[$col1\]: \[$bold\]\[$cyan\]\W\[$reset\]\[$col2\]]";
PS1+="\[$reset\]\[$bold\]$(prompt_git $yell $col1)"; # Git repository details
PS1+="\[$reset\]\[$col2\]\n"
PS1+="⎿ \[$col1\]\`if [ \$? = 0 ]; then echo \[$bold\]$; else echo 👀 \[$bold\]$; fi\`";
PS1+="\[$reset\]";
PS1+="\[\] ";
export PS1;

PS2="\n😐 $ "
export PS2;