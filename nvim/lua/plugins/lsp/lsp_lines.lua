return {
	"ErichDonGubler/lsp_lines.nvim",
	config = function()
		require("lsp_lines").setup()
		vim.diagnostic.config({
			virtual_text = false,
		})

		-- Toggle keymap
		vim.keymap.set("", "<leader>lspl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				pcall(require("lsp_lines").refresh)
			end,
		})
	end,
}
