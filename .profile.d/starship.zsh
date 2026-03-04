if command -v starship &>/dev/null; then
    if tty -s &>/dev/null; then
        source <(starship init zsh)
    fi
fi
