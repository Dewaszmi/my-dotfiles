return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"linux-cultist/venv-selector.nvim",
		"folke/neodev.nvim",
	},
	config = function()
		local keymap = vim.keymap

		-- ===== LSP keymaps =====
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ desc = "Go to definition", buffer = ev.buf }
				)
				keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
				keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					{ desc = "Go to implementations", buffer = ev.buf }
				)
				keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ desc = "Go to type definitions", buffer = ev.buf }
				)
				keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					{ desc = "Show references", buffer = ev.buf }
				)
				keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ desc = "Code action", buffer = ev.buf }
				)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = ev.buf })
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ desc = "Buffer diagnostics", buffer = ev.buf }
				)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics", buffer = ev.buf })
				keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", buffer = ev.buf })
				keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", buffer = ev.buf })
				keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs", buffer = ev.buf })
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", buffer = ev.buf })
			end,
		})

		-- Hover
		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	group = vim.api.nvim_create_augroup("LspAttach_Hover", {}),
		-- 	callback = function(ev)
		-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
		-- 	end,
		-- })

		-- Diagnostic signs
		local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
		local sign_defs = {}
		for type, icon in pairs(signs) do
			sign_defs[type] = { text = icon, texthl = "Diagnostic" .. type }
		end

		local diagnostics_visible = true

		vim.diagnostic.config({
			signs = sign_defs,
			virtual_text = { prefix = "●", spacing = 2 },
			underline = true,
			update_in_insert = false,
		})

		function ToggleInlineDiagnostics()
			diagnostics_visible = not diagnostics_visible
			vim.diagnostic.config({
				virtual_text = diagnostics_visible and { prefix = "●", spacing = 2 } or false,
			})
		end

		vim.keymap.set("n", "<leader>ld", ToggleInlineDiagnostics, { desc = "Toggle inline diagnostics" })

		-- Language config
		local lspconfig = require("lspconfig")

		-- Lua
		require("neodev").setup({
			library = { plugins = true },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")
	end,

	-- Python
	-- (configured in mason.lua to avoid double attachment issues)
}
