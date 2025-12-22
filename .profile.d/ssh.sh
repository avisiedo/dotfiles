# see: links "https://rabexec.org/posts/pitfalls-of-ssh-agents"

if false; then
    if tty -s &>/dev/null; then
        if which ssh-agent.sh &>/dev/null; then
            source "$(which "ssh-agent.sh")"
            ssh_agent_start
        fi
    fi
fi

export SSH_ASKPASS=/usr/libexec/openssh/ssh-askpass

