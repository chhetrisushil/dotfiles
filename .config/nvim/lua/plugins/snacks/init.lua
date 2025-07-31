local image_path = vim.fn.expand("$HOME/.config/nvim/lua/plugins/snacks/skull.png")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
                                                                                
               ████ ██████           █████      ██                        
              ███████████             █████                                
              █████████ ███████████████████ ███   ███████████      
             █████████  ███    █████████████ █████ ██████████████      
            █████████ ██████████ █████████ █████ █████ ████ █████      
          ███████████ ███    ███ █████████ █████ █████ ████ █████     
         ██████  █████████████████████ ████ █████ █████ ████ ██████    
                                                                               ]],
			},
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
                {
                    section = "terminal",
                    cmd = "ascii-image-converter -C -b " .. image_path,
                    random = 10,
                    pane = 2,
                    indent = 4,
                    height = 30,
                },
            },
		},
		indent = { enabled = false },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		picker = { enabled = true },
		explorer = { enabled = true },
	},
    keys = {
        {
            "<leader>sz",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>sZ",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Toggle Zoom",
        },
        {
            "<leader>s.",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>sS",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>sn",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification History",
        },
        {
            "<leader>sbd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>scR",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "<leader>sgB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>sgb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame Line",
        },
        {
            "<leader>sgf",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Lazygit Current File History",
        },
        {
            "<leader>sgg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>sgl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Lazygit Log (cwd)",
        },
        {
            "<leader>sun",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Dismiss All Notifications",
        },
        {
            "<leader>st",
            function()
                Snacks.terminal()
            end,
            desc = "Toggle Terminal",
        },
        {
            "<leader>se",
            function()
                Snacks.explorer()
            end,
            desc = "Toggle Explorer",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
        {
            "<leader>sN",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        },
        {
            "<leader>p,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>p/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>p:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>p<space>",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        -- find
        {
            "<leader>pfb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>pfc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
        {
            "<leader>pff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>pfg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>pfr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },
        -- git
        {
            "<leader>pgc",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>pgs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        -- Grep
        {
            "<leader>psb",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>psB",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>psg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>psw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        -- search
        {
            '<leader>ps"',
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>psa",
            function()
                Snacks.picker.autocmds()
            end,
            desc = "Autocmds",
        },
        {
            "<leader>psc",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>psC",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>psd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>ps<leader>ph",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>psH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Highlights",
        },
        {
            "<leader>psj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Jumps",
        },
        {
            "<leader>psk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>psl",
            function()
                Snacks.picker.loclist()
            end,
            desc = "Location List",
        },
        {
            "<leader>psM",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },
        {
            "<leader>psm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>psR",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume",
        },
        {
            "<leader>psq",
            function()
                Snacks.picker.qflist()
            end,
            desc = "Quickfix List",
        },
        {
            "<leader>puC",
            function()
                Snacks.picker.colorschemes()
            end,
            desc = "Colorschemes",
        },
        {
            "<leader>pqp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Projects",
        },
        -- LSP
        {
            "<leader>pgd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "<leader>pgr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "<leader>pgI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "<leader>pgy",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "<leader>pss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
    },
}
