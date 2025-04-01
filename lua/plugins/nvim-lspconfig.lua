return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'williamboman/mason.nvim', opts = {} },
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		{ 'j-hui/fidget.nvim', opts = {} },
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				-- To jump back, press <C-t>.
				map('<Leader>gd', require('telescope.builtin').lsp_definitions, ' [G]oto [D]efinition')
				map('<Leader>gD', vim.lsp.buf.declaration, ' [G]oto [D]eclaration')
				map('<Leader>gr', require('telescope.builtin').lsp_references, ' [G]oto [R]eferences')
				map('<Leader>gI', require('telescope.builtin').lsp_implementations, ' [G]oto [I]mplementation')
				map('<Leader>gt', require('telescope.builtin').lsp_type_definitions, ' [G]oto [T]ype Definition')
				map('<Leader>r', vim.lsp.buf.rename, '󰑕 [R]ename')
				map('<Leader>ca', vim.lsp.buf.code_action, ' [C]ode [A]ction', { 'n', 'x' })
				map('<Leader>i', vim.lsp.buf.hover, ' Lsp [I]nfo')

				-- Highlight all references automatically
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd('LspDetach', {
						group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
						end,
					})
				end

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map('<Leader>th', function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
					end, '[T]oggle Inlay [H]ints')
				end
			end,
		})

		vim.diagnostic.config {
		severity_sort = true,
		float = { border = 'rounded', source = 'if_many' },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = vim.g.have_nerd_font and {
			text = {
			[vim.diagnostic.severity.ERROR] = '󰅚 ',
			[vim.diagnostic.severity.WARN] = '󰀪 ',
			[vim.diagnostic.severity.INFO] = '󰋽 ',
			[vim.diagnostic.severity.HINT] = '󰌶 ',
			},
		} or {},
		virtual_text = {
			source = 'if_many',
			spacing = 2,
			format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
			end,
		},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = 'Replace' },
						diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
			'stylua',
			})
		require('mason-tool-installer').setup { ensure_installed = ensure_installed }

		require('mason-lspconfig').setup {
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
				require('lspconfig')[server_name].setup(server)
				end,
			},
		}
	end
}
