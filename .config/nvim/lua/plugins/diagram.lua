return {
  "3rd/diagram.nvim",
  dependencies = {
    "3rd/image.nvim",
  },
  ft = { "markdown", "neorg" },
  config = function()
    require("diagram").setup({
      integrations = {
        require("diagram.integrations.markdown"),
        require("diagram.integrations.neorg"),
      },
      renderer_options = {
        mermaid = {
          theme = "forest",
        },
        plantuml = {
          charset = "utf-8",
        },
        d2 = {
          theme_id = 1,
        },
        gnuplot = {
          theme = "dark",
          size = "800,600",
        },
      },
    })
  end,
}
