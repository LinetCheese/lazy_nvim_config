require('config.lazy')

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.wo.number = true
vim.wo.relativenumber = true

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
-- Keep the cursor position
vim.g.netrw_fastbrowse = 2

-- Setting up harpoon
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)

-- Setting up telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", telescope.find_files, {})
vim.keymap.set("n", "<leader>ps", function() telescope.grep_string({ search = vim.fn.input("Grep > ") }) end, {})

-- Misc shortcuts
vim.keymap.set("n", "<leader>pv", vim.cmd.Rexplore)

-- Autocommands

-- Set up 2 spaces for tab in Python, Dart, JS, TS
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "dart", "javascript", "typescript", "typescriptreact" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype == "netrw" then
			vim.opt_local.colorcolumn = ""
		elseif vim.bo.filetype == "dart" then
			vim.opt_local.colorcolumn = "120"
		else
			vim.opt_local.colorcolumn = "80"
		end
	end
})
