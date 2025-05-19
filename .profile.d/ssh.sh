# see: links "https://rabexec.org/posts/pitfalls-of-ssh-agents"

# @brief start the ssh-agent and use it in a safe way.
start_ssh_agent() {
    # TODO Keep in mind the notes of the article and 
    # implement in a safe way
    :
}

if which ssh-agent &>/dev/null; then
	# eval "$(ssh-agent -s)" &>/dev/null
	# keyfile_list=("$HOME/.ssh/id_ed25519")
	# for keyfile in "${keyfile_list[@]}"; do
		# [ ! -e "${keyfile}" ] || ssh-add "$HOME/.ssh/id_ed25519"
        # :
	# done
	# unset keyfile
	# unset keyfile_list

    # TODO naive approach, read the article about the
    #      security concerns and use an approach which
    #      is safer
    :
fi

export SSH_ASKPASS=/usr/libexec/openssh/ssh-askpass

