require('config.lazy')

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.wo.number = true
vim.wo.relativenumber = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Silence the remainders of FileExplorer autocmds that fail
-- to run due to it not existing anymore
if vim.fn.exists("#FileExplorer") == 1 then
	vim.cmd("silent! autocmd! FileExplorer *")
end

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
vim.keymap.set("n", "<leader>pv",
	function()
		require("neo-tree.command").execute({
			toggle = true,
			position = "left",
		})
	end
)
vim.keymap.set("n", "<leader>sqf", function() vim.diagnostic.setqflist() end, {})

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

-- Since netrw is disabled here - show clean buffer with Neotree
-- lua_ls somehow doesn't like that event type, despite it working
-- properly.
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		local first_arg = vim.fn.argv(0)

		if first_arg and type(first_arg) == "string" and vim.fn.isdirectory(first_arg) == 1 and vim.fn.argc() == 1 then
			local target_dir = vim.fn.fnamemodify(first_arg, ":p")
			vim.api.nvim_set_current_dir(target_dir)
			vim.cmd("bwipeout!")
			require("neo-tree.command").execute({
				action = "show",
				position = "left",
				dir = target_dir,
			})
		end
	end
})
