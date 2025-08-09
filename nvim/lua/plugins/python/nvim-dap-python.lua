return {
	"mfussenegger/nvim-dap-python",
	ft = "python",
	dependencies = { "mfussenegger/nvim-dap", "linux-cultist/venv-selector.nvim" },
	config = function()
		local dap_python = require("dap-python")
		local venv_path = require("venv-selector").python() or "python3"
		dap_python.setup(venv_path)
	end,
}
