return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"linux-cultist/venv-selector.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local util = require("lspconfig.util")
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

		-- ===== Capabilities for nvim-cmp =====
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- ===== Diagnostic signs & config =====
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
				signs = diagnostics_visible,
				underline = diagnostics_visible,
				update_in_insert = not diagnostics_visible,
			})
		end

		vim.keymap.set("n", "<leader>ld", ToggleInlineDiagnostics, { desc = "Toggle inline diagnostics" })

		-- ===== Neodev for Lua =====
		require("neodev").setup({ library = { vimruntime = true, types = true } })

		-- ===== LSP setups =====
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- ===== Python LSP (Pyright) with dynamic venv =====
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function()
				local python_path = require("venv-selector").python() or "python3"

				lspconfig.pyright.setup({
					capabilities = capabilities,
					root_dir = util.root_pattern(".git", "main.py"),
					before_init = function(_, config)
						config.settings = config.settings or {}
						config.settings.python = config.settings.python or {}
						config.settings.python.pythonPath = python_path
					end,
				})
			end,
		})
	end,
}
