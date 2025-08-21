return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			version = "1.2.0",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- source for LuaSnip snippets
		"rafamadriz/friendly-snippets", -- collection of snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"kristijanhusak/vim-dadbod-completion", -- sql completion
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "luasnip" }, -- snippets from LuaSnip
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			formatting = {
				format = function(entry, vim_item)
					local source_mapping = {
						copilot = "[ Copilot]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						buffer = "[Buf]",
						path = "[Path]",
					}
					vim_item.menu = source_mapping[entry.source.name] or ("[" .. entry.source.name .. "]")
					return vim_item
				end,
			},
		})

		cmp.setup.filetype({ "sql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})
	end,
}
