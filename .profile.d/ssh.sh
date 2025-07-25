# see: links "https://rabexec.org/posts/pitfalls-of-ssh-agents"

if tty -s &>/dev/null; then
    source "$(which ssh-agent.sh)"
    start_ssh_agent
fi

export SSH_ASKPASS=/usr/libexec/openssh/ssh-askpass

