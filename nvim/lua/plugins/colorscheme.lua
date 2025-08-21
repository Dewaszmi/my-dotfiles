return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			saturation = 0.8,
			italic_comments = true,
		})
		vim.cmd("colorscheme cyberdream")
	end,
}
