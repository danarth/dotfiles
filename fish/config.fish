if set -q NVIM; and command -q nvr
  set -gx GIT_EDITOR "nvr -cc split --remote-wait"
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

fish_config theme choose duskfox
