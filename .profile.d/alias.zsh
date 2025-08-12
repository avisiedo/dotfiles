##
# Alias definitions
##

alias ll='ls -l --color'
if [ "" != "$(which nvim 2>/dev/null)" ]; then
  alias vi='$(which nvim 2>/dev/null)'
fi
alias lsusb='ioreg -p IOUSB'
