##
# Alias definitions
##

alias ls='/bin/ls --color'
alias ll='ls -l --color'
if which -s nvim &>/dev/null; then
  alias vi='$(which nvim 2>/dev/null)'
fi
alias lsusb='ioreg -p IOUSB'
