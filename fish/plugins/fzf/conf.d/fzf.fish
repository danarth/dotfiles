if command -q fzf
  fzf --fish | source
  set -x FZF_DEFAULT_OPTS_FILE $(realpath $__fish_config_dir/../fzfrc)
end
