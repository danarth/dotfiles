# My dotfiles
Assorted dotfiles and config files for my dev workstations/IDEs

## Usage

Clone this repo under user home. Instructions for each file are as follows:

### JetBrains IDEs
1. Create a file under <user home> called `.ideavimrc`
2. In this file, have a line that `source`s `vimrc.vim`

```vimscript
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
