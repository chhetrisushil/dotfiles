return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- test runners
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
  },
  keys = {
    {
      "<localleader>t",
      "",
      desc = "+Test",
    },
    {
      "<localleader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest Test",
    },
    {
      "<localleader>ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop Running Test",
    },
    {
      "<localleader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show Output",
    },
    {
      "<localleader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<localleader>tS",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<localleader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run File (Neotest)",
    },
    {
      "<localleader>tF",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Run All Test Files (Neotest)",
    },
    {
      "<localleader>tn",
      function()
        require("neotest").jump.next({ status = "failed" })
      end,
      desc = "Next Failed Test",
    },
    {
      "<localleader>tN",
      function()
        require("neotest").jump.prev({ status = "failed" })
      end,
      desc = "Prev Failed Test",
    },
    {
      "<localleader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run Last Test",
    },
    {
      "<localleader>tL",
      function()
        require("neotest").run.run_last({ strategy = "dap" })
      end,
      desc = "Debug Last Test",
    },
    {
      "<localleader>tw",
      function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end,
      desc = "Toggle Watch (Neotest)",
    },
    {
      "<localleader>tW",
      function()
        require("neotest").run.run({ jestCommand = "jest --watch " })
      end,
      desc = "Run jest Watch",
    },
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest"),
        require("neotest-go")({
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-timeout=60s" },
          recursive_run = true,
        }),
        require("neotest-python"),
      },
    })
  end,
}
