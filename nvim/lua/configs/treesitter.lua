local options = {
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"lua",
		"luadoc",
		"markdown",
		"make",
		"printf",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
		"javascript",
		"typescript",
	},

	sync_install = false,

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	additional_vim_regex_highlighting = false,
	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
