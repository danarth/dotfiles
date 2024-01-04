local keymap = require('core.keymap')
local nmap, vmap = keymap.nmap, keymap.vmap

nmap({
  {
    "<C-a>", function()
      require("dial.map").manipulate("increment", "normal")
    end
  },
  {
    "<C-x>", function()
      require("dial.map").manipulate("decrement", "normal")
    end
  },
  {
    "g<C-a>", function()
      require("dial.map").manipulate("increment", "gnormal")
    end
  },
  {
    "g<C-x>", function()
      require("dial.map").manipulate("decrement", "gnormal")
    end
  }
})

vmap({
  {
    "<C-a>", function()
      require("dial.map").manipulate("increment", "visual")
    end
  },
  {
    "<C-x>", function()
      require("dial.map").manipulate("decrement", "visual")
    end
  },
  {
    "g<C-a>", function()
      require("dial.map").manipulate("increment", "gvisual")
    end
  },
  {
    "g<C-x>", function()
      require("dial.map").manipulate("decrement", "gvisual")
    end
  }
})
