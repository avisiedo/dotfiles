##
# Alias definitions
##
if tty -s &>/dev/null; then
  alias ll='ls -l --color'
  alias ssh-add='/usr/bin/ssh-add -t 600'
  if [ "" != "$(which nvim 2>/dev/null)" ]; then
    alias vi='$(which nvim 2>/dev/null)'
  fi
fi
