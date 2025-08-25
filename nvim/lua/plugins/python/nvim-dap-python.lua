return {
	"mfussenegger/nvim-dap-python",
	ft = "python",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"linux-cultist/venv-selector.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		local venv_selector = require("venv-selector")

		-- Set Python interpreter (from venv or fallback)
		local python_path = venv_selector.python() or "python3"
		dap_python.setup(python_path)

		-- Configure dap-ui
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

		-- Keymaps
		local map = vim.keymap.set
		-- General debugging
		map("n", "<F5>", dap.continue)
		map("n", "<F9>", dap.toggle_breakpoint)
		map("n", "<F10>", dap.step_over)
		map("n", "<F11>", dap.step_into)
		map("n", "<F12>", dap.step_out)
		map("n", "<Leader>du", dapui.toggle) -- toggle dap-ui

		-- Python test debugging
		map("n", "<Leader>dt", dap_python.test_method) -- debug current test method
		map("n", "<Leader>dc", dap_python.test_class) -- debug current test class
	end,
}
