alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles config status.showUntrackedFiles no
source /usr/share/bash-completion/completions/git
__git_complete dotfiles __git_main
