return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_x = { require("recorder").displaySlots, "encoding", "fileformat", "filetype" },
        lualine_c = {
          "filename",
          require("recorder").recordingStatus,
        },
      },
    })
  end,
}
