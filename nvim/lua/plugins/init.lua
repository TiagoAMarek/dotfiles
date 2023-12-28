return {
	"xiyaowong/transparent.nvim",
	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',
	-- Useful plugin to show you pending keybinds.
	-- {
	--   "catppuccin/nvim",
	--   name = "catppuccin",
	--   opts = { integrations = { mini = true, hop = true } },
	--   priority = 1000,
	--   config = function()
	--     vim.cmd.colorscheme 'catppuccin'
	--   end,
	-- },
	{
		"lambdalisue/suda.vim"
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		-- opts = { integrations = { mini = true } },
		priority = 1000,
		init = function()
			require('kanagawa').setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				transparent = false, -- set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				theme = "dragon",  -- Load "wave" theme when 'background' option is not setlocal
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none"
							}
						}
					}
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

						-- telescope
						TelescopeTitle = { fg = theme.ui.special, bold = true },
						TelescopePromptNormal = { bg = theme.ui.bg_p1 },
						TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
						TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
						TelescopePreviewNormal = { bg = theme.ui.bg_dim },
						TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					}
				end,
			})
			vim.cmd.colorscheme 'kanagawa'
		end,
	},
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		main = "ibl",
		opts = {},
	},
	{
		"nguyenvukhang/nvim-toggler",
		event = { "User AstroFile", "InsertEnter" },
		keys = {
			{
				"<leader>i",
				desc = "Toggle CursorWord",
			},
		},
		opts = {},
	},
	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
	},
}
