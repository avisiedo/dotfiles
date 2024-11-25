if which ssg-agent &>/dev/null; then
	eval "$(ssh-agent -s)"
	keyfile_list=("~/.ssh/id_ed25519")
	for keyfile in "${keyfile_list[@]}"; do
		[ ! -e "${keyfile}" ] || ssh-add ~/.ssh/id_ed25519
	done
	unset keyfile
	unset keyfile_list
fi
