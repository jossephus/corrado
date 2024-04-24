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
  };

  globals = {
    mapleader = ",";
    maplocalleader = ",";

  };


  
}
