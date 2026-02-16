##
# Ensure that GOSUMDB is set to sum.golnag.org
##
if [ -e ~/go ]; then
  # make available the go tools installed in the user environment
  if type -t pathmunge &>/dev/null; then
    # Fedora /etc/profile define pathmunge
    pathmunge "$HOME/go/bin"
  elif type -t append_path &>/dev/null; then
    # Arch linux /etc/profile define append_path
    append_path "$HOME/go/bin"
  else
    PATH="$PATH:$HOME/go/bin"
  fi
  export PATH
  export GOSUMDB="sum.golang.org"
fi
