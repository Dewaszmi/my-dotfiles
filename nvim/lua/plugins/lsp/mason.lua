return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Setup pyright via mason handlers to avoid double attachment
		local lspconfig = require("lspconfig")
		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "pyright" },
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = function(client, bufnr)
							local opts = { buffer = bufnr, silent = true }
							vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
							vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
							vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
							vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
						end,
					})
				end,
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"jdtls",
				"lua-language-server",
			},
		})
	end,
}
