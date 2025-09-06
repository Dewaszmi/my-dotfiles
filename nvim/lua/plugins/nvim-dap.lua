return {
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-jdtls", -- Java debugger
	lazy = true,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup DAP UI
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Java Adapter
		dap.adapters.java = function(callback, config)
			callback({
				type = "server",
				host = "127.0.0.1",
				port = config.port,
			})
		end

		-- Java Launch Config
		dap.configurations.java = {
			{
				type = "java",
				request = "launch",
				name = "Launch Java Program",
				mainClass = "${file}",
				projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
			},
		}

		-- Keymaps for debugging
		local keymap = vim.keymap
		keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
		keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
		keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
		keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
		keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open DAP REPL" })
	end,
}
