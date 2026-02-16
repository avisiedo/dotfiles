if tty -s &>/dev/null && which poetry &>/dev/null; then
    [ -e "${XDG_DATA_HOME:-~/.local/share}/bash-completion/completions/poetry" ] || {
        poetry completions bash > "${XDG_DATA_HOME:-~/.local/share}/bash-completion/completions/poetry"
    }
    source "${XDG_DATA_HOME:-~/.local/share}/bash-completion/completions/poetry"
fi
