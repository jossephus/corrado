{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
    nui-nvim
    nvim-web-devicons
  ];
  keymaps = [
    {
      action = ":Neotree focus<cr>";
      key = "-";
      options = {
        silent = true;
      };
    }
  ];

  plugins = {
    neo-tree = {
      enable = true;
      #defaultComponentConfigs = {
      #icon = {

      #};
      #};

      #eventHandlers = {
      #file_opened = ''
      #function(file_path)
      #end
      #'';
      #};

      #closeIfLastWindow = true;

      #window = {
      #width = 50;
      #position = "left";

      #mappings = {
      #d = "add_directory";
      #D = "delete";
      #R = "rename";
      #h = "navigate_up";
      #Z = "expand_all_nodes";
      #};

      #};
      #filesystem = {
      #followCurrentFile.enabled = false;
      #filteredItems = {
      #visible = false;
      #hideDotfiles = false;
      #hideByName = [
      #"node_modules"
      #];
      #};
      #window = {
      #mappings = {

      #};
      #};

      ##components = {
      ##name = ''
      ##function(config, node, state)
      ##local result = fc.name(config, node, state)
      ##if node:get_depth() == 1 and node.type ~= "message" then
      ##result.text = vim.fn.fnamemodify(node.path, ":t")
      ##end
      ##return result
      ##'';
      ##};
      #};
    };
  };

  extraConfigLua = ''
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
            ["Z"] = "expand_all_nodes"
    		},
    	},
    	filesystem = {
    		follow_current_file = true, -- focus the currently opened file in tree
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
  '';
}
