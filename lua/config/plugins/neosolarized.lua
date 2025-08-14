return {
	"Tsuzat/NeoSolarized.nvim",
	enabled = false,
	lazy = false,
	priority = 1000,
	config = function()
		local ok_status, NeoSolarized = pcall(require, "NeoSolarized")
		if not ok_status then
			return
		end

		NeoSolarized.setup {
			style = "dark",
		}

		vim.cmd [[ colorscheme NeoSolarized ]]
	end
}
