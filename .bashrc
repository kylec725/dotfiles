#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='\[\e[38;5;74m\]加油\[\e[0m\] \[\e[38;5;69m\]\u\[\e[0m\] \[\e[38;5;74m\]\W\[\e[0m\] -> '
PS1='\[\e[38;5;195m\]\342\224\214\342\224\200[\[\e[0m\] \[\e[38;5;74m\]加油\[\e[0m\] \[\e[38;5;69m\]\u\[\e[0m\] \[\e[38;5;74m\]\w\[\e[0m\] \[\e[38;5;195m\]]\n\[\e[38;5;195m\]\342\224\224\342\224\200\342\224\200>\[\e[0m\] '

# aliases
alias ls='ls --color=auto'
alias vim='nvim'

export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/root/.gem/ruby/2.6.0/bin"
export FZF_DEFAULT_COMMAND='rg --files --hidden $HOME'
export FZF_DEFAULT_OPTS='--no-mouse --bind=tab:up,btab:down --color=prompt:195,pointer:#5ADECD,hl+:#5ADECD,hl:#C574DD'
