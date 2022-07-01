# IDE Config Files
Settings files containing Vim keybindings for various IDEs that allow me to have a consistent developer experience

## Usage

### JetBrains IDEs
1. Clone this repo
2. Create a file under <user home> called `.ideavimrc`
3. In this file, have a line that `source`'s the `.ideavimrc` file in this repo, e.g.

```vimscript
source C:\\Users\\<username>\\ide-config\\.ideavimrc
```

### Visual Studio Code
VS Code doesn't support `source`-ing other settings files, so the `vscode-settings.json` file just needs to be copied over to the [platform-specific location](https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations):

* Windows `%APPDATA%\Code\User\settings.json`
* macOS `$HOME/Library/Application\ Support/Code/User/settings.json`
* Linux `$HOME/.config/Code/User/settings.json`
