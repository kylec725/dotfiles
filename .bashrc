#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[38;5;74m\]加油\[\e[0m\] \[\e[38;5;69m\]\u\[\e[0m\] \[\e[38;5;74m\]\W\[\e[0m\] '

# aliases
alias ls='ls --color=auto'
alias vim='nvim'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
