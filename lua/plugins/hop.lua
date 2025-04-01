return {
	'smoka7/hop.nvim',
	version = "*",
	config = function()
		require('hop').setup {
			vim.keymap.set('n', '<Leader><Leader>', '<cmd>HopWord<Enter>', { desc = ' [F]ind -> Jump' })
		}
	end,
	opts = { keys = 'etovxqpdygfblzhckisuran' }
}
