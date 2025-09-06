return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local jdtls = require("jdtls")
		local util = require("lspconfig.util")

		local root_dir = util.root_pattern("build.gradle", "pom.xml", ".git")(vim.fn.getcwd()) or vim.fn.getcwd()
		local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
		local workspace_dir = vim.fn.expand("~/.local/share/jdtls-workspace/" .. project_name)
		vim.fn.mkdir(workspace_dir, "p")

		local java_home = "/usr/lib/jvm/java-24-openjdk"
		local java_cmd = java_home .. "/bin/java"

		local lombok_jar = vim.fn.glob("~/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/*/lombok-*.jar")

		local cmd = {
			java_cmd,
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xms1g",
			"-jar",
			vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
			"-configuration",
			vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_linux"),
			"-data",
			workspace_dir,
		}

		-- nvim-cmp capabilities with position encoding
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		capabilities.textDocument = capabilities.textDocument or {}
		capabilities.textDocument.positionEncoding = "utf-16"

		-- Start or attach JDTLS
		jdtls.start_or_attach({
			cmd = cmd,
			root_dir = root_dir,
			capabilities = capabilities,
			settings = {
				java = {
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },
					completion = { favoriteStaticMembers = {} },
					sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
				},
			},
			init_options = { bundles = { lombok_jar } },
		})
	end,
}
