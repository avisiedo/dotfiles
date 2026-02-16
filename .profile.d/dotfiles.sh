dotfiles() {
	which git &>/dev/null \
		&& git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}
export -f dotfiles &>/dev/null

dotfiles config status.showUntrackedFiles no
if [ -e "/usr/share/bash-completion/completions/git" ]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dotfiles __git_main
fi
