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
		local util = require("lspconfig.util")

		-- If the base project has 
		local function get_dart_path()
			local root_dir = util.root_pattern(".fvm")(vim.fn.expand("%:p:h")) or vim.fn.getcwd()
			local fvm_dart = root_dir .. "/.fvm/flutter_sdk/bin/dart"

			if vim.fn.executable(fvm_dart) == 1 then
				return fvm_dart
			else
				return "dart"
			end
		end

		lspconfig.lua_ls.setup { capabilities = capabilities }
		lspconfig.gopls.setup { capabilities = capabilities }
		lspconfig.dartls.setup {
			capabilities = capabilities,
			cmd = { get_dart_path(), "language-server", "--protocol=lsp" },
			root_dir = util.root_pattern("pubspec.yaml", ".fvm"),
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				}
			}
		}
		lspconfig.rust_analyzer.setup { capabilities = capabilities }
		lspconfig.clangd.setup { capabilities = capabilities }
		lspconfig.ts_ls.setup { capabilities = capabilities }

		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format()
		end)

		-- On save
		-- vim.api.nvim_create_autocmd('LspAttach', {
		-- 	callback = function(args)
		-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- 		if not client then return end

		-- @diagnostic disable-next-line: missing-parameter
		-- 		if client.supports_method("textDocument/formatting") then
		-- 			vim.api.nvim_create_autocmd('BufWritePre', {
		-- 				buffer = args.buf,
		-- 				callback = function()
		-- 					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
		-- 				end,
		-- 			})
		-- 		end
		-- 	end
		-- })
	end,
}
