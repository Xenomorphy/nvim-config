return {
	'wstucco/c3.nvim',
	config = function()
		require('c3')
	end,
	setup = function()
		vim.filetype.add({
			extension = {
			c3 = 'c3',
			c3i = 'c3',
			c3t = 'c3',
			},
		})

		local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
		parser_config.c3 = {
			install_info = {
				url = 'https://github.com/c3lang/tree-sitter-c3',
				files = {'src/parser.c', 'src/scanner.c'},
				branch = 'main',
			}
		}

		local lspconfig = require('lspconfig.configs')
		if not lspconfig.c3_lsp then
			lspconfig.c3_lsp = {
				default_config = {
					cmd = { 'c3lsp' },
					filetypes = { 'c3', 'c3i', 'c3t' },
					root_dir = function()
						local pr_json = vim.fs.root(0, "project.json")
						if pr_json ~= nil then
							return pr_json
						end
						local git_root = vim.fs.root(0, ".git")
						if git_root ~= nil then
							return git_root
						end
						return vim.fn.getcwd()
					end,
					settings = { ['diagnostic-delay'] = 50 },
					name = 'c3_lsp'
				}
			}
		end
		require('lspconfig').c3_lsp.setup()
	end,
	recommended = {
		ft = 'c3'
	}
}
