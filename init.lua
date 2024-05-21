vim.cmd([[
  


















































]])

-- Set up globals {{{
do
	local nixvim_globals =
		{ ["floaterm_height"] = 0.800000, ["floaterm_width"] = 0.800000, ["mapleader"] = ",", ["maplocalleader"] = "," }

	for k, v in pairs(nixvim_globals) do
		vim.g[k] = v
	end
end
-- }}}

-- Set up options {{{
do
	local nixvim_options = {
		["colorcolumn"] = "80",
		["expandtab"] = true,
		["hlsearch"] = true,
		["ignorecase"] = true,
		["incsearch"] = true,
		["mouse"] = "a",
		["number"] = true,
		["shiftwidth"] = 2,
		["showcmd"] = true,
		["smartcase"] = true,
		["smartindent"] = true,
		["softtabstop"] = 2,
		["splitbelow"] = true,
		["splitright"] = true,
		["tabstop"] = 2,
		["termguicolors"] = true,
		["title"] = true,
		["undofile"] = true,
		["wildmode"] = "longest:full,full",
		["wrap"] = true,
	}

	for k, v in pairs(nixvim_options) do
		vim.opt[k] = v
	end
end
-- }}}

vim.loader.disable()

-- Ignore the user lua configuration
vim.opt.runtimepath:remove(vim.fn.stdpath("config")) -- ~/.config/nvim
vim.opt.runtimepath:remove(vim.fn.stdpath("config") .. "/after") -- ~/.config/nvim/after
vim.opt.runtimepath:remove(vim.fn.stdpath("data") .. "/site") -- ~/.local/share/nvim/site

vim.cmd([[
  
]])
require("crates").setup({ ["null_ls"] = { ["enabled"] = true, ["name"] = "crates.nvim" } })

require("toggleterm").setup({ ["direction"] = "horizontal", ["open_mapping"] = "<Leader>`", ["size"] = 30 })

require("smart-splits").setup({})

require("zen-mode").setup({})

require("telescope").setup({ ["pickers"] = { ["find_files"] = { ["theme"] = "dropdown" } } })

local __telescopeExtensions = {}
for i, extension in ipairs(__telescopeExtensions) do
	require("telescope").load_extension(extension)
end

require("lualine").setup({ ["options"] = { ["icons_enabled"] = true } })
require("trouble").setup({ ["icons"] = false })

require("conform").setup({
	["format_on_save"] = { ["lsp_fallback"] = true, ["timeout_ms"] = 500 },
	["formatters_by_ft"] = { ["javascript"] = { { "prettier" } }, ["typescript"] = { { "prettierd" } } },
})

-- LSP {{{
do
	local __lspServers = {
		{ ["name"] = "volar" },
		{
			["extraOptions"] = {
				["filetypes"] = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				["init_options"] = {
					["plugins"] = {
						{
							["languages"] = { "vue" },
							["location"] = "/nix/store/4f6ac0fyf329waibf7aq44a6gmzc3hii--vue-typescript-plugin/lib/node_modules/@vue/typescript-plugin/",
							["name"] = "@vue/typescript-plugin",
						},
					},
				},
			},
			["name"] = "tsserver",
		},
		{
			["extraOptions"] = {
				["tailwindCss"] = {
					["classAttributes"] = {
						"class",
						"className",
						"classList",
						"ngClass",
						"enter-from-class",
						"enter-to-class",
						"enter-active-class",
						"leave-active-class",
					},
				},
			},
			["name"] = "tailwindcss",
		},
		{ ["name"] = "rust_analyzer" },
		{ ["name"] = "nil_ls" },
	}
	local __lspOnAttach = function(client, bufnr) end
	local __lspCapabilities = function()
		capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		return capabilities
	end

	local __setup = {
		on_attach = __lspOnAttach,
		capabilities = __lspCapabilities(),
	}

	for i, server in ipairs(__lspServers) do
		if type(server) == "string" then
			require("lspconfig")[server].setup(__setup)
		else
			local options = server.extraOptions

			if options == nil then
				options = __setup
			else
				options = vim.tbl_extend("keep", options, __setup)
			end

			require("lspconfig")[server.name].setup(options)
		end
	end
end
-- }}}

require("nvim-treesitter.configs").setup({ ["autotag"] = { ["enable"] = true }, ["highlight"] = { ["enable"] = true } })

