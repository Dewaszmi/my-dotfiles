return {
	"linux-cultist/venv-selector.nvim",
	ft = "python",
	config = function()
		local venv_selector = require("venv-selector")

		-- Automatically switch Python interpreter for LSP & DAP
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function()
				-- Change Python path dynamically for DAP
				local python_path = venv_selector.python() or vim.fn.exepath("python3")
				local dap_python = require("dap-python")
				dap_python.setup(python_path)

				-- Optional: show venv in statusline
				vim.opt.statusline:append(" [" .. venv_selector.name() .. "] ")
			end,
		})
	end,
}
