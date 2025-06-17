if which poetry &>/dev/null; then
    poetry completions bash > ${XDG_DATA_HOME:-~/.local/share}/bash-completion/completions/poetry
fi
