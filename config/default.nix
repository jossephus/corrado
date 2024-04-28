{pkgs, ...}: 
{
  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
    ./options.nix
    ./keymaps.nix
  ];

  #colorschemes.catppuccin.enable = true;

  extraPlugins = with pkgs.vimPlugins; [
    scope-nvim
    limelight-vim
    plenary-nvim
    neodev-nvim
    treesj
    nerdcommenter
    lexima-vim
    vim-visual-multi
    impatient-nvim
    bufdelete-nvim
    (pkgs.vimUtils.buildVimPlugin {
      name = "horizon-nvim";
      src = pkgs.fetchFromGitHub {
          owner = "LunarVim";
          repo = "horizon.nvim";
          rev = "f7c758f0ebd47a72dd2832a8744340e72dad62f8";
          hash = "sha256-KkjHPjcKBkW3BtIGc9kPxA5GBKr2/B6ULoEK5VSCpe8=";
      };
    })
  ];

  extraConfigLua = ''
    require('scope').setup()
    require('neodev').setup()
    require('treesj').setup()
    require('impatient').enable_profile()

    vim.cmd([[ colorscheme horizon ]])

    vim.cmd([[
      highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
      highlight! link NeoTreeDirectoryName NvimTreeFolderName
      highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
      highlight! link NeoTreeRootName NvimTreeRootFolder
      highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
      highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
    ]])

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>vrr", builtin.lsp_references, {})



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


  '';

  plugins = {
    conform-nvim = {
      enable = true;

      formattersByFt = {
        javascript = [ [ "prettier" ] ];
        typescript = [ [ "prettierd" ] ];
      };

      formatOnSave =  {
        lspFallback = true; 
        timeoutMs = 500;
      };
    };

    rainbow-delimiters = {
      enable = true;
    };

    smart-splits = {
      enable = true; 
    };

    trouble = {
      enable = true;
      settings = {
        icons = false;
      };
    };

    treesitter = {
      enable = true; 
      ensureInstalled = [ "javascript" "typescript" "c" "lua" "rust" ];
    };

    undotree = {
      enable = true;
    };

    zen-mode = {
      enable = true;
    };

    #indent-blankline = {
      #enable = true;
    #};

    surround = {
      enable = true;
    };

    ts-autotag = {
      enable = true;
    };

    navic = {
      enable = true;
    };

    lualine = {
      enable = true; 
      #theme = ''
        #local colors = {
          #blue = "#80a0ff",
          #cyan = "#79dac8",
          #black = "#080808",
          #white = "#c6c6c6",
          #red = "#ff5189",
          #violet = "#d183e8",
          #grey = "#303030",
        #}
        #normal = {
          #a = { fg = colors.black, bg = colors.violet },
          #b = { fg = colors.white, bg = colors.grey },
          #c = { fg = colors.black, bg = colors.black },
        #}
      #'';
      #componentSeparators = {
        #left = "|";
        #right = "|";
      #};
      #sectionSeparators = {
        #left = "";
        #right = "";
      #};
      #inactiveSections = {
        #lualine_a = [ "filename" ];
        #lualine_b = [];
        #lualine_c = [];
        #lualine_x = [];
        #lualine_y = [];
        #lualine_z = [];
      #};
      #tabline = {};
      #sections = {
        #lualine_a = [
          #{
            #name = "mode";
            #separator.left = "";
            ##padding.left = 2;
          #}
        #];
        #lualine_b = [ "filename" "branch" ];
        #lualine_c = [ "fileformat" ];
        #lualine_x = [  ];
        #lualine_y = [ "filetype" "progress" ];
        #lualine_z = [
           #{
             #name = "location";
             #separator.right = "";
             ##padding.left = 2;
           #}
        #];
      #};
    };

    lsp = {
      enable = true;

      servers = {
        tsserver = {
          enable = true;
        };
        volar = {
          enable = true;
          filetypes = [
             "typescript"  "javascript" "javascriptreact" "typescriptreact" "vue"
          ];
          #extraOptions = {
            #typescript = {
              #preferences = {
                #importModuleSpecifiers = "non-relative";
              #};
            #};
          #};
        };

        tailwindcss = {
          enable = true;
          extraOptions = {
            tailwindCss = {
              classAttributes = [
                  "class"
                  "className"
                  "classList"
                  "ngClass"
                  "enter-from-class"
                  "enter-to-class"
                  "enter-active-class"
                  "leave-active-class"
              ];
            };
          };
        };
      };
      keymaps = {
        diagnostic = {
          "[d" = {
            action = "goto_next";
            desc = "Go To Next";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Go To Previous";
          };
        };

        lspBuf = {
          gd = {
            action = "definition";
            desc = "Go to Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>vws" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>vrn" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader>vca" = {
            action = "code_action";
            desc = "Code Action";
          };
        };
      };
    };

    lspkind = {
      enable = true;
      mode = "symbol_text";
      cmp.menu = {
        buffer = "[Buffer]";
        nvim_lsp = "[LSP]";
        luasnip = "[LuaSnip]";
        nvim_lua = "[Lua]";
        latex_symbols = "[Latex]";
      };
    };

    cmp = {
      enable = true;
      settings = {
        #autoEnableSources = true; 
        #experimental = { ghost_text = true; };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        formatting = {
          fields = ["kind" "abbr" "menu"];
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "crates"; }
        ];

        view = {
          entries = ''
              { 
                name = "custom", 
                selection_order = "near_cursor" 
              }
          '';
        };

        mapping = {
          "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
          "<Up>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
          "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
          "<Down>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = ''
            cmp.mapping(function(callback)
                if cmp.visible() then 
                  return cmp.confirm({ select = true })
                end 
                return cmp.complete()
            end, { "i", "s" })
          '';
          "<S-Tab>" = "cmp.mapping.confirm({ select = true })";
          "<cr>" = "cmp.mapping.confirm({ select = true })";
        };

        window = {
          completion = {
            winhighliht = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search";
            colOffset = -8;
            sidePadding = 0;
          };
          documentation = {
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search";
            colOffset = 100;
            sidePadding = 100;
          };
        };
      };
    };

    floaterm = {
      enable = true;

      width = 0.8;

      height = 0.8;

      keymaps = {
        toggle = "<Leader><Leader>";
      };
    };

    toggleterm = {
      enable = true;
      settings = {
        open_mapping = "'<Leader>`'";
        size = 30;
        direction = "horizontal";
      };
    };

    bufferline = {
      enable = true;

      themable = true; 
      separatorStyle = "slant";

      indicator = {
        style = "underline";
      };

      showBufferIcons = true;
      numbers = "ordinal";

      offsets = [
        {
          filetype = "neo-tree";
          text = " ";
          highlight = "Directory";
          text_align = "left";
        }
      ];
    };

    goyo = {
      enable = true;
    };

    crates-nvim = {
      enable = true;

      extraOptions = {
        null_ls = {
          enabled = true;
          name = "crates.nvim";
        };
      };
    };

    telescope = {
      enable = true;
      settings = {
        pickers = {
          find_files = {
              theme = "dropdown";
          };
        };
      };
    };

    neo-tree = {
      enable = true;

      defaultComponentConfigs = {
        icon = {

        };
      };

      eventHandlers = {
        file_opened = ''
          function(file_path)
          end
        '';
      };

      closeIfLastWindow = true;

      window = {
				width = 50;
				position = "left";

        mappings = {
          d = "add_directory";
          D = "delete";
					R = "rename";
					h = "navigate_up";
          Z = "expand_all_nodes";
        };

      };
      filesystem = {
        followCurrentFile.enabled = false;
        filteredItems = {
        	visible = false;
					hideDotfiles = false;
					hideByName = [
						"node_modules"
					];
        };
        window = {
          mappings = {

          };
        };

        #components = {
          #name = ''
            #function(config, node, state)
              #local result = fc.name(config, node, state)
              #if node:get_depth() == 1 and node.type ~= "message" then
                #result.text = vim.fn.fnamemodify(node.path, ":t")
              #end
            #return result
          #'';
        #};
      };
    };
  };
}
