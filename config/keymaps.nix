{
  globals = {
    mapleader = ",";
    maplocalleader = ",";
  };

  keymaps = [
    {
      action = ":tabnext<cr>";
      key = "<Leader>tn";
      options = {
        silent = true;
      };
    }

    # vim.keymap.set("n", "<Leader><space>", ":nohlsearch<CR>", { silent = true })
    {
      action = ":nohlsearch<cr>";
      key = "<Leader><space>";
      options = {
        silent = true;
      };
    }

    #	vim.keymap.set("n", "-", ":Neotree focus<cr>")
    {
      action = ":Neotree focus<cr>";
      key = "-";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>:Bdelete<cr>";
      key = "][";
      options = {
        silent = true; 
      };
    }
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
}
