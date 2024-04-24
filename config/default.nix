{
  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
    ./options.nix
    ./keymaps.nix
  ];

  colorschemes.gruvbox.enable = true;

  plugins = {
    lualine.enable = true;

    lsp = {
      enable = true;

      servers = {
        tsserver.enable = true;
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

        components = {
          name = ''
            function(config, node, state)
              local result = fc.name(config, node, state)
              if node:get_depth() == 1 and node.type ~= "message" then
                result.text = vim.fn.fnamemodify(node.path, ":t")
              end
            return result
          '';
        };
      };
    };
  };
}
