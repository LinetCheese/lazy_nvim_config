return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	highlight = { enable = true },
	sync_install = false,
	indent = { enable = true },
	ensure_installed = { "c", "lua", "vim", "vimdoc", "go", "rust", "dart", "javascript", "html", "odin" },
}
