-- [[ Configure plugins ]]
--



-- a lua for loop
require('lazy').setup({

	
  require('kickstart.plugins.general'),
  require('kickstart.plugins.nvim-tree'),

  -- General Stuff
	-- 'tpope/vim-fugitive',
	-- -- 'tpope/vim-rhubarb',
	-- 'nvim-tree/nvim-tree.lua',
	-- 'tpope/vim-sleuth',
	-- 'mbbill/undotree',
  require('kickstart.plugins.harpoon'),
	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	branch = "harpoon2",
	-- 	dependencies = {"nvim-lua/plenary.nvim"}
	-- },

	-- debug
  require('kickstart.plugins.debug'),
  -- 'mfussenegger/nvim-dap',
  -- 'mfussenegger/nvim-dap-python',
  -- { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },

	-- LLM shit

	{
	  "CopilotC-Nvim/CopilotChat.nvim",
	  branch = "main",
	  dependencies = {

	    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
	    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	  },
	  opts = {
	    debug = true, -- Enable debugging
	    -- See Configuration section for rest
	  },
	  -- See Commands section for default commands if you want to lazy load on them
	},
	--
  require('kickstart.plugins.copilot'),
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({})
	-- 	end,
	-- },
  require('kickstart.plugins.copilot_cmp'),
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua" },
	-- 	config = function ()
	-- 		require("copilot_cmp").setup()
	-- 	end
	-- },

  require('kickstart.plugins.avante'),
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- set this if you want to always pull the latest change
	-- 	opts = {
	-- 		provider = "copilot",
	-- 		auto_suggestions_provider = "copilot",
	-- 		-- add any opts here
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			'MeanderingProgrammer/render-markdown.nvim',
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },

	-- LSP stuff
  require('kickstart.plugins.lsp_zero'),
	 --  {
	 --  	'VonHeikemen/lsp-zero.nvim',
	 --  	lazy = false,
	 --  	branch = 'v3.x',
	 --  	dependencies = {
	 --  		{'williamboman/mason.nvim', config = true},
	 --  		{'williamboman/mason-lspconfig.nvim'},
	 -- 
	 --  		-- Autocompletion
	 --  		{'hrsh7th/cmp-nvim-lsp'},
	 --  		{'L3MON4D3/LuaSnip'},
	 --  	},
	 --  },
  require('kickstart.plugins.lspconfig'),
	--  {
	--  	'neovim/nvim-lspconfig',
	--  	dependencies = {
	--  		-- Useful status updates for LSP
	--  		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	--  		--{ 'j-hui/fidget.nvim', opts = {} },
	-- 
	--  		-- Additional lua configuration, makes nvim stuff amazing!
	--  		'folke/neodev.nvim',
	--  	},
	--  },
  require('kickstart.plugins.nvim_cmp'),
	 -- {
	 -- 	-- Autocompletion
	 -- 	'hrsh7th/nvim-cmp',
	 -- 	dependencies = {
	 -- 		-- Adds LSP completion capabilities
	 -- 		'hrsh7th/cmp-nvim-lsp',
	 -- 		'hrsh7th/cmp-path',
	 -- 	},
	 -- },
  require('kickstart.plugins.whichkey'),
	-- -- Useful plugin to show you pending keybinds.
	--  { 
	--  	'folke/which-key.nvim', 
	--  	opts = {
	--  		icons = {
	--  			-- set icon mappings to true if you have a Nerd Font
	--  			mappings = vim.g.have_nerd_font,
	--  			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
	--  			-- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
	--  			keys = vim.g.have_nerd_font and {} or {
	-- 
	--  				Up = '<Up> ',
	--  				Down = '<Down> ',
	-- 
	--  				Left = '<Left> ',
	--  				Right = '<Right> ',
	--  				C = '<C-…> ',
	--  				M = '<M-…> ',
	--  				D = '<D-…> ',
	-- 
	--  				S = '<S-…> ',
	--  				CR = '<CR> ',
	--  				Esc = '<Esc> ',
	--  				ScrollWheelDown = '<ScrollWheelDown> ',
	--  				ScrollWheelUp = '<ScrollWheelUp> ',
	--  				NL = '<NL> ',
	--  				BS = '<BS> ',
	--  				Space = '<Space> ',
	--  				Tab = '<Tab> ',
	--  				F1 = '<F1>',
	--  				F2 = '<F2>',
	-- 
	--  				F3 = '<F3>',
	--  				F4 = '<F4>',
	--  				F5 = '<F5>',
	--  				F6 = '<F6>',
	--  				F7 = '<F7>',
	--  				F8 = '<F8>',
	--  				F9 = '<F9>',
	--  				F10 = '<F10>',
	--  				F11 = '<F11>',
	--  				F12 = '<F12>',
	-- 
	--  			},
	--  		},
	-- 
	--  		-- Document existing key chains
	--  		spec = {
	-- 
	--  			{ '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
	--  			{ '<leader>d', group = '[D]ocument' },
	--  			{ '<leader>r', group = '[R]ename' },
	--  			{ '<leader>s', group = '[S]earch' },
	--  			{ '<leader>w', group = '[W]orkspace' },
	--  			{ '<leader>t', group = '[T]oggle' },
	--  			{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
	-- 
	--  		},
	--  	} 
	--  },
  require('kickstart.plugins.gitsigns'),
	--  {
	--  	-- Adds git related signs to the gutter, as well as utilities for managing changes
	--  	'lewis6991/gitsigns.nvim',
	--  	opts = {
	--  		-- See `:help gitsigns.txt`
	--  		signs = {
	--  			add = { text = '+' },
	--  			change = { text = '~' },
	--  			delete = { text = '_' },
	--  			topdelete = { text = '‾' },
	--  			changedelete = { text = '~' },
	--  		},
	--  		on_attach = function(bufnr)
	--  			local gs = package.loaded.gitsigns
	-- 
	--  			local function map(mode, l, r, opts)
	--  				opts = opts or {}
	--  				opts.buffer = bufnr
	--  				vim.keymap.set(mode, l, r, opts)
	--  			end
	-- 
	--  			-- Navigation
	--  			map({ 'n', 'v' }, ']c', function()
	--  				if vim.wo.diff then
	--  					return ']c'
	--  				end
	--  				vim.schedule(function()
	--  					gs.next_hunk()
	--  				end)
	--  				return '<Ignore>'
	--  			end, { expr = true, desc = 'Jump to next hunk' })
	-- 
	--  			map({ 'n', 'v' }, '[c', function()
	--  				if vim.wo.diff then
	--  					return '[c'
	--  				end
	--  				vim.schedule(function()
	--  					gs.prev_hunk()
	--  				end)
	--  				return '<Ignore>'
	--  			end, { expr = true, desc = 'Jump to previous hunk' })
	-- 
	--  			-- Actions
	--  			-- visual mode
	--  			map('v', '<leader>hs', function()
	--  				gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
	--  			end, { desc = 'stage git hunk' })
	--  			map('v', '<leader>hr', function()
	--  				gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
	--  			end, { desc = 'reset git hunk' })
	--  			-- normal mode
	--  			map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
	--  			map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
	--  			map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
	--  			map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
	--  			map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
	--  			map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
	--  			map('n', '<leader>hb', function()
	--  				gs.blame_line { full = false }
	--  			end, { desc = 'git blame line' })
	--  			map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
	--  			map('n', '<leader>hD', function()
	--  				gs.diffthis '~'
	--  			end, { desc = 'git diff against last commit' })
	-- 
	--  			-- Toggles
	--  			map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
	--  			map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })
	-- 
	--  			-- Text object
	--  			map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
	--  		end,
	--  	},
	--  },

  require('kickstart.plugins.moonfly_colors'),
	 -- {
	 -- 	'bluz71/vim-moonfly-colors',
	 -- 	name = "moonfly",
	 -- 	lazy = false,
	 -- 	priority = 1000,
	 -- 	config = function()
	 -- 		vim.cmd.colorscheme("moonfly")
	 -- 	end,
	 -- },

	-- "gc" to comment visual regions/lines
  require('kickstart.plugins.comment'),
	-- { 'numToStr/Comment.nvim', opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
  require('kickstart.plugins.telescope'),
	-- {
	-- 	'nvim-telescope/telescope.nvim',
	-- 	branch = '0.1.x',
	-- 	dependencies = {
	-- 		'nvim-lua/plenary.nvim',
	-- 		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- 		-- Only load if `make` is available. Make sure you have the system
	-- 		-- requirements installed.
	-- 		{
	-- 			'nvim-telescope/telescope-fzf-native.nvim',
	-- 			--       refer to the README for telescope-fzf-native for more instructions.
	-- 			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
	-- 		},
	-- 	},
	-- },
  require('kickstart.plugins.treesitter'),
	-- {
	-- 	-- Highlight, edit, and navigate code
	-- 	'nvim-treesitter/nvim-treesitter',
	-- 	dependencies = {
	-- 		'nvim-treesitter/nvim-treesitter-textobjects',
	-- 	},
	-- 	build = ':TSUpdate',
	-- },
}, {})

-- vim: ts=2 sts=2 sw=2 et
