<div align="center">
<h1>My Personal Dotfiles</h1>
</div>

<div align="center">
![](https://img.shields.io/badge/issues-none-green?style=for-the-badge&color=CCE8E9&logoColor=D9E0EE&labelColor=292324)
![](https://img.shields.io/badge/coffee-yes_please-blue?style=for-the-badge&color=CCE8E9&logoColor=D9E0EE&labelColor=292324)
</div>

## Intro

A repo to store my personal configuration files. I can't promise they will
be useful to anyone, but feel free to take a look, use them, copy them, or
do whatever you like with them. I only guaranty they will take up some
harddrive space.

## Stow

I've recently started using GNU Stow to manage my dotfiles. This allows me
to easily symlink my configuration files and maintain them across multiple
machines, using this git repository.

It works quite simple. First install stow, then clone this repository into
your home directory:

```bash
sudo pacman -S stow
git clone https://github.com/leugemors/dotfiles.git ~/dotfiles
```

Then you can use `stow` to symlink the files in the `~/dotfiles` directory to
your config directory (`~/.config`), e.g.:

```bash
cd ~/dotfiles
stow alacritty
```

Repeat this for each configuration you want to use. Or use the included bash
script `stow_all.sh` to symlink all configurations at once.

## My aliasses, vim and shell configuration

These are to be found in your home directory, and not in `~/.config` like the
other below configuration files.

- .aliases
- .gitconfig
- .tmux.conf
- .zshrc
- .vim/vimrc

## Various configuration files

I'm using Alacritty as my preferred shell. Kitty and Terminator are only
here for testing purposes (I like to play around :-) ).

| tool       | description                                    |
| ---------- | ---------------------------------------------- |
| alacritty  | My favourite terminal emulator                 |
| btop       | System monitoring                              |
| gtk-4.0    | Some GTK settings                              |
| gtk-3.0    | Some GTK settings                              |
| htop       | CLI system monitoring                          |
| kitty      | Another nice terminal emulator                 |
| lazygit    | Very handy CLI tool for working with git       |
| mc         | CLI file manager (like Norton Commander)       |
| newsboat   | Read RRS feeds from the CLI                    |
| picom      | Compositor for qtile                           |
| powershell | I need this for my work, sadly enough          |
| qtile      | My current dynamic tiling window manager       |
| redshift   | Easier for the eyes, especially in the evening |
| rofi       | Build menus for qtile                          |
| starship   | A nice prompt with lots of info                |
| terminator | Yet another terminal emulator                  |
| yazi       | A cool CLI filemanager written in Rust         |
| zed        | My favourite code editor (IDE)                 |

## License

[GPL](https://choosealicense.com/licenses/gpl/)
