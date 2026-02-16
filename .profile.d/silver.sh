# include silver configuration if installed
if tty -s &>/dev/null && which silver &>/dev/null; then
  source <(silver init)
fi
