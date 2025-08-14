require('config.lazy')

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.wo.number = true
vim.wo.relativenumber = true

-- custom shortcuts

shell_command = "zsh -ic ''"

vim.keymap.set("n", "<leader>t", function()
		-- Insert the command into command line and put the cursor
		-- inside the quotes to start typing actual shell command right
		-- away.
		vim.api.nvim_feedkeys(":!"..shell_command, "n", false)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
end, { desc = "Run interactive shell command" })
