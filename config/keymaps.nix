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
  ];
}
