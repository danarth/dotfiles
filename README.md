# My dotfiles 
Configuration files for Neovim, Tmux and Zsh

# Usage

## Neovim

Create a symlink between `~/.config/nvim` and `~/dotfiles/nvim`, e.g.

```zsh
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## Tmux

Create a file under user home called  `.tmux.conf` with the following contents:

```tmux
# Set tmux terminal and enable True Colour
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# General tmux config and key bindings
source-file ~/dotfiles/tmux/tmux.conf

# Optional Nightfox theme to match tmux theme with Neovim
source-file ~/dotfiles/tmux/nightfox.tmux
```

## Zsh

Antigen is required for package management. [Download it here](https://github.com/zsh-users/antigen#installation) before following the next steps

In your ~/.zshrc, add the following

```zsh
source ~/dotfiles/.zshrc
```

