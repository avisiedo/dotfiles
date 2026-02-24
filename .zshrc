autoload -Uz compinit; compinit

if [ -e "${HOME}/.profile.d" ]; then
  for item in ${HOME}/.profile.d/*.zsh; do
    source "${item}"
  done
fi

