##
# Ensure that GOSUMDB is set to sum.golnag.org
##
if [ -e ~/go ]; then
  # make available the go tools installed in the user environment
  pathmunge "$HOME/go/bin"
  export PATH
  export GOSUMDB="sum.golang.org"
fi
