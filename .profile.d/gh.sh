if which gh &>/dev/null; then
  source <(gh completion -s "$(basename "$SHELL")")
fi
