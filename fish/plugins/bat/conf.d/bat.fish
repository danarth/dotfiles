if command -q bat
  set -gx BAT_THEME_DARK "Catppuccin Frappe"

  # Customise MANPAGER for pretty man pages
  set -x MANPAGER "sh -c 'sed \"s/.\\\x08//g\" | bat -l man -p'"

  # Automatically pipe commands with --help or -h to bat
  abbr -a --position anywhere -- --help '--help | bat -plhelp'
  abbr -a --position anywhere -- -h '-h | bat -plhelp'
end
