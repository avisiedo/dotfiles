##
# Alias definitions
##

if tty -s &>/dev/null; then
  alias ll='ls -l --color'
  alias ssh-add='/usr/bin/ssh-add -t 600'
  if which vim &>/dev/null; then
    alias vi='$(which vim 2>/dev/null)'
  elif which nvim &>/dev/null; then
    alias vi='$(which nvim 2>/dev/null)'
  fi
  alias ramalama-run='ramalama run --pull never --network host deepseek-coder:33b'
  if flatpak info com.visualstudio.code &>/dev/null; then
    alias code='flatpak run com.visualstudio.code'
  elif flatpak-spawn --host flatpak info com.visualstudio.code &>/dev/null; then
    alias code='flatpak-spawn --host flatpak run com.visualstudio.code'
  fi
fi
