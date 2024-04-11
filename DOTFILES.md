# About dotfiles

See: https://wiki.archlinux.org/title/Dotfiles

## Set up a new one

```sh
git init --bare ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles config status.showUntrackedFiles no
```

## Replicating files on a new system

```sh
git clone --bare https://github.com/avisiedo/dotfiles $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles config status.showUntrackedFiles no
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

## Autocompletion

```sh
source /usr/share/bash-completion/completions/git
__git_complete dotfiles __git_main
```

## Other dotfiles

- [Andreas Schneider](https://git.cryptomilk.org/.dotfiles).
- [Frasers dotfiles](https://github.com/frasertweedale/dotfiles).

