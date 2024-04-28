{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    impatient-nvim
    bufdelete-nvim
  ];

  plugins = {
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
      ensureInstalled = ["javascript" "typescript" "c" "lua" "rust"];
    };

    treesitter-context = {
      enable = true;
    };

    undotree = {
      enable = true;
    };

    zen-mode = {
      enable = true;
    };
  };

  keymaps = [
    {
      action = "<cmd>TroubleToggle quickfix<cr>";
      key = "<Leader>xq";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>TroubleToggle document_diagnostics<cr>";
      key = "<Leader>q";
      options = {
        silent = true;
      };
    }
    {
      action = ":Bdelete<cr>";
      key = "][";
      options = {
        silent = true;
      };
    }
  ];

  extraConfigLua = ''
    require('impatient').enable_profile()

    -- smart splits
    vim.keymap.set({'n', 't'}, '<A-h>', require('smart-splits').resize_left)
    vim.keymap.set({'n', 't'}, '<A-j>', require('smart-splits').resize_down)
    vim.keymap.set({'n', 't'}, '<A-DOWN>', require('smart-splits').resize_down)
    vim.keymap.set({'n', 't'}, '<A-k>', require('smart-splits').resize_up)
    vim.keymap.set({'n', 't'}, '<A-UP>', require('smart-splits').resize_up)
    vim.keymap.set({'n', 't'}, '<A-l>', require('smart-splits').resize_right)
  '';
}
