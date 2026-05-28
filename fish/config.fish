if set -q NVIM; and command -q nvr
  set -gx GIT_EDITOR "nvr -cc split --remote-wait"
end