require("treesitter-context").setup({})

require("sniprun").setup({ ["interpreter_options"] = { ["Rust_original"] = { ["compiler"] = "rustc" } } })

require("neo-tree").setup({})

local cmp = require("cmp")
cmp.setup({
	["formatting"] = {
		["fields"] = { "kind", "abbr", "menu" },
		["format"] = require("lspkind").cmp_format({
			["menu"] = {
				["buffer"] = "[Buffer]",
				["latex_symbols"] = "[Latex]",
				["luasnip"] = "[LuaSnip]",
				["nvim_lsp"] = "[LSP]",
				["nvim_lua"] = "[Lua]",
			},
			["mode"] = "symbol_text",
		}),
	},
	["mapping"] = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(callback)
			if cmp.visible() then
				return cmp.confirm({ select = true })
			end
			return cmp.complete()
		end, { "i", "s" }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
	},
	["performance"] = { ["debounce"] = 60, ["fetchingTimeout"] = 200, ["maxViewEntries"] = 30 },
	["sources"] = {
		{ ["name"] = "nvim_lsp" },
		{ ["name"] = "luasnip" },
		{ ["name"] = "buffer" },
		{
			["name"] = "crates",
		},
	},
	["view"] = { ["entries"] = '{\n  name = "custom",\n  selection_order = "near_cursor"\n}\n' },
	["window"] = {
		["completion"] = {
			["colOffset"] = -8,
			["sidePadding"] = 0,
			["winhighliht"] = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
		},
		["documentation"] = {
			["colOffset"] = 100,
			["sidePadding"] = 100,
			["winhighlight"] = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
		},
	},
})

require("nvim-navic").setup({})

require("bufferline").setup({
	["options"] = {
		["hover"] = { ["enabled"] = false },
		["indicator"] = { ["style"] = "underline" },
		["numbers"] = "ordinal",
		["offsets"] = {
			{ ["filetype"] = "neo-tree", ["highlight"] = "Directory", ["text"] = " ", ["text_align"] = "left" },
		},
		["separator_style"] = "slant",
		["show_buffer_icons"] = true,
		["themable"] = true,
	},
})

require("colorful-winsep").setup()
require("notifier").setup({})
require("scope").setup()

------------------
-- incline-nvim --
------------------
local function get_diagnostic_label(props)
	local icons = {
		Error = "",
		Warn = "",
		Info = "",
		Hint = "",
	}

	local label = {}
	for severity, icon in pairs(icons) do
		local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
		if n > 0 then
			local fg = "#"
				.. string.format("%06x", vim.api.nvim_get_hl_by_name("DiagnosticSign" .. severity, true)["foreground"])
			table.insert(label, { icon .. " " .. n .. " ", guifg = fg })
		end
	end
	return label
end
require("incline").setup({
	--debounce_threshold = { falling = 500, rising = 250 },
	render = function(props)
		local bufname = vim.api.nvim_buf_get_name(props.buf)
		local filename = vim.fn.fnamemodify(bufname, ":t")
		local diagnostics = get_diagnostic_label(props)
		local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "None"
		local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)

		local buffer = {
			{ filetype_icon, guifg = color },
			{ " " },
			{ filename, gui = modified },
		}

		if #diagnostics > 0 then
			table.insert(diagnostics, { "| ", guifg = "grey" })
		end
		for _, buffer_ in ipairs(buffer) do
			table.insert(diagnostics, buffer_)
		end
		return diagnostics
	end,
	window = {
		padding = 2,
		--margin = {
		--vertical = 0,
		--horizontal = 60,
		--},
		placement = {
			vertical = "top",
			horizontal = "right",
		},
		winhighlight = {
			Normal = "Function",
		},
	},
})

-------------
-- Lualine --
-------------

local colors = {
	blue = "#80a0ff",
	cyan = "#79dac8",
	black = "#080808",
	white = "#c6c6c6",
	red = "#ff5189",
	violet = "#d183e8",
	grey = "#303030",
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.black, bg = colors.black },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.black, bg = colors.black },
	},
}

