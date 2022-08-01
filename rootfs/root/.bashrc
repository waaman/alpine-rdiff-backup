source /etc/profile.d/bash_completion.sh

alias dir='ls --color=never -alh'
alias lsa='ls -alh'
alias mkdir='mkdir --verbose'

export PS1="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
export EDITOR="nano"