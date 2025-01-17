local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    {
      "microsoft/vscode-js-debug",
      opt = true,
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
    --[[ {
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("dap-vscode-js").setup({
					-- Path of node executable. Defaults to $NODE_PATH, and then "node"
					-- node_path = "node",

					-- Path to vscode-js-debug installation.
					debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

					-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
					-- debugger_cmd = { "js-debug-adapter" },

					-- which adapters to register in nvim-dap
					adapters = {
						"chrome",
						"pwa-node",
						"pwa-chrome",
						"pwa-msedge",
						"pwa-extensionHost",
						"node-terminal",
					},

					-- Path for file logging
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

					-- Logging level for output to file. Set to false to disable logging.
					-- log_file_level = false,

					-- Logging level for output to console. Set to false to disable console output.
					-- log_console_level = vim.log.levels.ERROR,
				})
			end,
		}, ]]
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local wk = require("which-key")

    -- setup language and adapters
    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.resolve(
              vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
            ),
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          name = "Launch file",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          args = { "${file}" },
          sourceMaps = true,
          sourceMapPathOverrides = {
            ["./*"] = "${workspaceFolder}/src/*",
          },
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          name = "Attach",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          name = "Debug Jest Tests",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "node",
          runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest", "--runInBand" },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          -- args = {'${file}', '--coverage', 'false'},
          -- sourceMaps = true,
          -- skipFiles = {'<node_internals>/**', 'node_modules/**'},
        },
        {
          name = "Debug Vitest Tests",
          type = "pwa-node",
          request = "launch",
          cwd = vim.fn.getcwd(),
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          args = { "run", "${file}" },
          autoAttachChildProcesses = true,
          smartStep = true,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        -- Debug web applications (client side)
        {
          name = "Launch & Debug Chrome",
          type = "pwa-chrome",
          request = "launch",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },

          -- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
          -- To test how it behaves
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMapPathOverrides = {
            ["./*"] = "${workspaceFolder}/src/*",
          },
        },
        {
          name = "----- ↓ launch.json configs ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end

    -- breakpoint icons and colors
    vim.cmd("hi DapColor guifg=#fa4848")
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapColor", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "c", texthl = "DapColor", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapColor", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DapColor", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DapColor", linehl = "", numhl = "" })

    -- Setup
    dapui.setup()
    require("dap-go").setup()
    require("nvim-dap-virtual-text").setup()

    -- Listeners
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Keymaps
    wk.add({
      { "<leader>dt", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
      {
        "<leader>dT",
        function()
          dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Toggle Conditional Breakpoint",
      },
      { "<leader>dc", dap.continue,          desc = "Continue" },
      {
        "<leader>d?",
        function()
          dapui.eval(nil, { enter = true })
        end,
        desc = "Eval",
      },
      {
        "<leader>da",
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            local dap_vscode = require("dap.ext.vscode")
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    })
  end,
}
