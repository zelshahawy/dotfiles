return {
	"mfussenegger/nvim-dap",
	keys = {
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "[D]ebug: Start/[C]ontinue",
		},
		{
			"<leader>dq",
			function()
				require("dap").close()
				require("dapui").close() -- sometimes the event doesn't fire??
			end,
			desc = "[D]ebug: [Q]uit",
		},
		{
			"<leader>dsi",
			function()
				require("dap").step_into()
			end,
			desc = "[D]ebug: [S]tep [I]nto",
		},
		{
			"<leader>dso",
			function()
				require("dap").step_over()
			end,
			desc = "[D]ebug: [S]tep [o]ver",
		},
		{
			"<leader>dsO",
			function()
				require("dap").step_out()
			end,
			desc = "[D]ebug: [S]tep [O]ut",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "[D]ebug: Toggle [b]reakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "[D]ebug: Set [B]reakpoint",
		},
	},
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		{
			"rcarriga/nvim-dap-ui",
			opts = {
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			},
			keys = {
				{
					"<leader>dls",
					function()
						require("dapui").toggle()
					end,
					desc = "[D]ebug: See [l]ast [s]ession result.",
				},
			},
		},

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",

		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			automatic_installation = false,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup()

		-- C/C++/Rust debugging using lldb
		dap.adapters.lldb = {
			type = "executable",
			command = "/opt/homebrew/opt/llvm@12/bin/lldb-vscode",
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					---@diagnostic disable-next-line: redundant-parameter
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				runInTerminal = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
	end,
}
