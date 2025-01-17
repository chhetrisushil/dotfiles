return {
  "akinsho/toggleterm.nvim",
  dependencies = { "folke/which-key.nvim" },
  version = "*",
  event = "VeryLazy",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local wk = require("which-key")

    -- node terminal
    local node = Terminal:new({ cmd = "node", hidden = true, direction = "float" })
    function _NODE_TOGGLE()
      node:toggle()
    end

    -- lazydocker terminal
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })
    function _LAZYDOCKER_TOGGLE()
      lazydocker:toggle()
    end

    -- taskwarrior terminal
    local tasks = Terminal:new({ cmd = "taskwarrior-tui", hidden = true, direction = "float" })
    function _TASKS_TOGGLE()
      tasks:toggle()
    end

    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      border = "double",
    })

    wk.add({
      { "<localleader>f",  group = "+Terminal" },
      { "<localleader>ft", _TASKS_TOGGLE,      desc = "Tasks Terminal",      mode = { "n", "t" } },
      { "<localleader>fn", _NODE_TOGGLE,       desc = "Node Terminal",       mode = { "n", "t" } },
      { "<localleader>fd", _LAZYDOCKER_TOGGLE, desc = "Lazydocker Terminal", mode = { "n", "t" } },
    })
  end,
}