require("lualine").setup({
	options = {
		theme = bubbles_theme,
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = { "filename", "branch" },
		lualine_c = { "fileformat" },
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

-------------
-- FloatTerm --
-------------
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.keymap.set("n", "<Leader><Leader>", ":FloatermToggle<CR>")
-- vim.keymap.set("n", "<ALT-`>", ":FloatermToggle<CR>")
vim.keymap.set("t", "<Leader><space>", "<C-\\><C-n>:FloatermToggle<CR>")
vim.keymap.set("t", "<Leader><Leader>", "<C-\\><C-n>:FloatermNext<CR>")
vim.keymap.set("t", "<Leader>a", "<C-\\><C-n>:FloatermNew<CR>")
vim.cmd([[
        highlight link Floaterm CursorLine
        highlight link FloatermBorder CursorLineBg
      ]])

--------------
-- ToggleTerm --
--------------
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>vrr", builtin.lsp_references, {})

vim.lsp.inlay_hint.enable(true)

require("neodev").setup()

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local fc = require("neo-tree.sources.filesystem.components")
require("neo-tree").setup({
	--position = "current",
	--dir = "%:p:h:h",
	--},
	--

	default_component_configs = {
		icon = {
			--folder_closed = " ",
			--folder_open = " ",
		},
	},
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				--require("neo-tree.sources.filesystem.components")
				--vim.api.nvim_set_current_dir(".." .. file_path)
				--require("neo-tree").close_all()
			end,
		},
	},

	visible = true,
	close_if_last_window = true,

	window = {
		width = 50,
		position = "left",
		mappings = {
			["o"] = "system_open", -- open folders in your system viewer
			["d"] = "add_directory",
			["D"] = "delete",
			["R"] = "rename",
			["h"] = "navigate_up",
			["Z"] = "expand_all_nodes",
		},
	},
	filesystem = {
		follow_current_file = { enable = true }, -- focus the currently opened file in tree
		components = {
			name = function(config, node, state)
				local result = fc.name(config, node, state)
				if node:get_depth() == 1 and node.type ~= "message" then
					result.text = vim.fn.fnamemodify(node.path, ":t")
				end
				return result
			end,
		},
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_by_name = {
				"node_modules",
			},
		},
		window = {
			mappings = {},
		},
	},
	commands = {
		system_open = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			vim.api.nvim_command(string.format("silent !xdg-open '%s' ", path))
		end,
		close_everyone_but_me = function(state) end,
	},
})

