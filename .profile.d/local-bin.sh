##
# Custom user environment for finding local bin
##

if tty -s &>/dev/null; then
    if ! [[ "$PATH" =~ :?"$HOME/.local/bin:$HOME/bin":? ]]; then
        PATH="$PATH:$HOME/.local/bin:$HOME/bin"
    fi
    export PATH
fi

