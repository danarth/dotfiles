#!/bin/bash

THISDIR=$(dirname -- "$(readlink -f -- "$0";)";)
CONFIG_HOME="$HOME/.config"

function is_symlink_to {  
  if [[ -L "$2" ]]; then  
    if [[ "$(readlink -f "$2")" == "$(readlink -f "$1")" ]]; then  
      return 0  
    fi  
  fi  
  return 1  
}  

#######################################
# Link a config dir from dotfiles to the user's home directory
# Arguments:
#   $1: The path of the config directory in the dotfiles directory
#   $2: The path of the config directory in the user's home directory
#######################################
function link_config {
  if is_symlink_to "$THISDIR/$1" "$CONFIG_HOME/$2"; then
    echo -e "Already linked $1 config. Skipping..."
  elif [[ -d "$CONFIG_HOME/$2" ]]; then
    echo -e "$CONFIG_HOME/$2 already exists. Remove it before continuing. Skipping for now..."
    return
  else
    ln -s "$THISDIR/$1" "$CONFIG_HOME/$2"
    echo -e "Linked $1 config ($THISDIR/$1 -> $CONFIG_HOME/$2)"
  fi
}

function kitty {
  link_config terminals/kitty kitty
}

function ghostty {
  link_config terminals/ghostty ghostty
}

function nvim {
  link_config nvim nvim
}

function tmux {
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo -e "Installing Tmux Plugin Manager (tpm)..."
    mkdir -p "$HOME/.tmux/plugins"
    git clone --depth=1 "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm" &> /dev/null
  fi
  link_config tmux tmux
}

function zsh {
  if [[ ! -d "$HOME/antigen" ]]; then
    echo -e "Installing Antigen package manager..."
    mkdir -p "$HOME/antigen"
    curl -L git.io/antigen > "$HOME/antigen/antigen.zsh"
  fi
}

function help {
  echo -e "Usage: $0 [command] [options]"
  echo -e ""
  echo -e "This script runs any setup steps required for dotfiles in this repository"
  echo -e ""
  echo -e "Commands:"
  echo -e "  setup kitty    Setup kitty terminal configuration"
  echo -e "  setup ghostty  Setup ghostty terminal configuration"
  echo -e "  setup nvim     Setup Neovim configuration"
  echo -e "  setup tmux     Setup Tmux configuration with Tmux Plugin Manager (TPM)"
  echo -e "  setup zsh      Setup Zsh configuration with Antigen package manager"
  echo -e ""
  echo -e "Options:"
  echo -e "  -h, --help     Show this help message and exit"
}

case "$1" in
  setup)
    case "$2" in
      kitty)
        kitty
        ;;
      ghostty)
        ghostty
        ;;
      nvim)
        nvim
        ;;
      tmux)
        tmux
        ;;
      zsh)
        zsh
        ;;
      *)
        echo -e "Invalid setup command: $2"
        exit 1
        ;;
    esac
    ;;
  -h|--help)
    help
    ;;
  *)
    exit 1
    ;;
esac
