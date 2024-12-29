return {
  "chrisgrieser/nvim-recorder",
  dependencies = "rcarriga/nvim-notify",
  keys = {
    -- these must match the keys in the mapping config below
    { "q", desc = "  Start Recording" },
    { "<localleader>q", desc = "  Play Recording" },
    { "<localleader>s", desc = "  Switch Slot" },
  },
  config = function()
    require("recorder").setup({
      slots = { "q", "a" },
      mapping = {
        startStopRecording = "q",
        playMacro = "<localleader>q",
        switchSlot = "<localleader>s",
      },
    })
  end,
}
