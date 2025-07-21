#!/bin/bash

# see: links "https://rabexec.org/posts/pitfalls-of-ssh-agents"

# @brief start the ssh-agent and use it in a "safe" way.
start_ssh_agent() {
    local ret

    ssh-add -l &>/dev/null; ret="$?"
    [ "$ret" != 2 ] && return $ret

    test -r "${HOME}/.ssh-agent" && \
        eval "$(<"${HOME}/.ssh-agent")" >/dev/null

    ssh-add -l &>/dev/null; ret="$?"
    [ "$ret" != 2 ] && return $ret

    (umask 066; ssh-agent > "${HOME}/.ssh-agent")
    eval "$(<"${HOME}/.ssh-agent")" >/dev/null

    if tty -s &>/dev/null; then
        ssh-add -t 3600
    fi
}

main() {
    start_ssh_agent
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    main "$@"
fi

