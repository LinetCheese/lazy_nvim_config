require('config.lazy')

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.wo.number = true
vim.wo.relativenumber = true

-- Autocommands

-- Set up 2 spaces for tab in Python, Dart, JS, TS
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "dart", "javascript", "typescript" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.softtabstop = 2
		vim.opt.shiftwidth = 2
	end
})

-- custom shortcuts

shell_command = "zsh -ic ''"

vim.keymap.set("n", "<leader>t", function()
		-- Insert the command into command line and put the cursor
		-- inside the quotes to start typing actual shell command right
		-- away.
		vim.api.nvim_feedkeys(":!"..shell_command, "n", false)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
end, { desc = "Run interactive shell command" })
