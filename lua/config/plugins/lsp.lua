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

		-- Custom/external formatters
		local util = require("lspconfig.util")
		require("conform").setup({
			formatters_by_ft = {
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				svelte = { "prettier" },
			},
		})

		local conform = require("conform")

		local ft_for_tailwindcss = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue",
			"svelte" }

		vim.lsp.config("*", { capabilities = capabilities })

		-- Dart/Flutter instead uses flutter-tools.nvim configuration.
		require("flutter-tools").setup {
			ui = {
				notification_model = "nvim-notify",
			},
			decorations = {
				statusline = {
					device = true,
					app_version = true,
				},
			},
			capabilities = capabilities,
			root_dir = util.root_pattern("pubspec.yaml"),
			settings = {
				showTodos = true,
				completeFunctionCalls = false,
				suggestFromUnimportedLibraries = true,
			},
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			pattern = "dart",
			callback = function(ev)
				vim.lsp.document_color.enable(true, { bufnr = ev.buf })
			end
		})


		vim.lsp.config("ts_ls", {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end
		})

		vim.lsp.config("tailwindcss", {
			filetypes = ft_for_tailwindcss,
		})

		local servers = {
			"lua_ls",
			"gopls",
			"dartls",
			"rust_analyzer",
			"clangd",
			"tailwindcss",
			"ts_ls",
			"ols",
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end

		vim.keymap.set("n", "<leader>f", function()
			local custom_format_fts = { ft_for_tailwindcss }
			local use_conform = vim.iter(custom_format_fts)
				:flatten()
				:any(function(v) return v == vim.bo.filetype end)

			if use_conform then
				conform.format({ async = true })
			else
				vim.lsp.buf.format { async = true }
			end
		end)

		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
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
