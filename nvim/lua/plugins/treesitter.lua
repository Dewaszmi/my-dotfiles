return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- enable rainbow parentheses
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = 1000,
			},
			-- fold code blocks
			fold = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"python",
				"java",
				"sql",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"dockerfile",
				"gitignore",
				"markdown",
				"markdown_inline",
				"tmux",
				"sway",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-s>",
					node_incremental = "<C-s>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
