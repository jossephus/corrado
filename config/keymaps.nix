{
  globals = {
    mapleader = ",";
    maplocalleader = ",";
  };

  extraConfigLua = ''
    vim.keymap.set("n", "[[", ":bprev<cr>", { noremap = true })
    vim.keymap.set("n", "{", ":bprev<cr>", { noremap = true })
    vim.keymap.set("n", "]]", ":bnext<cr>")
    vim.keymap.set("n", "}", ":bnext<cr>")
  '';

  keymaps = [
    {
      action = ":tabnext<cr>";
      key = "<Leader>tn";
      options = {
        silent = true;
      };
    }
    {
      action = ":tabprev<cr>";
      key = "<Leader>tp";
      options = {
        silent = true;
      };
    }

    {
      action = "jzz";
      key = "j";
      options = {
        silent = true;
      };
    }

    {
      action = "jzz";
      key = "<down>";
      options = {
        silent = true;
      };
    }

    {
      action = "kzz";
      key = "k";
      options = {
        silent = true;
      };
    }

    {
      action = "kzz";
      key = "<up>";
      options = {
        silent = true;
      };
    }
    {
      action = "Gzz";
      key = "G";
      options = {
        silent = true;
      };
    }
    {
      action = "Gzz";
      key = "G";
      options = {
        silent = true;
      };
    }

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