vim.cmd([[
  highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
  highlight! link NeoTreeDirectoryName NvimTreeFolderName
  highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
  highlight! link NeoTreeRootName NvimTreeRootFolder
  highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
  highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])

require("hbac").setup({
	autoclose = true,
	threshold = 4,
})
require("treesj").setup({})

vim.cmd([[
  function! ToggleGeezKeyboard()
     if &keymap !=# "geez"
         set keymap=geez
     else
         set keymap=
     endif
  endfunction

  nnoremap <Leader>g :call ToggleGeezKeyboard()<cr>
  inoremap <Leader>g <ESC>:call ToggleGeezKeyboard()<cr>i
]])

vim.keymap.set("n", "<Leader>ss", ":Silicon /mnt/c/Users/25191/Downloads/Screenshots/<cr>")
vim.g.silicon = {
	theme = "1337",
	font = "GoMono Nerd Font Mono",
	background = "#AAAAFF",
	--shadow_color = '#555555',
	--line_pad = 2,
	--pad_horiz = 80,
	--pad_vert = 100,
	--shadow_blur_radius = 0,
	--shadow_offset_x = 0,
	--shadow_offset_y = 0,
	--line_number = true,
	--round_corner = true,
	--window_controls = true,
}

require("impatient").enable_profile()

-- smart splits
vim.keymap.set({ "n", "t" }, "<A-h>", require("smart-splits").resize_left)
vim.keymap.set({ "n", "t" }, "<A-j>", require("smart-splits").resize_down)
vim.keymap.set({ "n", "t" }, "<A-DOWN>", require("smart-splits").resize_down)
vim.keymap.set({ "n", "t" }, "<A-k>", require("smart-splits").resize_up)
vim.keymap.set({ "n", "t" }, "<A-UP>", require("smart-splits").resize_up)
vim.keymap.set({ "n", "t" }, "<A-l>", require("smart-splits").resize_right)

vim.cmd([[ colorscheme horizon ]])
vim.cmd([[
  hi LspInlayHint guifg=#d8d8d8 guibg=#3E3D53
]])

-- Set up keybinds {{{
do
	local __nixvim_binds = {
		{ ["action"] = ":Neotree focus<cr>", ["key"] = "-", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{
			["action"] = "<cmd>TroubleToggle quickfix<cr>",
			["key"] = "<Leader>xq",
			["mode"] = "",
			["options"] = { ["silent"] = true },
		},
		{
			["action"] = "<cmd>TroubleToggle document_diagnostics<cr>",
			["key"] = "<Leader>q",
			["mode"] = "",
			["options"] = { ["silent"] = true },
		},
		{ ["action"] = ":Bdelete<cr>", ["key"] = "][", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = ":tabnext<cr>", ["key"] = "<Leader>tn", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = ":tabprev<cr>", ["key"] = "<Leader>tp", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = "jzz", ["key"] = "j", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = "jzz", ["key"] = "<down>", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = "kzz", ["key"] = "k", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = "kzz", ["key"] = "<up>", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = "Gzz", ["key"] = "G", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{ ["action"] = "Gzz", ["key"] = "G", ["mode"] = "", ["options"] = { ["silent"] = true } },
		{
			["action"] = ":nohlsearch<cr>",
			["key"] = "<Leader><space>",
			["mode"] = "",
			["options"] = {
				["silent"] = true,
			},
		},
	}
	for i, map in ipairs(__nixvim_binds) do
		vim.keymap.set(map.mode, map.key, map.action, map.options)
	end
end
-- }}}

vim.filetype.add({ ["extension"] = { ["v"] = "vlang" } })

vim.keymap.set("n", "[[", ":bprev<cr>", { noremap = true })
vim.keymap.set("n", "{", ":bprev<cr>", { noremap = true })
vim.keymap.set("n", "]]", ":bnext<cr>")
vim.keymap.set("n", "}", ":bnext<cr>")

-- Set up autogroups {{
do
	local __nixvim_autogroups = { ["nixvim_binds_LspAttach"] = { ["clear"] = true } }

	for group_name, options in pairs(__nixvim_autogroups) do
		vim.api.nvim_create_augroup(group_name, options)
	end
end
-- }}
-- Set up autocommands {{
do
	local __nixvim_autocommands = {
		{
			["callback"] = function()
				do
					local __nixvim_binds = {
						{
							["action"] = vim.diagnostic.goto_next,
							["key"] = "[d",
							["mode"] = "n",
							["options"] = { ["desc"] = "Go To Next", ["silent"] = false },
						},
						{
							["action"] = vim.diagnostic.goto_prev,
							["key"] = "]d",
							["mode"] = "n",
							["options"] = { ["desc"] = "Go To Previous", ["silent"] = false },
						},
						{
							["action"] = vim.lsp.buf.code_action,
							["key"] = "<leader>vca",
							["mode"] = "n",
							["options"] = { ["desc"] = "Code Action", ["silent"] = false },
						},
						{
							["action"] = vim.lsp.buf.rename,
							["key"] = "<leader>vrn",
							["mode"] = "n",
							["options"] = { ["desc"] = "Rename", ["silent"] = false },
						},
						{
							["action"] = vim.lsp.buf.workspace_symbol,
							["key"] = "<leader>vws",
							["mode"] = "n",
							["options"] = { ["desc"] = "Workspace Symbol", ["silent"] = false },
						},
						{
							["action"] = vim.lsp.buf.hover,
							["key"] = "K",
							["mode"] = "n",
							["options"] = { ["desc"] = "Hover", ["silent"] = false },
						},
						{
							["action"] = vim.lsp.buf.definition,
							["key"] = "gd",
							["mode"] = "n",
							["options"] = { ["desc"] = "Go to Definition", ["silent"] = false },
						},
					}
					for i, map in ipairs(__nixvim_binds) do
						vim.keymap.set(map.mode, map.key, map.action, map.options)
					end
				end
			end,
			["desc"] = "Load keymaps for LspAttach",
			["event"] = "LspAttach",
			["group"] = "nixvim_binds_LspAttach",
		},
	}

	for _, autocmd in ipairs(__nixvim_autocommands) do
		vim.api.nvim_create_autocmd(autocmd.event, {
			group = autocmd.group,
			pattern = autocmd.pattern,
			buffer = autocmd.buffer,
			desc = autocmd.desc,
			callback = autocmd.callback,
			command = autocmd.command,
			once = autocmd.once,
			nested = autocmd.nested,
		})
	end
end
-- }}
