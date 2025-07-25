# see: links "https://rabexec.org/posts/pitfalls-of-ssh-agents"

if tty -s &>/dev/null; then
    ssh-agent.sh
fi

export SSH_ASKPASS=/usr/libexec/openssh/ssh-askpass

