##
# If neovim is installed, set it as the text editor
##
if which nvim &>/dev/null; then
  alias vi="$(which nvim)"
  export EDITOR="$(which nvim)"
fi
