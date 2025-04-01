return {
	'echasnovski/mini.nvim',
	config = function()
		require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
		require('mini.move').setup {
			mappings = {
				left = '',
				right = '',
				down = '<A-j>',
				up = '<A-k>',

				line_left = '',
				line_right = '',
				line_down = '',
				line_up = ''
			},
			options = { reindent_linewise = false }
		}
	end,
}
