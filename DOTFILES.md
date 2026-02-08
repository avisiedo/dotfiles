# About dotfiles

See: https://wiki.archlinux.org/title/Dotfiles

## Package dependencies

**For GO development**

```sh
sudo dnf install -y \
  nvim silver rg fzf \
  vim-go vim-golint vim-nerdtree \
  vim-fugitive vim-rhubarb vim-fugitive-gitlab \
  vim-devicons
```

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

## Dotfiles alias

Linux:

```sh
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```

Windows:

`Notepad.exe $PROFILE`

```sh
function dotfiles {
    git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" @args
}
```

## Autocompletion

Linux:

```sh
source /usr/share/bash-completion/completions/git
__git_complete dotfiles __git_main
```

## Other dotfiles

- [Andreas Schneider](https://git.cryptomilk.org/.dotfiles).
- [Frasers dotfiles](https://github.com/frasertweedale/dotfiles).

