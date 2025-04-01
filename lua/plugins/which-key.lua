return {
	'folke/which-key.nvim',
	event = 'VimEnter',
	opts = {
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = vim.g.have_nerd_font and {}
		},

		spec = {
			{ '<Leader>s', group = ' [S]earch' },
			{ '<Leader>g', group = ' [G]oto' },
			{ '<Leader>t', group = '󰨚 [T]oggle' },
			{ '<Leader>c', group = ' [C]ode' },
			{ '<Leader><Tab>', group = ' [Tab]' },
	 },
	},
}
