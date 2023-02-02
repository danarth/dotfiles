# Vim config

This vim config aims to be cross-compatible between different implementations of vim where possible.

## JetBrains IDEs
Create a file under user home called `.ideavimrc` with the following contents

```vim
" Windows
source C:\\Users\\<username>\\dotfiles\\init.vim

" Linux/MacOS
source ~/dotfiles/init.vim
```


## Vim

In `~/.vimrc`, `source` the `init.vim` file, e.g.:

```vim
source  ~/dotfiles/init.vim
```

Make sure that [Vim Plug](https://github.com/junegunn/vim-plug#installation) is installed, then, run `:PlugInstall` to install all plugins

## Neovim

Follow the same instructions as above, but as I start to put more and more config in lua, add the following line the `init.vim` that is created for Neovim:

```vim
luafile ~/dotfiles/vim/init.lua
```

TODO: Original instructions came from migrating from Vim to Neovim. This needs cleaning up as Neovim is becoming more and more my primary tool #3

## Visual Studio Code

VS Code doesn't support `source`-ing other settings files, so the `vscode-settings.json` file just needs to be copied over to the [platform-specific location](https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations):

* Windows `%APPDATA%\Code\User\settings.json`
* macOS `$HOME/Library/Application\ Support/Code/User/settings.json`
* Linux `$HOME/.config/Code/User/settings.json`

