return {
	'echasnovski/mini.nvim',
	version = '*',
	config = function()
		local statusline = require 'mini.statusline'
		statusline.setup { use_icons = true }
		local animated_cursor = require 'mini.animate'
		animated_cursor.setup {
			animated_cursor.gen_timing.linear({ duration = 100, unit = 'total' })
		}
		local minidiff = require 'mini.diff'
		minidiff.setup()
		vim.keymap.set('n', '<leader>gd', function() MiniDiff.toggle_overlay(vim.api.nvim_get_current_buf()) end,
			{ desc = 'Preview git diff hunk' })
	end
}
