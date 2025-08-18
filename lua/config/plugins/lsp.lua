return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	config = function()
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup { capabilities = capabilities }
		lspconfig.gopls.setup { capabilities = capabilities }
		lspconfig.dartls.setup { capabilities = capabilities }
		lspconfig.rls.setup { capabilities = capabilities }
		lspconfig.cland.setup { capabilities = capabilities }
		lspconfig.ts_ls.setup { capabilities = capabilities }

	end,
}
