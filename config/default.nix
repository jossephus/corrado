{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  #colorschemes.catppuccin.enable = true;
}
