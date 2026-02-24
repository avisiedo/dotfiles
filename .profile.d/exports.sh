if tty -s &>/dev/null; then
  if which nvim &>/dev/null; then
    export EDITOR=/usr/bin/neovim
  elif which vim &>/dev/null; then
    export EDITOR=/usr/bin/vim
  elif which vi &>/dev/null; then
    export EDITOR=/usr/bin/vi
  fi
fi
