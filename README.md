# My dotfiles
Assorted dotfiles and config files for my dev workstations/IDEs

## Usage

Clone this repo under user home. Instructions for each file are as follows:

### Git Alias

Add the following to your `.gitconfig`

```gitconfig
[include]
    path = ~/dotfiles/gitalias.txt
```

### zsh

Antigen is required for package management. [Download it here](https://github.com/zsh-users/antigen#installation) before following the next steps

In your ~/.zshrc, add the following

```zsh
source ~/dotfiles/.zshrc
```

