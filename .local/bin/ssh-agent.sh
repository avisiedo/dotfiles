#!/bin/bash

# see: links "https://rabexec.org/posts/pitfalls-of-ssh-agents"

# @brief start the ssh-agent and use it in a "safe" way.
ssh_agent_start() {
    local ret
    local timelife=600

    ssh-add -l &>/dev/null; ret="$?"
    [ "$ret" != 2 ] && return $ret

    test -r "${HOME}/.ssh-agent" && \
        eval "$(<"${HOME}/.ssh-agent")" >/dev/null

    ssh-add -l &>/dev/null; ret="$?"
    [ "$ret" != 2 ] && return $ret

    (umask 067; ssh-agent > "${HOME}/.ssh-agent")
    eval "$(<"${HOME}/.ssh-agent")" >/dev/null

    if tty -s &>/dev/null; then
        ssh-add -t ${timelife}
    fi
}

main() {
    ssh_agent_start
}

if [ "${BASH_SOURCE[0]}" == "$(which -- "$0" 2>/dev/null)" ]; then
    main "$@"
    exit $?
fi

