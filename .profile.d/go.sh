if [ -e ~/go ]; then
  # make available the go tools installed in the user environment
  export PATH="$HOME/go/bin:$PATH"
fi
