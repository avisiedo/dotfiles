if tty -s &>/dev/null; then
    alias ll='ls -l --color'
    alias ssh-add='/usr/bin/ssh-add -t 300'
    # Print current aliases
    alias
fi
