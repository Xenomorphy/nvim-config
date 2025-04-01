return {
	'folke/noice.nvim',
	event = "VeryLazy",
	config = function()
		require('noice').setup({
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		})
		require('notify').setup({
			background_colour = "#000000",
		})
	end,
	opts = {},
	dependencies = {
		'MunifTanjim/nui.nvim',
		'rcarriga/nvim-notify',
	},
}
