# include silver configuration if installed
if which silver &>/dev/null; then
  source <(silver init)
fi
