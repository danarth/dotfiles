# My dotfiles
Assorted dotfiles and config files for my dev workstations/IDEs

## Usage

Clone this repo under user home. Instructions for each file are as follows:

### zsh
In your ~/.zshrc, add the following

```zsh
source ~/dotfiles/.zshrc
```

### tmux
Create a file under <user home> called  `.tmux.conf` with the following contents

```tmux
source-file ~/dotfiles/tmux.conf
```

### JetBrains IDEs
Create a file under <user home> called `.ideavimrc` with the following contents

```vim
" Windows
source C:\\Users\\<username>\\dotfiles\\vimrc.vim

" Linux/MacOS
source ~/dotfiles/vimrc.vim
```

### Visual Studio Code
VS Code doesn't support `source`-ing other settings files, so the `vscode-settings.json` file just needs to be copied over to the [platform-specific location](https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations):

* Windows `%APPDATA%\Code\User\settings.json`
* macOS `$HOME/Library/Application\ Support/Code/User/settings.json`
* Linux `$HOME/.config/Code/User/settings.json`

### Neovim

#### Language Server Protocol (LSP) Support
##### Lua
```brew install lua-language-server```
