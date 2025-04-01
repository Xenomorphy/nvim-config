return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	main = 'nvim-treesitter.configs',
	opts = {
		highlight = { enable = true },
		indent = { enable = true, disable = { 'ruby' } },
	}
}
