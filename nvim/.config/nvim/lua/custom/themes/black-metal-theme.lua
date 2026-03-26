return {
	"RRethy/nvim-base16",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		vim.cmd.colorscheme("base16-black-metal")
	end,
}
