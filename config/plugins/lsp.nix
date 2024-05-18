{pkgs, volar-package, ...}: {
  extraConfigLua = ''
    vim.lsp.inlay_hint.enable(true);
  '';
  plugins = {
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
    lsp = {
      enable = true;
      servers = {
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };

        tsserver = {
          enable = true;
          filetypes = [ "typescript" "javascript" "javascriptreact" "typescriptreact" ];
          extraOptions = {
            init_options = {
              plugins = [
                 {
                   name = "@vue/typescript-plugin";
                   location = "${volar-package}/bin/vue-language-server";
                   languages = [ "vue" ];
                 }
              ];
            };
          };
        };
        volar = {
          enable = true;
          #filetypes = [ "typescript" "javascript" "javascriptreact" "typescriptreact" "vue" ];
          package = volar-package;
          #extraOptions = {
            #init_options = {
              #vue = {
                #hybridMode = false;
              #};
            #};
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
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "buffer";}
          {name = "crates";}
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
  };
}
