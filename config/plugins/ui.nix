{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    notifier-nvim

    (pkgs.vimUtils.buildVimPlugin {
      name = "colorful-winsep";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-zh";
        repo = "colorful-winsep.nvim";
        rev = "3aeef4102c618d5e2a116e60caabfb1d7b1980dc";
        hash = "sha256-FrcvC6r3vELY8GefuArl1Nd+wrup3WhxZ+lZI/jDshM=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "incline";
      src = pkgs.fetchFromGitHub {
        owner = "b0o";
        repo = "incline.nvim";
        rev = "3e8edbc457daab8dba087dbba319865a912be7f9";
        hash = "sha256-6DpoLjU5C/F6Wr/2exfMOaEIFGsAhAvSPxzoZo3QnV8=";
      };
    })
    scope-nvim
    limelight-vim
  ];

  plugins = {
    goyo = {
      enable = true;
    };

    lualine = {
      enable = true;
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


  };

  extraConfigLua = ''
      require('colorful-winsep').setup()
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
                  local n =
                      #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
                  if n > 0 then
                      local fg = "#"
                          .. string.format(
                              "%06x",
                              vim.api.nvim_get_hl_by_name("DiagnosticSign" .. severity, true)["foreground"]
                          )
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

     require('lualine').setup({
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
}
