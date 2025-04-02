# About dotfiles

See: https://wiki.archlinux.org/title/Dotfiles

## Package dependencies

- **For Go development**

  ```sh
  sudo dnf install -y \
    nvim silver rg fzf \
    vim-go vim-golint vim-nerdtree \
    vim-fugitive vim-rhubarb vim-fugitive-gitlab
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

## Autocompletion

```sh
source /usr/share/bash-completion/completions/git
__git_complete dotfiles __git_main
```

## Other customizations

### gnome-system-monitor

```sh
[ -e ~/opt ] || mkdir ~/opt
[ -e ~/opt/gnome-shell-system-monitor-next-applet ] || git clone https://github.com/mgalgs/gnome-shell-system-monitor-next-applet.git /home/avisiedo/opt/gnome-shell-system-monitor-next-applet
[ -e ~/.local/share/gnome-shell/extensions ] || mkdir ~/.local/share/gnome-shell/extensions
cd ~/.local/share/gnome-shell/extensions
ln -svf "$HOME/opt/gnome-shell-system-monitor-next-applet/system-monitor-next@paradoxxx.zero.gmail.com"
```

- Log out
- Log in

mkdir ~/opt
git clone

## Other dotfiles

- [Andreas Schneider](https://git.cryptomilk.org/.dotfiles).
- [Frasers dotfiles](https://github.com/frasertweedale/dotfiles).

