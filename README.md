# Dotfiles

## Intro

A repo to store my personal configuration files. I can't promise they will
be useful to anyone, but feel free to take a look, use them, copy them, or
do whatever you like with them. I only guaranty they will take up some
harddrive space.

## Stow

I've recently started using GNU Stow to manage my dotfiles. This allows me
to easily symlink my configuration files and maintain them across multiple
machines, using this git repository.

It works quite simpel. First install stow, then clone this repository into
your home directory:

```bash
sudo pacman -S stow
git clone https://github.com/leugemors/dotfiles.git ~/dotfiles
```

Then you can use stow to symlink the files in the `~/dotfiles` directory to
your home directory, e.g.:

```bash
cd ~/dotfiles
stow alacritty
```

Repeat this for each configuration you want to use. Or use the included bash
script `stow_all.sh` to symlink all configurations at once.

## My aliasses, vim and shell configuration

- .aliases
- .gitconfig
- .tmux.conf
- .zshrc
- .vim/vimrc

## Various configuration files

I'm using Alacritty as my preferred shell. Kitty and Terminator are only
here for testing purposes (I like to play around :-) ).

- alacritty
- btop
- gtk-4.0
- gtk-3.0
- htop
- kitty
- lazygit
- mc
- newsboat
- picom
- powershell
- qtile
- redshift
- rofi
- starship
- terminator
- yazi
- zed

## License

[GPL](https://choosealicense.com/licenses/gpl/)
