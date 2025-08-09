return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
		{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	lazy = false,
	keys = {
		{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select virtual environment" },
	},
	opts = {
		notify_user_on_venv_activation = true,
	},
}
