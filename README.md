# My dotfiles 
Configuration files for Neovim, Tmux and Zsh

# Usage

## Kitty

Create a symlink between `~/.config/kitty` and `~/dotfiles/kitty`, e.g.

```zsh
ln -s ~/dotfiles/kitty ~/.config/kitty
```

## Neovim

Create a symlink between `~/.config/nvim` and `~/dotfiles/nvim`, e.g.

```zsh
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## Tmux

1. Clone Tmux Plugin Manager (TPM):

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

2. Create a symlink between `~/.config/tmux` and `~/dotfiles/tmux`, e.g.:

```zsh
# Create link
ln -s ~/dotfiles/tmux ~/.config/tmux
```

## Zsh

Antigen is required for package management. [Download it here](https://github.com/zsh-users/antigen#installation) before following the next steps

In your ~/.zshrc, add the following

```zsh
source ~/dotfiles/.zshrc
```

