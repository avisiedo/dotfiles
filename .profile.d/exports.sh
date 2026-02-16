if tty -s &>/dev/null; then
  if which neovim &>/dev/null; then
    export EDITOR=/usr/bin/neovim
  elif which vim &>/dev/null; then
    export EDITOR=/usr/bin/vim
  elif which vi &>/dev/null; then
    export EDITOR=/usr/bin/vi
  fi
fi
