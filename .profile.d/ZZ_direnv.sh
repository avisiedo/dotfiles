if which direnv &>/dev/null; then
  source <(direnv hook "$(basename $SHELL)")
fi
