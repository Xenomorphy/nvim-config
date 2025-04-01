-- Leader
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Font
vim.g.have_nerd_font = true

-- Options
vim.opt.number  = true -- Line number on the left
vim.opt.relativenumber	= true -- with relative numbers
vim.opt.cursorline		= true -- Show which line the cursor is on in the bottom right

vim.opt.updatetime	= 250 -- Update time needs to be shorter
vim.opt.timeoutlen	= 250 -- for most things

vim.opt.mouse			= 'a' -- Use mouse for resizing split windows
vim.opt.splitright	= true -- When splitting automatically
vim.opt.splitbelow	= true -- switch to the split window

vim.opt.showmode	= false -- Status line arleady shows the mode

vim.opt.scrolloff	= 10 -- Minimal number of lines to keep above and below the cursosr

vim.opt.list		= true -- Use characters to represent whitespace
vim.opt.listchars	= { tab = '» ', space = '.', trail = '·', nbsp = '␣' }

vim.opt.smartindent	= true -- Auto indent properly
vim.opt.tabstop		= 4 -- Tabs are equivalent to 4 spaces
vim.opt.shiftwidth	= 4 -- Tabs are equivalent to 4 spaces
vim.opt.softtabstop	= 4 -- Tabs are equivalent to 4 spaces
vim.opt.smarttab		= true -- Smarter tab insertion

vim.opt.linebreak		= true -- Wrap lines that are too long
vim.opt.breakindent	= true -- Wrapped lines will indent to match the line start
vim.opt.signcolumn	= 'yes' -- Sign column always exists

vim.opt.undofile	= true -- Save undo history

vim.opt.ignorecase	= true -- Ignore case when searching
vim.opt.smartcase		= true -- unless a capital letter is used

vim.opt.inccommand	= 'split' -- Preview substitutions in separate smaller window

-- Keybinds
vim.keymap.set('n', '<Left>', '<cmd>echo "USE H"<Enter>', { desc = 'Stop bad practice' })
vim.keymap.set('n', '<Right>', '<cmd>echo "USE L"<Enter>', { desc = 'Stop bad practice' })
vim.keymap.set('n', '<Up>', '<cmd>echo "USE K"<Enter>', { desc = 'Stop bad practice' })
vim.keymap.set('n', '<Down>', '<cmd>echo "USE J"<Enter>', { desc = 'Stop bad practice' })

vim.keymap.set('n', 'Q', '<Nop>', { desc = 'Remove bullshit' })

vim.keymap.set('n', '<Leader>q', '<cmd>q<Enter>', { desc = '󰈔 [Q]uit' })
vim.keymap.set('n', '<Leader>w', '<cmd>w<Enter>', { desc = '󰈔 [W]rite' })
vim.keymap.set('n', '<Leader>e', '<cmd>Ex<Enter>', { desc = ' File [E]xplorer' })
vim.keymap.set('n', '<Leader>d', vim.diagnostic.setloclist, { desc = '[D]iagnostic Quickfix' })

vim.keymap.set('n', '<Leader><Tab><Tab>', '<cmd>tabnew<Enter>', { desc = ' New [Tab]' })
vim.keymap.set('n', 'J', 'gt', { desc = ' Next [Tab]' })
vim.keymap.set('n', 'K', 'gT', { desc = ' Previous [Tab]' })

vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Center after half page movement" })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Center after half page movement" })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<Enter>', { desc = 'Clear highlights from find' })

vim.keymap.set('v', '>', '>gv', { desc = 'Increment indentation'})
vim.keymap.set('v', '<', '<gv', { desc = 'Decrement indentation'})

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight yanked text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Plugins
require('config.lazy')

-- Colorscheme
vim.cmd [[
	colorscheme retrobox
	highlight Normal guibg=none
	highlight NonText guibg=none
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
	set termguicolors
]]
