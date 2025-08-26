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

		-- ===== DAP UI setup =====
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

		-- ===== Python interpreter =====
		local python_path = venv_selector.python() or "python3"
		dap_python.setup(python_path)

		-- ===== Python-only keymaps =====
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function()
				local map = vim.keymap.set

				-- Base debugging
				map("n", "<F5>", dap.continue, { desc = "continue", noremap = true, silent = true })
				map("n", "<F9>", dap.toggle_breakpoint, { desc = "toggle breakpoint", noremap = true, silent = true })
				map("n", "<F10>", dap.step_over, { desc = "step over", noremap = true, silent = true })
				map("n", "<F11>", dap.step_into, { desc = "step into", noremap = true, silent = true })
				map("n", "<F12>", dap.step_out, { desc = "step out", noremap = true, silent = true })
				map("n", "<leader>du", dapui.toggle, { desc = "toggle dap ui", noremap = true, silent = true })

				-- Debug tests
				map(
					"n",
					"<leader>dt",
					dap_python.test_method,
					{ desc = "debug test method", noremap = true, silent = true }
				)
				map(
					"n",
					"<leader>dc",
					dap_python.test_class,
					{ desc = "debug test class", noremap = true, silent = true }
				)
			end,
		})
	end,
}
